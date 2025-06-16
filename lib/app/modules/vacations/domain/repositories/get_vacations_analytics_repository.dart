import '../types/vacations_domain_types.dart';

abstract class GetVacationsAnalyticsRepository {
  GetVacationsAnalyticsUsecaseCallback call({
    required String employeeId,
  });
}
