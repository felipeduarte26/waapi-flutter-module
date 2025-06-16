import '../../domain/input_models/proficiency_input_model.dart';

class ProficiencyInputModelMapper {
  Map<String, dynamic> toMap({
    required ProficiencyInputModel proficiencyInputModel,
  }) {
    return {
      'id': proficiencyInputModel.id,
      'color': proficiencyInputModel.color,
      'name': proficiencyInputModel.name,
      'level': proficiencyInputModel.level,
    };
  }
}
