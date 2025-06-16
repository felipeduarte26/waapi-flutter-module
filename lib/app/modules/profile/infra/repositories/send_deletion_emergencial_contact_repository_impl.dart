import '../../../../core/types/either.dart';
import '../../domain/failures/profile_failure.dart';
import '../../domain/repositories/send_deletion_emergencial_contact_repository.dart';
import '../../domain/types/profile_domain_types.dart';
import '../datasources/send_deletion_emergencial_contact_datasource.dart';

class SendDeletionEmergencialContactRepositoryImpl implements SendDeletionEmergencialContactRepository {
  final SendDeletionEmergencialContactDatasource _sendDeletionEmergencialContactDatasource;

  const SendDeletionEmergencialContactRepositoryImpl({
    required SendDeletionEmergencialContactDatasource sendDeletionEmergencialContactDatasource,
  }) : _sendDeletionEmergencialContactDatasource = sendDeletionEmergencialContactDatasource;

  @override
  SendDeletionEmergencialContactUsecaseCallback call({
    required String idEmergencialContact,
  }) async {
    try {
      await _sendDeletionEmergencialContactDatasource.call(
        idEmergencialContact: idEmergencialContact,
      );
      return right(unit);
    } catch (error) {
      return left(const SendDeletionEmergencialContactDatasourceFailure());
    }
  }
}
