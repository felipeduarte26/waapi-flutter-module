import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../core/extension/translate_extension.dart';
import '../blocs/search_ethnicity_bloc/search_ethnicity_bloc.dart';
import 'ethnicity_search_list_view_widget.dart';

class SelectEthnicityBottomSheetContentWidget extends StatefulWidget {
  final SearchEthnicityBloc searchEthnicityBloc;
  final String initialTitle;
  final String initialSubtitle;
  final String noFoundTitle;
  final String noFoundSubtitle;

  const SelectEthnicityBottomSheetContentWidget({
    Key? key,
    required this.searchEthnicityBloc,
    required this.initialTitle,
    required this.initialSubtitle,
    required this.noFoundTitle,
    required this.noFoundSubtitle,
  }) : super(key: key);

  @override
  State<SelectEthnicityBottomSheetContentWidget> createState() {
    return _SelectEthnicityBottomSheetContentWidgetState();
  }
}

class _SelectEthnicityBottomSheetContentWidgetState extends State<SelectEthnicityBottomSheetContentWidget> {
  late final GlobalKey<FormState> _formKey;
  var lastSearch = '';

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    widget.searchEthnicityBloc.add(
      SearchEthnicityProfileEvent(
        search: '%',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeRepository>(context).theme;
    return Scaffold(
      backgroundColor: theme.colorfulHeaderStructureTheme!.style!.bodyColor,
      body: BlocConsumer<SearchEthnicityBloc, SearchEthnicityState>(
        bloc: widget.searchEthnicityBloc,
        listener: (_, state) {
          final searchNationalityBlocState = state;

          if (searchNationalityBlocState is ErrorSearchEthnicityState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SeniorSnackBar.error(
                message: context.translate.searchEmployeeErrorText,
                action: SeniorSnackBarAction(
                  onPressed: () => widget.searchEthnicityBloc.add(
                    SearchEthnicityProfileEvent(
                      search: searchNationalityBlocState.search,
                    ),
                  ),
                  label: context.translate.repeat,
                ),
              ),
            );
          }
        },
        listenWhen: (oldState, newState) => oldState != newState,
        buildWhen: (oldState, newState) => oldState != newState,
        builder: (_, __) {
          return Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.only(
                top: SeniorSpacing.normal,
              ),
              child: Scrollbar(
                child: CustomScrollView(
                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                  slivers: [
                    SliverToBoxAdapter(
                      child: SeniorTextField(
                        key: const Key('profile-select_Ethnicity_bottom_sheet-text_field'),
                        label: context.translate.raceEthnicity,
                        helper: context.translate.searchEmployeeTextFieldHint,
                        maxLines: 1,
                        counterText: context.translate.characters,
                        textInputAction: TextInputAction.done,
                        onChanged: (search) {
                          if (lastSearch != search) {
                            lastSearch = search;
                            _formKey.currentState!.validate();
                            widget.searchEthnicityBloc.add(
                              SearchEthnicityProfileEvent(
                                search: search.trim().isEmpty ? '%' : search,
                              ),
                            );
                          }
                        },
                        validator: (value) {
                          if (value != null && value.isNotEmpty && value.trim().length < 3) {
                            return context.translate.searchEmployeeTextFieldHint;
                          }

                          return null;
                        },
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: SizedBox(
                        height: SeniorSpacing.medium,
                      ),
                    ),
                    EthnicitySearchListViewWidget(
                      key: const Key('profile-select_nationality_bottom_sheet-nationality_search_list'),
                      searchEthnicityBloc: widget.searchEthnicityBloc,
                      initialTitle: widget.initialTitle,
                      initialSubtitle: widget.initialSubtitle,
                      noFoundTitle: widget.noFoundTitle,
                      noFoundSubtitle: widget.noFoundSubtitle,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
