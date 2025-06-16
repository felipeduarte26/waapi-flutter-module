import '../../domain/input_models/edit_personal_diversity_input_model.dart';

abstract class UpdatePersonalDiversityDatasource {
  Future<void> call({
    required EditPersonalDiversityInputModel editPersonalDiversityInputModel,
  });
}
