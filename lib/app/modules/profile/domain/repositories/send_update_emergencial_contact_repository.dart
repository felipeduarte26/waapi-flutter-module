import '../input_models/emergencial_contact_input_model.dart';
import '../types/profile_domain_types.dart';

abstract class SendUpdateEmergencialContactRepository {
  SendUpdateEmergencialContactUsecaseCallback call({
    required EmergencialContactInputModel emergencialContactInputModel,
    required String emergencialContactId,
  });
}
