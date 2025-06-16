import '../input_models/edit_personal_diversity_input_model.dart';
import '../repositories/update_personal_diversity_repository.dart';
import '../types/profile_domain_types.dart';

abstract class UpdatePersonalDiversityUsecase {
  UpdatePersonalDiversityUsecaseCallback call({
    required EditPersonalDiversityInputModel editPersonalDiversityInputModel,
  });
}

class UpdatePersonalDiversityUsecaseImpl implements UpdatePersonalDiversityUsecase {
  final UpdatePersonalDiversityRepository _updatePersonalDiversityRepository;

  const UpdatePersonalDiversityUsecaseImpl({
    required UpdatePersonalDiversityRepository updatePersonalDiversityRepository,
  }) : _updatePersonalDiversityRepository = updatePersonalDiversityRepository;

  @override
  UpdatePersonalDiversityUsecaseCallback call({
    required EditPersonalDiversityInputModel editPersonalDiversityInputModel,
  }) {
    return _updatePersonalDiversityRepository.call(
      editPersonalDiversityInputModel: editPersonalDiversityInputModel,
    );
  }
}
