import '../types/vacations_domain_types.dart';

abstract class GetVacationScheduleIndividualRepository {
  GetVacationScheduleIndividualUseCaseCallback call({
    required String employeeId,
    required String vacationId,
  });
}
