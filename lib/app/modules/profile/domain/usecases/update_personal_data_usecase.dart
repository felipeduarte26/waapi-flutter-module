import '../input_models/edit_personal_data_input_model.dart';
import '../repositories/update_personal_data_repository.dart';
import '../types/profile_domain_types.dart';

abstract class UpdatePersonalDataUsecase {
  UpdatePersonalDataUsecaseCallback call({
    required EditPersonalDataInputModel editPersonalDataInputModel,
  });
}

class UpdatePersonalDataUsecaseImpl implements UpdatePersonalDataUsecase {
  final UpdatePersonalDataRepository _updatePersonalDataRepository;

  const UpdatePersonalDataUsecaseImpl({
    required UpdatePersonalDataRepository updatePersonalDataRepository,
  }) : _updatePersonalDataRepository = updatePersonalDataRepository;

  @override
  UpdatePersonalDataUsecaseCallback call({
    required EditPersonalDataInputModel editPersonalDataInputModel,
  }) {
    return _updatePersonalDataRepository.call(
      editPersonalDataInputModel: editPersonalDataInputModel,
    );
  }
}
