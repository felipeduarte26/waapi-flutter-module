import '../../../../core/types/either.dart';
import '../../domain/failures/vacations_failure.dart';
import '../../domain/input_models/send_vacation_request_input_model.dart';
import '../../domain/repositories/send_vacation_request_repository.dart';
import '../../domain/types/vacations_domain_types.dart';
import '../datasources/send_vacation_request_datasource.dart';

class SendVacationRequestRepositoryImpl implements SendVacationRequestRepository {
  final SendVacationRequestDatasource _sendVacationRequestDatasource;

  const SendVacationRequestRepositoryImpl({
    required SendVacationRequestDatasource sendVacationRequestDatasource,
  }) : _sendVacationRequestDatasource = sendVacationRequestDatasource;

  @override
  SendVacationRequestUsecaseCallback call({
    required SendVacationRequestInputModel sendVacationRequestInputModel,
  }) async {
    try {
      final sendVacationResult = await _sendVacationRequestDatasource.call(
        sendVacationRequestInputModel: sendVacationRequestInputModel,
      );

      sendVacationResult.fold(
        (failures) {
          throw failures;
        },
        (unit) {
          return unit;
        },
      );

      return right(unit);
    } catch (error) {
      if (error is List<String>) {
        return left(
          VacationRequestFailure(
            messagesError: error,
          ),
        );
      }

      return left(const VacationsDatasourceFailure());
    }
  }
}
