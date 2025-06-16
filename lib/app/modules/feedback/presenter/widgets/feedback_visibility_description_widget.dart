import 'package:flutter/material.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../core/extension/translate_extension.dart';
import '../../enums/feedback_visibility_enum.dart';

class FeedbackVisibilityDescriptionWidget extends StatefulWidget {
  final FeedbackVisibilityEnum visibility;

  const FeedbackVisibilityDescriptionWidget({
    Key? key,
    required this.visibility,
  }) : super(key: key);

  @override
  State<FeedbackVisibilityDescriptionWidget> createState() {
    return _FeedbackVisibilityDescriptionWidgetState();
  }
}

class _FeedbackVisibilityDescriptionWidgetState extends State<FeedbackVisibilityDescriptionWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: SeniorSpacing.normal,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SeniorText.small(
            _getVisibilityText(),
          ),
        ],
      ),
    );
  }

  String _getVisibilityText() {
    switch (widget.visibility) {
      case FeedbackVisibilityEnum.evaluator:
        return context.translate.feedbackVisibilityEvaluator;
      case FeedbackVisibilityEnum.leader:
        return context.translate.feedbackVisibilityLeader;
      case FeedbackVisibilityEnum.employee:
        return context.translate.feedbackVisibilityEmployee;
      case FeedbackVisibilityEnum.onlyEmployee:
      default:
        return context.translate.feedbackVisibilityOnlyEmployee;
    }
  }
}
