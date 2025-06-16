import '../input_models/edit_personal_contact_input_model.dart';
import '../repositories/update_personal_contact_repository.dart';
import '../types/profile_domain_types.dart';

abstract class UpdatePersonalContactUsecase {
  UpdatePersonalContactUsecaseCallback call({
    required EditPersonalContactInputModel editPersonalContactInputModel,
  });
}

class UpdatePersonalContactUsecaseImpl implements UpdatePersonalContactUsecase {
  final UpdatePersonalContactRepository _updatePersonalContactRepository;

  const UpdatePersonalContactUsecaseImpl({
    required UpdatePersonalContactRepository updatePersonalContactRepository,
  }) : _updatePersonalContactRepository = updatePersonalContactRepository;

  @override
  UpdatePersonalContactUsecaseCallback call({
    required EditPersonalContactInputModel editPersonalContactInputModel,
  }) {
    return _updatePersonalContactRepository.call(
      editPersonalContactInputModel: editPersonalContactInputModel,
    );
  }
}
