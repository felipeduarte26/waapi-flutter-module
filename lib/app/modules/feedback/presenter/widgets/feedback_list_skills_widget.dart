import 'package:flutter/material.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../core/extension/translate_extension.dart';
import '../../domain/entities/skill_feedback_entity.dart';
import 'feedback_competency_tag_widget.dart';

class FeedbackListSkillsWidget extends StatelessWidget {
  final List<SkillFeedbackEntity> skills;

  const FeedbackListSkillsWidget({
    Key? key,
    required this.skills,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: SeniorSpacing.normal,
            left: SeniorSpacing.normal,
            right: SeniorSpacing.normal,
            bottom: SeniorSpacing.xsmall,
          ),
          child: Row(
            key: const Key('feedback-feedback_list_skills-skills-text'),
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SeniorText.label(
                '${context.translate.skills}:',
              ),
            ],
          ),
        ),
        SizedBox(
          key: const Key('feedback-feedback_list_skills_widget-skills'),
          height: SeniorSpacing.medium,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(
              horizontal: SeniorSpacing.normal,
            ),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return FeedbackCompetencyTagWidget(
                displayLabel: skills[index].name,
                key: Key(
                  'feedback-feedback_list_skills_widget-skills $index',
                ),
              );
            },
            separatorBuilder: (_, __) => const SizedBox(
              width: SeniorSpacing.xsmall,
            ),
            itemCount: skills.length,
          ),
        ),
      ],
    );
  }
}
