import '../models/vacations_analytics_model.dart';

abstract class GetVacationsAnalyticsDatasource {
  Future<VacationsAnalyticsModel> call({
    required String employeeId,
  });
}
