import '../../enums/vacation_period_situation_enum.dart';
import '../repositories/get_vacations_repository.dart';
import '../types/vacations_domain_types.dart';

abstract class GetVacationsUsecase {
  GetVacationsUsecaseCallback call({
    required String employeeId,
  });
}

class GetVacationsUsecaseImpl implements GetVacationsUsecase {
  final GetVacationsRepository _getVacationsRepository;

  const GetVacationsUsecaseImpl({
    required GetVacationsRepository getVacationsRepository,
  }) : _getVacationsRepository = getVacationsRepository;

  @override
  GetVacationsUsecaseCallback call({
    required String employeeId,
  }) async {
    final getVacationsUsecaseCallback = await _getVacationsRepository.call(
      employeeId: employeeId,
    );

    getVacationsUsecaseCallback.fold(
      (left) {
        return left;
      },
      (vacationsEntityList) {
        /**
         * We are sorted in the use case because the API doesn't provide options for sorting the records. However, 
         * there was no date forecast for the API settings, which will be met when they occur, placed or ordered 
         * from the periods paid off in the use case, in order to resolve an issue and good development practices.
         */
        vacationsEntityList.sort(
          (
            vacationsEntityA,
            vacationsEntityB,
          ) {
            if (vacationsEntityA.vacationPeriodSituation == VacationPeriodSituationEnum.paid &&
                vacationsEntityB.vacationPeriodSituation == VacationPeriodSituationEnum.paid &&
                vacationsEntityA.startDate != null &&
                vacationsEntityB.startDate != null &&
                vacationsEntityB.startDate!.isAfter(vacationsEntityA.startDate!)) {
              return 1;
            }

            return -1;
          },
        );

        return vacationsEntityList;
      },
    );

    return getVacationsUsecaseCallback;
  }
}
