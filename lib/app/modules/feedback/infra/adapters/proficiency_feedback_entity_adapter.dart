import '../../domain/entities/proficiency_feedback_entity.dart';
import '../models/proficiency_feedback_model.dart';

class ProficiencyFeedbackEntityAdapter {
  ProficiencyFeedbackEntity fromModel({
    required ProficiencyFeedbackModel proficiencyFeedbackModel,
  }) {
    return ProficiencyFeedbackEntity(
      id: proficiencyFeedbackModel.id,
      icon: proficiencyFeedbackModel.icon,
      color: proficiencyFeedbackModel.color,
      name: proficiencyFeedbackModel.name,
      needJustify: proficiencyFeedbackModel.needJustify,
      needPDI: proficiencyFeedbackModel.needPDI,
      valueOfScore: proficiencyFeedbackModel.valueOfScore,
      level: proficiencyFeedbackModel.level,
    );
  }
}
