import '../../../../core/types/either.dart';
import '../../domain/failures/vacations_failure.dart';
import '../../domain/repositories/get_vacations_analytics_repository.dart';
import '../../domain/types/vacations_domain_types.dart';
import '../adapters/vacations_analytics_entity_adapter.dart';
import '../datasources/get_vacations_analytics_datasource.dart';

class GetVacationsAnalyticsRepositoryImpl implements GetVacationsAnalyticsRepository {
  final GetVacationsAnalyticsDatasource _getVacationsAnalyticsDatasource;
  final VacationsAnalyticsEntityAdapter _vacationsAnalyticsEntityAdapter;

  GetVacationsAnalyticsRepositoryImpl({
    required GetVacationsAnalyticsDatasource getVacationsAnalyticsDatasource,
    required VacationsAnalyticsEntityAdapter vacationsAnalyticsEntityAdapter,
  })  : _getVacationsAnalyticsDatasource = getVacationsAnalyticsDatasource,
        _vacationsAnalyticsEntityAdapter = vacationsAnalyticsEntityAdapter;

  @override
  GetVacationsAnalyticsUsecaseCallback call({
    required String employeeId,
  }) async {
    try {
      final vacationsAnalyticsModel = await _getVacationsAnalyticsDatasource.call(
        employeeId: employeeId,
      );

      final vacationsAnalyticsEntity = _vacationsAnalyticsEntityAdapter.fromModel(
        vacationsAnalyticsModel: vacationsAnalyticsModel,
      );

      return right(vacationsAnalyticsEntity);
    } catch (error) {
      return left(const VacationsDatasourceFailure());
    }
  }
}
