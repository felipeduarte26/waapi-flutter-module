import '../input_models/emergencial_contact_input_model.dart';
import '../types/profile_domain_types.dart';

abstract class SendEmergencialContactRepository {
  SendEmergencialContactUsecaseCallback call({
    required EmergencialContactInputModel sendEmergencialContactInputModel,
  });
}
