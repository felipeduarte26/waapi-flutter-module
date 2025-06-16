import 'package:equatable/equatable.dart';

import '../../../attachment/domain/entities/attachment_entity.dart';
import '../../enums/feedback_type_enum.dart';
import '../../enums/feedback_visibility_enum.dart';
import 'proficiency_feedback_entity.dart';
import 'skill_feedback_entity.dart';

class FeedbackEntity extends Equatable {
  final String id;
  final DateTime when;
  final bool isPublic;
  final FeedbackVisibilityEnum visibility;
  final String message;
  final int starCount;
  final String fromId;
  final String fromName;
  final String fromUsername;
  final String fromPhotoUrl;
  final String toId;
  final String toName;
  final String toUsername;
  final String toPhotoUrl;
  final FeedbackTypeEnum? feedbackType;
  final ProficiencyFeedbackEntity? proficiency;
  final List<AttachmentEntity>? attachments;
  final List<SkillFeedbackEntity>? skills;

  const FeedbackEntity({
    required this.id,
    required this.when,
    required this.isPublic,
    required this.visibility,
    required this.message,
    required this.starCount,
    required this.fromId,
    required this.fromName,
    required this.fromPhotoUrl,
    required this.fromUsername,
    required this.toId,
    required this.toName,
    required this.toPhotoUrl,
    required this.toUsername,
    this.feedbackType,
    this.proficiency,
    this.attachments,
    this.skills,
  });

  @override
  List<Object?> get props => [
        id,
        when,
        isPublic,
        visibility,
        message,
        starCount,
        fromId,
        fromName,
        fromPhotoUrl,
        fromUsername,
        toId,
        toName,
        toPhotoUrl,
        toUsername,
        feedbackType,
        proficiency,
        attachments,
        skills,
      ];
}
