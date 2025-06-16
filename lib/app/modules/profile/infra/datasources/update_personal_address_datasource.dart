import '../../domain/input_models/edit_personal_address_input_model.dart';

abstract class UpdatePersonalAddressDatasource {
  Future<void> call({
    required EditPersonalAddressInputModel editPersonalAddressInputModel,
  });
}
