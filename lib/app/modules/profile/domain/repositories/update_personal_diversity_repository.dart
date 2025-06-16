import '../input_models/edit_personal_diversity_input_model.dart';
import '../types/profile_domain_types.dart';

abstract class UpdatePersonalDiversityRepository {
  UpdatePersonalDiversityUsecaseCallback call({
    required EditPersonalDiversityInputModel editPersonalDiversityInputModel,
  });
}
