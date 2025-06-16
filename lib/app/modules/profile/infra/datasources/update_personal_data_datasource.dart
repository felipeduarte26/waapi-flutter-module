import '../../domain/input_models/edit_personal_data_input_model.dart';

abstract class UpdatePersonalDataDatasource {
  Future<void> call({
    required EditPersonalDataInputModel editPersonalDataInputModel,
  });
}
