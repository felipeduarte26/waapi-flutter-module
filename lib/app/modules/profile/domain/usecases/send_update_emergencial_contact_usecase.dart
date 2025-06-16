import '../input_models/emergencial_contact_input_model.dart';
import '../repositories/send_update_emergencial_contact_repository.dart';
import '../types/profile_domain_types.dart';

abstract class SendUpdateEmergencialContactUsecase {
  SendUpdateEmergencialContactUsecaseCallback call({
    required EmergencialContactInputModel emergencialContactInputModel,
    required String emergencialContactId,
  });
}

class SendUpdateEmergencialContactUsecaseImpl implements SendUpdateEmergencialContactUsecase {
  final SendUpdateEmergencialContactRepository _sendUpdateEmergencialContactRepository;

  SendUpdateEmergencialContactUsecaseImpl({
    required SendUpdateEmergencialContactRepository sendUpdateEmergencialContactRepository,
  }) : _sendUpdateEmergencialContactRepository = sendUpdateEmergencialContactRepository;

  @override
  SendUpdateEmergencialContactUsecaseCallback call({
    required EmergencialContactInputModel emergencialContactInputModel,
    required String emergencialContactId,
  }) {
    return _sendUpdateEmergencialContactRepository.call(
      emergencialContactInputModel: emergencialContactInputModel,
      emergencialContactId: emergencialContactId,
    );
  }
}
