
import '../input_models/edit_personal_address_input_model.dart';
import '../repositories/update_personal_address_repository.dart';
import '../types/profile_domain_types.dart';

abstract class UpdatePersonalAddressUsecase {
  UpdatePersonalAddressUsecaseCallback call({
    required EditPersonalAddressInputModel editPersonalAddressInputModel,
  });
}

class UpdatePersonalAddressUsecaseImpl implements UpdatePersonalAddressUsecase {
  final UpdatePersonalAddressRepository _updatePersonalAddressRepository;

  const UpdatePersonalAddressUsecaseImpl({
    required UpdatePersonalAddressRepository updatePersonalAddressRepository,
  }) : _updatePersonalAddressRepository = updatePersonalAddressRepository;

  @override
  UpdatePersonalAddressUsecaseCallback call({
    required EditPersonalAddressInputModel editPersonalAddressInputModel,
  }) {
    return _updatePersonalAddressRepository.call(
      editPersonalAddressInputModel: editPersonalAddressInputModel,
    );
  }
}
