import '../../../../core/types/either.dart';
import '../../domain/failures/vacations_failure.dart';
import '../../domain/repositories/cancel_vacation_request_repository.dart';
import '../../domain/types/vacations_domain_types.dart';
import '../datasources/cancel_vacation_approved_request_datasource.dart';
import '../datasources/cancel_vacation_request_datasource.dart';

class CancelVacationRequestRepositoryImpl implements CancelVacationRequestRepository {
  final CancelVacationRequestDatasource _cancelVacationRequestDatasource;
  final CancelVacationApprovedRequestDatasource _cancelVacationApprovedRequestDatasource;

  const CancelVacationRequestRepositoryImpl({
    required CancelVacationRequestDatasource cancelVacationRequestDatasource,
    required CancelVacationApprovedRequestDatasource cancelVacationApprovedRequestDatasource,
  })  : _cancelVacationRequestDatasource = cancelVacationRequestDatasource,
        _cancelVacationApprovedRequestDatasource = cancelVacationApprovedRequestDatasource;

  @override
  CancelVacationRequestUsecaseCallback call({
    required String idVacation,
    required bool isApproved,
    required String employeeId,
  }) async {
    Either<List<String>, Unit> cancelVacationResult;
    try {
      cancelVacationResult = isApproved
          ? await _cancelVacationApprovedRequestDatasource.call(
              employeeId: employeeId,
              vacationSheduleToCancelId: idVacation,
            )
          : await _cancelVacationRequestDatasource.call(
              idVacation: idVacation,
            );

      cancelVacationResult.fold(
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
          CancelVacationRequestFailure(
            messagesError: error,
          ),
        );
      }

      return left(const VacationsDatasourceFailure());
    }
  }
}
