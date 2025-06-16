import '../../domain/entities/skill_feedback_entity.dart';
import '../models/skill_feedback_model.dart';

class SkillFeedbackEntityAdapter {
  SkillFeedbackEntity fromModel({
    required SkillFeedbackModel skillFeedbackModel,
  }) {
    return SkillFeedbackEntity(
      id: skillFeedbackModel.id,
      name: skillFeedbackModel.name,
    );
  }
}
