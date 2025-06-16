import '../repositories/get_vacation_schedule_individual_repository.dart';
import '../types/vacations_domain_types.dart';

abstract class GetVacationScheduleIndividualUsecase {
  GetVacationScheduleIndividualUseCaseCallback call({
    required String employeeId,
    required String vacationId,
  });
}

class GetVacationScheduleIndividualUsecaseImpl implements GetVacationScheduleIndividualUsecase {
  final GetVacationScheduleIndividualRepository _getVacationScheduleIndividualRepository;

  const GetVacationScheduleIndividualUsecaseImpl({
    required GetVacationScheduleIndividualRepository getVacationScheduleIndividualRepository,
  }) : _getVacationScheduleIndividualRepository = getVacationScheduleIndividualRepository;

  @override
  GetVacationScheduleIndividualUseCaseCallback call({
    required String employeeId,
    required String vacationId,
  }) async {
    final getVacationScheduleIndividualUseCaseCallback = await _getVacationScheduleIndividualRepository.call(
      employeeId: employeeId,
      vacationId: vacationId,
    );

    getVacationScheduleIndividualUseCaseCallback.fold(
      (left) {
        return left;
      },
      (vacationScheduleIndividualEntity) {
        return vacationScheduleIndividualEntity;
      },
    );

    return getVacationScheduleIndividualUseCaseCallback;
  }
}
