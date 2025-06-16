import 'package:equatable/equatable.dart';

import '../../../domain/entities/proficiency_feedback_entity.dart';
import '../../../domain/entities/skill_feedback_entity.dart';
import '../../../enums/feedback_analytics_type_enum.dart';
import '../../../enums/feedback_visibility_enum.dart';

abstract class SendFeedbackEvent extends Equatable {}

class SendWrittenFeedbackEvent extends SendFeedbackEvent {
  final String message;
  final DateTime when;
  final String toUserName;
  final FeedbackVisibilityEnum visibility;
  final String requestId;
  final List<SkillFeedbackEntity> skills;
  final int starCount;
  final ProficiencyFeedbackEntity? proficiency;
  final FeedbackAnalyticsTypeEnum feedbackAnalyticsTypeEnum;

  SendWrittenFeedbackEvent({
    required this.message,
    required this.when,
    required this.toUserName,
    required this.visibility,
    required this.requestId,
    required this.skills,
    this.starCount = 0,
    required this.proficiency,
    required this.feedbackAnalyticsTypeEnum,
  });

  @override
  List<Object?> get props {
    return [
      message,
      when,
      toUserName,
      visibility,
      requestId,
      skills,
      starCount,
      proficiency,
      feedbackAnalyticsTypeEnum,
    ];
  }
}
