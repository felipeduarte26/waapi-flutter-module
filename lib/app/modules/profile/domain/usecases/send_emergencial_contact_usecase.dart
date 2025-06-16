import '../input_models/emergencial_contact_input_model.dart';
import '../repositories/send_emergencial_contact_repository.dart';
import '../types/profile_domain_types.dart';

abstract class SendEmergencialContactUsecase {
  SendUpdateEmergencialContactUsecaseCallback call({
    required EmergencialContactInputModel emergencialContactInputModel,
  });
}

class SendEmergencialContactUsecaseImpl implements SendEmergencialContactUsecase {
  final SendEmergencialContactRepository _sendEmergencialContactRepository;

  const SendEmergencialContactUsecaseImpl({
    required SendEmergencialContactRepository sendEmergencialContactRepository,
  }) : _sendEmergencialContactRepository = sendEmergencialContactRepository;

  @override
  SendUpdateEmergencialContactUsecaseCallback call({
    required EmergencialContactInputModel emergencialContactInputModel,
  }) {
    return _sendEmergencialContactRepository.call(
      sendEmergencialContactInputModel: emergencialContactInputModel,
    );
  }
}
