import '../../domain/input_models/skill_input_model.dart';

class SkillInputModelMapper {
  Map<String, dynamic> toMap({
    required SkillInputModel skillInputModel,
  }) {
    return {
      'competencyId': skillInputModel.competencyId,
      'skill': skillInputModel.skill,
    };
  }
}
