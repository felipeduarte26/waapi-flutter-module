import '../../domain/input_models/emergencial_contact_input_model.dart';

abstract class SendUpdateEmergencialContactDatasource {
  Future<void> call({
    required EmergencialContactInputModel emergencialContactInputModel,
    required String emergencialContactId,
  });
}
