import '../types/profile_domain_types.dart';

abstract class SendDeletionEmergencialContactRepository {
  SendDeletionEmergencialContactUsecaseCallback call({
    required String idEmergencialContact,
  });
}
