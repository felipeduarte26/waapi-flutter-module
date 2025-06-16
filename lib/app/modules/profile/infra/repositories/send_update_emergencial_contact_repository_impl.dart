import '../../../../core/types/either.dart';
import '../../domain/failures/profile_failure.dart';
import '../../domain/input_models/emergencial_contact_input_model.dart';
import '../../domain/repositories/send_update_emergencial_contact_repository.dart';
import '../../domain/types/profile_domain_types.dart';
import '../datasources/send_update_emergencial_contact_datasource.dart';

class SendUpdateEmergencialContactRepositoryImpl implements SendUpdateEmergencialContactRepository {
  final SendUpdateEmergencialContactDatasource _sendUpdateEmergencialContactDatasource;

  SendUpdateEmergencialContactRepositoryImpl({
    required SendUpdateEmergencialContactDatasource sendUpdateEmergencialContactDatasource,
  }) : _sendUpdateEmergencialContactDatasource = sendUpdateEmergencialContactDatasource;

  @override
  SendUpdateEmergencialContactUsecaseCallback call({
    required EmergencialContactInputModel emergencialContactInputModel,
    required String emergencialContactId,
  }) async {
    try {
      await _sendUpdateEmergencialContactDatasource.call(
        emergencialContactInputModel: emergencialContactInputModel,
        emergencialContactId: emergencialContactId,
      );

      return right(unit);
    } catch (error) {
      return left(const SendUpdateEmergencialContactDatasourceFailure());
    }
  }
}
