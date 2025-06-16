import '../../domain/input_models/emergencial_contact_input_model.dart';

abstract class SendEmergencialContactDatasource {
  Future<void> call({
    required EmergencialContactInputModel emergencialContactUploadedInputModel,
  });
}
