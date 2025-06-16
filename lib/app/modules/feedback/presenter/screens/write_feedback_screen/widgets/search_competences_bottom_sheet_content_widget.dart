import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../core/extension/translate_extension.dart';
import '../../../../../../core/widgets/employee_bottom_sheet_widget.dart';
import '../../../blocs/search_competences_bloc/search_competences_bloc.dart';
import '../../../blocs/search_competences_bloc/search_competences_event.dart';
import '../../../blocs/search_competences_bloc/search_competences_state.dart';
import 'check_box_list_competences_widget.dart';

class SearchCompetencesBottomSheetContentWidget extends StatefulWidget {
  final SearchCompetencesBloc searchCompetencesBloc;

  const SearchCompetencesBottomSheetContentWidget({
    Key? key,
    required this.searchCompetencesBloc,
  }) : super(key: key);

  @override
  State<SearchCompetencesBottomSheetContentWidget> createState() {
    return _SearchCompetencesBottomSheetContentWidgetState();
  }
}

class _SearchCompetencesBottomSheetContentWidgetState extends State<SearchCompetencesBottomSheetContentWidget> {
  late final TextEditingController _competencesTextFieldController;
  late final SearchCompetencesBloc _searchCompetencesBloc;

  @override
  void initState() {
    super.initState();
    _competencesTextFieldController = TextEditingController();
    _searchCompetencesBloc = widget.searchCompetencesBloc;
    _searchCompetencesBloc.add(ClearCompetencesListEvent());
    _searchCompetencesBloc.add(
      GetCompetencesEvent(
        competency: '',
      ),
    );
  }

  @override
  void dispose() {
    _competencesTextFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool hasText = _competencesTextFieldController.text.isNotEmpty;
    String helperText = hasText ? context.translate.clearSearchToSeeAllItems : '';

    return Scaffold(
      backgroundColor: Provider.of<ThemeRepository>(context, listen: false).theme.backdropTheme!.style!.bodyColor,
      body: BlocConsumer<SearchCompetencesBloc, SearchCompetencesState>(
        bloc: _searchCompetencesBloc,
        listener: (_, state) {
          if (state is ErrorSearchCompetencesState) {
            var searchCompetencesBlocState = _searchCompetencesBloc.state as ErrorSearchCompetencesState;
            ScaffoldMessenger.of(context).showSnackBar(
              SeniorSnackBar.error(
                key: const Key('feedback-write_feedback_screen-senior_snack_bar-error_search_competences'),
                message: context.translate.errorSearchingSkills,
                action: SeniorSnackBarAction(
                  onPressed: () {
                    _searchCompetencesBloc.add(
                      GetCompetencesEvent(
                        competency: searchCompetencesBlocState.competencySearchText,
                      ),
                    );
                  },
                  label: context.translate.repeat,
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.only(
              top: SeniorSpacing.normal,
            ),
            child: Scrollbar(
              child: CustomScrollView(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: SeniorSpacing.normal,
                        right: SeniorSpacing.normal,
                        bottom: hasText ? SeniorSpacing.normal : 0,
                      ),
                      child: SeniorTextField(
                        key: const Key('feedback-write_feedback_screen-senior_text_field-search_competency'),
                        controller: _competencesTextFieldController,
                        helper: helperText,
                        label: context.translate.skills,
                        style: SeniorTextFieldStyle(
                          textColor:
                              Provider.of<ThemeRepository>(context).isDarkTheme() ? SeniorColors.pureWhite : null,
                        ),
                        onChanged: (competency) {
                          _searchCompetencesBloc.add(
                            GetCompetencesEvent(
                              competency: competency,
                            ),
                          );
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                  CheckBoxListCompetencesWidget(
                    key: const Key('feedback-write_feedback_screen-check_box_list_competences'),
                    competences: _searchCompetencesBloc.state.competences,
                    searchCompetencesBloc: _searchCompetencesBloc,
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BlocBuilder<SearchCompetencesBloc, SearchCompetencesState>(
        bloc: _searchCompetencesBloc,
        builder: (_, state) {
          if (state is! LoadedSearchCompetencesState) {
            return const SizedBox.shrink();
          }

          return EmployeeBottomSheetWidget(
            horizontalPadding: false,
            key: const Key('feedback-write_feedback_screen-bottom_sheet'),
            seniorButtons: [
              Padding(
                padding: const EdgeInsets.only(
                  top: SeniorSpacing.normal,
                ),
                child: SeniorButton(
                  key: const Key('feedback-write_feedback_screen-bottom_sheet-button-send_competency'),
                  fullWidth: true,
                  label: context.translate.select,
                  onPressed: Modular.to.pop,
                  disabled: state.competencesSelected.isEmpty,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: SeniorSpacing.normal,
                  top: SeniorSpacing.normal,
                ),
                child: SeniorButton.ghost(
                  key: const Key('feedback-write_feedback_screen-bottom_sheet-button-option_cancel'),
                  fullWidth: true,
                  label: context.translate.optionCancel,
                  onPressed: () {
                    _searchCompetencesBloc.add(ClearCompetencesSelectedListEvent());
                    Modular.to.pop();
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
