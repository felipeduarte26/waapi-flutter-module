import '../../../../core/types/either.dart';
import '../../domain/failures/vacations_failure.dart';
import '../../domain/repositories/get_vacation_schedule_individual_repository.dart';
import '../../domain/types/vacations_domain_types.dart';
import '../datasources/get_vacation_schedule_individual_datasource.dart';

class GetVacationScheduleIndividualRepositoryImpl implements GetVacationScheduleIndividualRepository {
  final GetVacationScheduleIndividualDatasource _getVacationScheduleIndividualDatasource;

  const GetVacationScheduleIndividualRepositoryImpl({
    required GetVacationScheduleIndividualDatasource getVacationScheduleIndividualDatasource,
  }) : _getVacationScheduleIndividualDatasource = getVacationScheduleIndividualDatasource;

  @override
  GetVacationScheduleIndividualUseCaseCallback call({
    required String employeeId,
    required String vacationId,
  }) async {
    try {
      final vacationIsUpdating = await _getVacationScheduleIndividualDatasource.call(
        employeeId: employeeId,
        vacationId: vacationId,
      );

      return right(vacationIsUpdating);
    } catch (error) {
      return left(const VacationsDatasourceFailure());
    }
  }
}
