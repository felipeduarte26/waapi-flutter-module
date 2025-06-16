import '../../../../core/types/either.dart';
import '../../domain/failures/profile_failure.dart';
import '../../domain/input_models/emergencial_contact_input_model.dart';
import '../../domain/repositories/send_emergencial_contact_repository.dart';
import '../../domain/types/profile_domain_types.dart';
import '../datasources/send_emergencial_contact_datasource.dart';

class SendEmergencialContactRepositoryImpl implements SendEmergencialContactRepository {
  final SendEmergencialContactDatasource _emergencialContactUploadedDatasource;

  const SendEmergencialContactRepositoryImpl({
    required SendEmergencialContactDatasource sendEmergencialContactDatasource,
  }) : _emergencialContactUploadedDatasource = sendEmergencialContactDatasource;

  @override
  SendEmergencialContactUsecaseCallback call({
    required EmergencialContactInputModel sendEmergencialContactInputModel,
  }) async {
    try {
      await _emergencialContactUploadedDatasource.call(
        emergencialContactUploadedInputModel: sendEmergencialContactInputModel,
      );

      return right(unit);
    } catch (error) {
      return left(const SendEmergencialContactDatasourceFailure());
    }
  }
}
