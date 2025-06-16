import '../input_models/edit_personal_address_input_model.dart';
import '../types/profile_domain_types.dart';

abstract class UpdatePersonalAddressRepository {
  UpdatePersonalAddressUsecaseCallback call({
    required EditPersonalAddressInputModel editPersonalAddressInputModel,
  });
}
