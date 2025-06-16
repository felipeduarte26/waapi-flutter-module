import '../../../attachment/infra/adapters/attachment_entity_adapter.dart';
import '../../domain/entities/feedback_entity.dart';
import '../models/feedback_model.dart';
import 'proficiency_feedback_entity_adapter.dart';
import 'skill_feedback_entity_adapter.dart';

class FeedbackEntityAdapter {
  final ProficiencyFeedbackEntityAdapter _proficiencyFeedbackEntityAdapter;
  final AttachmentEntityAdapter _attachmentEntityAdapter;
  final SkillFeedbackEntityAdapter _skillFeedbackEntityAdapter;

  const FeedbackEntityAdapter({
    required ProficiencyFeedbackEntityAdapter proficiencyFeedbackEntityAdapter,
    required AttachmentEntityAdapter attachmentEntityAdapter,
    required SkillFeedbackEntityAdapter skillFeedbackEntityAdapter,
  })  : _proficiencyFeedbackEntityAdapter = proficiencyFeedbackEntityAdapter,
        _attachmentEntityAdapter = attachmentEntityAdapter,
        _skillFeedbackEntityAdapter = skillFeedbackEntityAdapter;

  FeedbackEntity fromModel({
    required FeedbackModel feedbackModel,
  }) {
    return FeedbackEntity(
      id: feedbackModel.id,
      fromId: feedbackModel.fromId,
      fromName: feedbackModel.fromName,
      fromPhotoUrl: feedbackModel.fromPhotoUrl,
      fromUsername: feedbackModel.fromUsername,
      toId: feedbackModel.toId,
      toName: feedbackModel.toName,
      toPhotoUrl: feedbackModel.toPhotoUrl,
      toUsername: feedbackModel.toUsername,
      feedbackType: feedbackModel.feedbackType,
      message: feedbackModel.message,
      starCount: feedbackModel.starCount,
      when: feedbackModel.when,
      visibility: feedbackModel.visibility,
      isPublic: feedbackModel.isPublic,
      proficiency: feedbackModel.proficiency == null
          ? null
          : _proficiencyFeedbackEntityAdapter.fromModel(
              proficiencyFeedbackModel: feedbackModel.proficiency!,
            ),
      attachments: feedbackModel.attachments?.map(
        (attachmentModel) {
          return _attachmentEntityAdapter.fromModel(
            model: attachmentModel,
          );
        },
      ).toList(),
      skills: feedbackModel.skills?.map(
        (skillFeedbackModel) {
          return _skillFeedbackEntityAdapter.fromModel(
            skillFeedbackModel: skillFeedbackModel,
          );
        },
      ).toList(),
    );
  }
}
