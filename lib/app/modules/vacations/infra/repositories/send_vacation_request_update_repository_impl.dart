import '../../../../core/types/either.dart';
import '../../domain/failures/vacations_failure.dart';
import '../../domain/input_models/send_vacation_request_update_input_model.dart';
import '../../domain/repositories/send_vacation_request_update_repository.dart';
import '../../domain/types/vacations_domain_types.dart';
import '../datasources/send_vacation_request_update_datasource.dart';

class SendVacationRequestUpdateRepositoryImpl implements SendVacationRequestUpdateRepository {
  final SendVacationRequestUpdateDatasource _sendVacationRequestUpdateDatasource;

  const SendVacationRequestUpdateRepositoryImpl({
    required SendVacationRequestUpdateDatasource sendVacationRequestUpdateDatasource,
  }) : _sendVacationRequestUpdateDatasource = sendVacationRequestUpdateDatasource;

  @override
  SendVacationRequestUpdateUsecaseCallback call({
    required SendVacationRequestUpdateInputModel sendVacationRequestUpdateInputModel,
  }) async {
    try {
      final sendVacationUpdateResult = await _sendVacationRequestUpdateDatasource.call(
        sendVacationRequestUpdateInputModel: sendVacationRequestUpdateInputModel,
      );

      sendVacationUpdateResult.fold(
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
