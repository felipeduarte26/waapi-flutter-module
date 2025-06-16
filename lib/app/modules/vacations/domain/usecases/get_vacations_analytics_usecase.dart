import '../repositories/get_vacations_analytics_repository.dart';
import '../types/vacations_domain_types.dart';

abstract class GetVacationsAnalyticsUsecase {
  GetVacationsAnalyticsUsecaseCallback call({
    required String employeeId,
  });
}

class GetVacationsAnalyticsUsecaseImpl implements GetVacationsAnalyticsUsecase {
  final GetVacationsAnalyticsRepository _getVacationsAnalyticsRepository;

  GetVacationsAnalyticsUsecaseImpl({
    required GetVacationsAnalyticsRepository getVacationsAnalyticsRepository,
  }) : _getVacationsAnalyticsRepository = getVacationsAnalyticsRepository;

  @override
  GetVacationsAnalyticsUsecaseCallback call({
    required String employeeId,
  }) {
    return _getVacationsAnalyticsRepository.call(
      employeeId: employeeId,
    );
  }
}
