import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../domain/entities/skill_feedback_entity.dart';
import '../../../blocs/search_competences_bloc/search_competences_bloc.dart';
import '../../../blocs/search_competences_bloc/search_competences_state.dart';

class CheckBoxCompetencyTileWidget extends StatefulWidget {
  final SkillFeedbackEntity skillFeedbackEntity;
  final Function({required bool isSelected}) competencySelected;
  final SearchCompetencesBloc searchCompetencesBloc;

  const CheckBoxCompetencyTileWidget({
    Key? key,
    required this.skillFeedbackEntity,
    required this.competencySelected,
    required this.searchCompetencesBloc,
  }) : super(key: key);

  @override
  State<CheckBoxCompetencyTileWidget> createState() {
    return _CheckBoxCompetencyTileWidgetState();
  }
}

class _CheckBoxCompetencyTileWidgetState extends State<CheckBoxCompetencyTileWidget> {
  var isSelected = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCompetencesBloc, SearchCompetencesState>(
      bloc: widget.searchCompetencesBloc,
      buildWhen: (oldState, newState) => oldState != newState,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: SeniorSpacing.normal,
          ),
          child: InkWell(
            onTap: () => setState(() {
              isSelected = !isSelected;
              widget.competencySelected(
                isSelected: isSelected,
              );
            }),
            child: Row(
              children: [
                const SizedBox(
                  width: SeniorSpacing.xsmall,
                ),
                SeniorCheckbox(
                  value: state.competencesSelected.any(
                    (skill) => skill.id == widget.skillFeedbackEntity.id,
                  ),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        isSelected = value;
                        widget.competencySelected(
                          isSelected: isSelected,
                        );
                      });
                    }
                  },
                ),
                const SizedBox(
                  width: SeniorSpacing.xsmall,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: SeniorSpacing.small,
                    ),
                    child: SeniorText.label(
                      widget.skillFeedbackEntity.name,
                      textProperties: const TextProperties(
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: SeniorSpacing.xsmall,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
