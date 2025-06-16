import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../core/constants/assets_path.dart';
import '../../../../../core/enums/analytics/waapi_loading_size_enum.dart';
import '../../../../../core/extension/translate_extension.dart';
import '../../../../../core/helper/scroll_helper.dart';
import '../../../../../core/pagination/pagination_requirements.dart';
import '../../../../../core/widgets/empty_state_widget.dart';
import '../../../../../core/widgets/person_list_item_widget.dart';
import '../../../../../core/widgets/waapi_colorful_header.dart';
import '../../../../../core/widgets/waapi_loading_widget.dart';
import '../../../../../routes/routes.dart';
import '../../blocs/search_person/search_person_event.dart';
import '../../blocs/search_person/search_person_state.dart';
import 'blocs/search_person_screen_bloc.dart';
import 'blocs/search_person_screen_state.dart';

class SearchPersonScreen extends StatefulWidget {
  final SearchPersonScreenBloc searchPersonScreenBloc;

  const SearchPersonScreen({
    Key? key,
    required this.searchPersonScreenBloc,
  }) : super(key: key);

  @override
  State<SearchPersonScreen> createState() {
    return _SearchPersonScreenState();
  }
}

class _SearchPersonScreenState extends State<SearchPersonScreen> {
  late final GlobalKey<FormState> _formKey;
  late TextEditingController _editingControllerSearchPerson;
  late ScrollController _scrollControllerListOfPeople;
  int _nextPage = 1;
  String lastTermToSearch = '';

  @override
  void initState() {
    super.initState();
    _editingControllerSearchPerson = TextEditingController();
    _formKey = GlobalKey<FormState>();
    _scrollControllerListOfPeople = ScrollController();
    _scrollControllerListOfPeople.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (_, __) async => onWillPop(),
      child: Scaffold(
        body: WaapiColorfulHeader(
          onTapBack: onWillPop,
          hasTopPadding: false,
          titleLabel: context.translate.peopleSearch,
          body: Scrollbar(
            controller: _scrollControllerListOfPeople,
            child: CustomScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              controller: _scrollControllerListOfPeople,
              slivers: [
                SliverToBoxAdapter(
                  child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        right: SeniorSpacing.normal,
                        left: SeniorSpacing.normal,
                        top: SeniorSpacing.normal,
                        bottom: SeniorSpacing.normal,
                      ),
                      child: SeniorTextField(
                        key: const Key('search_person-search_person_screen-text_field-input_term_search'),
                        controller: _editingControllerSearchPerson,
                        label: context.translate.peopleSearch,
                        maxLines: 1,
                        helper: context.translate.searchEmployeeTextFieldHint,
                        textInputAction: TextInputAction.done,
                        onChanged: (termToSearch) {
                          // Condition added because when the user dismisses keyboard
                          // using back button on changed was called and triggering a new event,
                          // and therefore a new search has been made.
                          if (lastTermToSearch != termToSearch) {
                            lastTermToSearch = termToSearch;
                            _searchPersonByTermEvent(
                              paginationRequirements: PaginationRequirements(
                                page: 1,
                                queryText: lastTermToSearch,
                              ),
                            );
                            setState(() {});
                          }
                        },
                        autofocus: true,
                        validator: (value) {
                          if (value != null && value.trim().length < 3) {
                            return context.translate.searchEmployeeTextFieldHint;
                          }

                          return null;
                        },
                      ),
                    ),
                  ),
                ),
                BlocConsumer<SearchPersonScreenBloc, SearchPersonScreenState>(
                  bloc: widget.searchPersonScreenBloc,
                  listener: (_, state) {
                    if (state.searchPersonState is LoadingSearchPersonState) {
                      _nextPage = 1;
                    }

                    if (state.searchPersonState is LoadedSearchPersonState) {
                      _nextPage++;
                    }

                    if (state.searchPersonState is ErrorSearchPersonState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SeniorSnackBar.error(
                          key: const Key('search_person-search_person_screen-error_loading_person'),
                          message: context.translate.errorLoadingPeople,
                          action: SeniorSnackBarAction(
                            label: context.translate.repeat,
                            onPressed: () => _searchPersonByTermEvent(
                              paginationRequirements: PaginationRequirements(
                                page: _nextPage,
                                queryText: lastTermToSearch,
                              ),
                            ),
                          ),
                        ),
                      );
                    }

                    if (state.searchPersonState is ErrorMoreSearchPersonState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SeniorSnackBar.error(
                          key: const Key('search_person-search_person_screen-error_loading_more_person'),
                          message: context.translate.errorLoadingMorePeople,
                          action: SeniorSnackBarAction(
                            label: context.translate.repeat,
                            onPressed: () => _searchPersonByTermEvent(
                              paginationRequirements: PaginationRequirements(
                                page: _nextPage,
                                queryText: lastTermToSearch,
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state.searchPersonState is LoadingSearchPersonState) {
                      return SliverFillRemaining(
                        fillOverscroll: false,
                        hasScrollBody: false,
                        child: Container(
                          key: const Key('search_person-search_person_screen-loading'),
                          padding: const EdgeInsets.only(
                            top: SeniorSpacing.normal,
                          ),
                          alignment: Alignment.center,
                          child: const WaapiLoadingWidget(
                            waapiLoadingSizeEnum: WaapiLoadingSizeEnum.big,
                          ),
                        ),
                      );
                    }

                    if (state.searchPersonState is EmptySearchPersonState) {
                      return SliverFillRemaining(
                        fillOverscroll: false,
                        hasScrollBody: false,
                        child: EmptyStateWidget(
                          key: const Key('search_person-search_person_screen-person_not_found'),
                          title: context.translate.noPersonFound,
                          subTitle: context.translate.descriptionNoPersonFound,
                          imagePath: AssetsPath.searchPersonEmptyState,
                          imageHeight: 120,
                        ),
                      );
                    }

                    if (state.searchPersonState is InitialSearchPersonState ||
                        state.searchPersonState is CleanSearchPersonState) {
                      return SliverFillRemaining(
                        fillOverscroll: false,
                        hasScrollBody: false,
                        child: EmptyStateWidget(
                          key: const Key('search_person-search_person_screen-descriptive_panel'),
                          title: context.translate.descriptionPeopleSearch,
                          imagePath: AssetsPath.searchPersonEmptyState,
                          imageHeight: 120,
                        ),
                      );
                    }

                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (_, index) {
                          if (index == state.searchPersonState.personEntityList.length) {
                            return Column(
                              children: [
                                Offstage(
                                  key: const Key(
                                    'search_person-search_person_screen-circular_progress-load_more',
                                  ),
                                  offstage: state.searchPersonState is! LoadingMoreSearchPersonState,
                                  child: const Center(
                                    child: WaapiLoadingWidget(
                                      waapiLoadingSizeEnum: WaapiLoadingSizeEnum.big,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }

                          return PersonListItemWidget(
                            key: Key(
                              'search_person-search_person_screen-list_header_widget-item_list$index',
                            ),
                            imageProvider:
                                CachedNetworkImageProvider(state.searchPersonState.personEntityList[index].linkPhoto),
                            personName: state.searchPersonState.personEntityList[index].name,
                            personJobPosition: state.searchPersonState.personEntityList[index].jobPosition,
                            leading: FontAwesomeIcons.chevronRight,
                            padding: const EdgeInsets.symmetric(
                              horizontal: SeniorSpacing.normal,
                              vertical: SeniorSpacing.xsmall,
                            ),
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              Modular.to.pushNamed(
                                ProfileRoutes.publicProfileScreenInitialRoute,
                                arguments: state.searchPersonState.personEntityList[index].username,
                              );
                            },
                          );
                        },
                        childCount: state.searchPersonState.personEntityList.length + 1,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onWillPop() {
    

    Modular.to.pop();
  }

  void _onScroll() {
    final canLoadMore = ScrollHelper.reachedListEnd(
      scrollController: _scrollControllerListOfPeople,
    );

    if (canLoadMore) {
      _searchPersonByTermEvent(
        paginationRequirements: PaginationRequirements(
          page: _nextPage,
          queryText: lastTermToSearch,
        ),
      );
    }
  }

  void _searchPersonByTermEvent({
    required PaginationRequirements paginationRequirements,
  }) {
    widget.searchPersonScreenBloc.searchPersonBloc.add(
      SearchPersonByTermEvent(
        paginationRequirements: paginationRequirements,
      ),
    );
  }

  @override
  void dispose() {
    _editingControllerSearchPerson.dispose();
    _scrollControllerListOfPeople.dispose();
    super.dispose();
  }
}
