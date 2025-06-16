import 'package:equatable/equatable.dart';

import '../../../attachment/infra/models/attachment_model.dart';
import '../../enums/feedback_type_enum.dart';
import '../../enums/feedback_visibility_enum.dart';
import 'proficiency_feedback_model.dart';
import 'skill_feedback_model.dart';

class FeedbackModel extends Equatable {
  final String id;
  final DateTime when;
  final String fromId;
  final String fromName;
  final String fromUsername;
  final String fromPhotoUrl;
  final String toId;
  final String toName;
  final String toUsername;
  final String toPhotoUrl;
  final FeedbackTypeEnum? feedbackType;
  final bool isPublic;
  final FeedbackVisibilityEnum visibility;
  final String message;
  final int starCount;
  final ProficiencyFeedbackModel? proficiency;
  final List<AttachmentModel>? attachments;
  final List<SkillFeedbackModel>? skills;

  const FeedbackModel({
    required this.id,
    required this.when,
    required this.fromId,
    required this.fromName,
    required this.fromUsername,
    required this.fromPhotoUrl,
    required this.toId,
    required this.toName,
    required this.toUsername,
    required this.toPhotoUrl,
    required this.isPublic,
    required this.visibility,
    required this.message,
    required this.starCount,
    this.feedbackType,
    this.proficiency,
    this.attachments,
    this.skills,
  });

  @override
  List<Object?> get props {
    return [
      id,
      when,
      fromId,
      fromName,
      fromUsername,
      fromPhotoUrl,
      toId,
      toName,
      toUsername,
      toPhotoUrl,
      feedbackType,
      isPublic,
      visibility,
      message,
      starCount,
      proficiency,
      attachments,
      skills,
    ];
  }
}
