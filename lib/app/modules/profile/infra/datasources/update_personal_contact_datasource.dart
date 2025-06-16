import '../../domain/input_models/edit_personal_contact_input_model.dart';

abstract class UpdatePersonalContactDatasource {
  Future<void> call({
    required EditPersonalContactInputModel editPersonalContactInputModel,
  });
}
