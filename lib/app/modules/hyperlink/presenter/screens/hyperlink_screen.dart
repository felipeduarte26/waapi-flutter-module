import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../core/constants/assets_path.dart';
import '../../../../core/enums/analytics/waapi_loading_size_enum.dart';
import '../../../../core/extension/translate_extension.dart';
import '../../../../core/widgets/empty_state_widget.dart';
import '../../../../core/widgets/waapi_colorful_header.dart';
import '../../../../core/widgets/waapi_loading_widget.dart';
import '../../../../routes/hyperlink_routes.dart';
import '../../domain/entities/hyperlink_entity.dart';
import '../../enums/hyperlink_state_enum.dart';
import '../blocs/hyperlink_bloc/hyperlink_bloc.dart';
import '../blocs/hyperlink_bloc/hyperlink_event.dart';
import '../blocs/hyperlink_bloc/hyperlink_state.dart';
import '../widgets/hyperlink_item_card_widget.dart';

class HyperlinkScreen extends StatefulWidget {
  final String employeeId;
  final String userRoleId;

  const HyperlinkScreen({
    Key? key,
    required this.employeeId,
    required this.userRoleId,
  }) : super(key: key);

  @override
  State<HyperlinkScreen> createState() {
    return _HyperlinkScreenState();
  }
}

class _HyperlinkScreenState extends State<HyperlinkScreen> {
  late final GlobalKey<FormState> _formKey;
  late ScrollController _scrollControllerListOfHyperlinks;
  late HyperlinkBloc _hyperlinkBloc;
  final TextEditingController _editingControllerSearch = TextEditingController();
  String lastTermToSearch = '';
  List<HyperlinkEntity> findedHyperlinks = [];

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _scrollControllerListOfHyperlinks = ScrollController();
    _hyperlinkBloc = Modular.get<HyperlinkBloc>();
    _hyperlinkBloc.add(
      GetHyperlinkEvent(
        employeeId: widget.employeeId,
        userRoleId: widget.userRoleId,
      ),
    );
    _editingControllerSearch.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (_, __) async => onWillPop(),
      child: Scaffold(
        body: WaapiColorfulHeader(
          onTapBack: onWillPop,
          titleLabel: context.translate.quickAccess,
          body: Scrollbar(
            controller: _scrollControllerListOfHyperlinks,
            child: BlocConsumer<HyperlinkBloc, HyperlinkState>(
              bloc: _hyperlinkBloc,
              listener: (_, state) {
                if (state is LoadedHyperlinkState && state.hyperlinksEntity.isEmpty) {
                  Modular.to.pushReplacementNamed(
                    HyperlinkRoutes.hyperlinkStateScreenInitialRoute,
                    arguments: {
                      'stateEnum': HyperlinkStateEnum.emptyState,
                    },
                  );
                }

                if (state is ErrorHyperlinkState) {
                  Modular.to.pushNamed(
                    HyperlinkRoutes.hyperlinkStateScreenInitialRoute,
                    arguments: {
                      'stateEnum': HyperlinkStateEnum.errorState,
                      'onTapTryAgain': () {
                        _hyperlinkBloc.add(
                          GetHyperlinkEvent(
                            employeeId: widget.employeeId,
                            userRoleId: widget.userRoleId,
                          ),
                        );
                      },
                    },
                  );
                }
              },
              builder: (context, state) {
                if (state is LoadedHyperlinkState &&
                    state.hyperlinksEntity.isNotEmpty &&
                    _editingControllerSearch.text.isEmpty) {
                  findedHyperlinks = state.hyperlinksEntity;
                }

                return CustomScrollView(
                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                  controller: _scrollControllerListOfHyperlinks,
                  slivers: [
                    if (state is LoadedHyperlinkState && state.hyperlinksEntity.isNotEmpty)
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            right: SeniorSpacing.normal,
                            left: SeniorSpacing.normal,
                            top: SeniorSpacing.normal,
                          ),
                          child: Form(
                            key: _formKey,
                            child: BlocBuilder<HyperlinkBloc, HyperlinkState>(
                              bloc: _hyperlinkBloc,
                              builder: (context, state) {
                                return SeniorTextField(
                                  key: const Key('hyperlink-hyperlink_screen-text_field-input_term_search'),
                                  controller: _editingControllerSearch,
                                  label: context.translate.search,
                                  onChanged: (termToSearch) {
                                    if (lastTermToSearch != termToSearch) {
                                      lastTermToSearch = termToSearch;
                                      if (state is LoadedHyperlinkState && lastTermToSearch.isNotEmpty) {
                                        findedHyperlinks = state.hyperlinksEntity
                                            .where(
                                              (hyperlink) => hyperlink.label != null
                                                  ? hyperlink.label!
                                                      .toLowerCase()
                                                      .contains(lastTermToSearch.toLowerCase())
                                                  : false,
                                            )
                                            .toList();
                                        setState(() {});
                                      }
                                    }
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    if (state is LoadedHyperlinkState && findedHyperlinks.isNotEmpty)
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (_, index) {
                            return HyperlinkItemCardWidget(
                              key: Key(
                                'hyperlink-hyperlink_screen-list_header_widget-item_list$index',
                              ),
                              hyperlink: findedHyperlinks[index],
                              onTap: () {
                                Modular.to.pushNamed(
                                  HyperlinkRoutes.hyperlinkSelectedScreenInitialRoute,
                                  arguments: {
                                    'hyperlink': findedHyperlinks[index],
                                  },
                                );
                              },
                            );
                          },
                          childCount: findedHyperlinks.length,
                        ),
                      ),
                    if (state is LoadedHyperlinkState && findedHyperlinks.isEmpty)
                      SliverFillRemaining(
                        fillOverscroll: false,
                        hasScrollBody: false,
                        child: EmptyStateWidget(
                          title: context.translate.noResultsForSearch,
                          subTitle: context.translate.makeSureCorrectlyTerm,
                          imagePath: AssetsPath.generalEmptyState,
                        ),
                      ),
                    if (state is LoadingHyperlinkState)
                      SliverFillRemaining(
                        fillOverscroll: false,
                        hasScrollBody: false,
                        child: Container(
                          key: const Key('hyperlink-hyperlink_screen-loading'),
                          padding: const EdgeInsets.only(
                            top: SeniorSpacing.normal,
                          ),
                          alignment: Alignment.center,
                          child: const WaapiLoadingWidget(
                            waapiLoadingSizeEnum: WaapiLoadingSizeEnum.big,
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void onWillPop() {
    Modular.to.pop();
  }

  @override
  void dispose() {
    _editingControllerSearch.dispose();
    _scrollControllerListOfHyperlinks.dispose();
    super.dispose();
  }
}
