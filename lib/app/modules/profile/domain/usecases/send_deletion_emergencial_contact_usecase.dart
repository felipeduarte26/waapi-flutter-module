import '../repositories/send_deletion_emergencial_contact_repository.dart';
import '../types/profile_domain_types.dart';

abstract class SendDeletionEmergencialContactUsecase {
  SendDeletionEmergencialContactUsecaseCallback call({
    required String idEmergencialContact,
  });
}

class SendDeletionEmergencialContactUsecaseImpl implements SendDeletionEmergencialContactUsecase {
  final SendDeletionEmergencialContactRepository _sendDeletionEmergencialContactRepository;

  const SendDeletionEmergencialContactUsecaseImpl({
    required SendDeletionEmergencialContactRepository sendDeletionEmergencialContactRepository,
  }) : _sendDeletionEmergencialContactRepository = sendDeletionEmergencialContactRepository;

  @override
  SendDeletionEmergencialContactUsecaseCallback call({
    required String idEmergencialContact,
  }) {
    return _sendDeletionEmergencialContactRepository.call(
      idEmergencialContact: idEmergencialContact,
    );
  }
}
