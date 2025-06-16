import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../core/constants/assets_path.dart';
import '../../../../../../core/extension/translate_extension.dart';
import '../../../../../../core/widgets/empty_state_widget.dart';
import '../../../../../../core/widgets/waapi_loading_widget.dart';
import '../../../../domain/entities/skill_feedback_entity.dart';
import '../../../blocs/search_competences_bloc/search_competences_bloc.dart';
import '../../../blocs/search_competences_bloc/search_competences_event.dart';
import '../../../blocs/search_competences_bloc/search_competences_state.dart';
import 'check_box_competency_tile_widget.dart';

class CheckBoxListCompetencesWidget extends StatefulWidget {
  final List<SkillFeedbackEntity> competences;
  final SearchCompetencesBloc searchCompetencesBloc;

  const CheckBoxListCompetencesWidget({
    Key? key,
    required this.competences,
    required this.searchCompetencesBloc,
  }) : super(key: key);

  @override
  State<CheckBoxListCompetencesWidget> createState() {
    return _CheckBoxListCompetencesWidgetState();
  }
}

class _CheckBoxListCompetencesWidgetState extends State<CheckBoxListCompetencesWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCompetencesBloc, SearchCompetencesState>(
      bloc: widget.searchCompetencesBloc,
      buildWhen: (oldState, newState) => oldState != newState,
      builder: (_, state) {
        if (state is LoadingSearchCompetencesState) {
          return SliverToBoxAdapter(
            child: Container(
              key: const Key('feedback-write_feedback_screen-search_competences-loading_search_competences'),
              padding: const EdgeInsets.only(
                top: SeniorSpacing.normal,
              ),
              alignment: Alignment.topCenter,
              child: const WaapiLoadingWidget(),
            ),
          );
        }

        if (state is EmptyListSearchCompetencesState) {
          return SliverFillRemaining(
            child: EmptyStateWidget(
              key: const Key('feedback-write_feedback_screen-search_competences-empty_search_competences'),
              imagePath: AssetsPath.competenceEmptyState,
              imageHeight: 120,
              title: context.translate.noCompetenceFound,
              subTitle: context.translate.noCompetenceFoundDescription,
            ),
          );
        }

        if (state is InitialSearchCompetencesState) {
          return const SliverToBoxAdapter(
            child: SizedBox.shrink(),
          );
        }

        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return CheckBoxCompetencyTileWidget(
                key: Key('feedback-write_feedback_screen-check_box_list-check_box_list_tile_$index'),
                skillFeedbackEntity: widget.competences[index],
                competencySelected: ({isSelected = false}) {
                  FocusManager.instance.primaryFocus?.unfocus();
                  if (isSelected) {
                    widget.searchCompetencesBloc.add(
                      SelectCompetencesListEvent(
                        competencySelected: widget.competences[index],
                        isMarkAsSelected: true,
                      ),
                    );
                  } else {
                    widget.searchCompetencesBloc.add(
                      SelectCompetencesListEvent(
                        competencySelected: widget.competences[index],
                        isMarkAsSelected: false,
                      ),
                    );
                  }
                },
                searchCompetencesBloc: widget.searchCompetencesBloc,
              );
            },
            childCount: widget.competences.length,
          ),
        );
      },
    );
  }
}
