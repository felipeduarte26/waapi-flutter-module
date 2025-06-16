import 'dart:convert';

import '../../../../core/services/rest_client/rest_service.dart';
import '../../infra/datasources/get_vacations_analytics_datasource.dart';
import '../../infra/models/vacations_analytics_model.dart';
import '../mappers/vacations_analytics_model_mapper.dart';

class GetVacationsAnalyticsDatasourceImpl implements GetVacationsAnalyticsDatasource {
  final RestService _restService;
  final VacationsAnalyticsModelMapper _vacationsAnalyticsModelMapper;

  const GetVacationsAnalyticsDatasourceImpl({
    required RestService restService,
    required VacationsAnalyticsModelMapper vacationsAnalyticsModelMapper,
  })  : _restService = restService,
        _vacationsAnalyticsModelMapper = vacationsAnalyticsModelMapper;

  @override
  Future<VacationsAnalyticsModel> call({
    required String employeeId,
  }) async {
    final vacationAnalyticsPath = '/vacation/employee/$employeeId/count';
    final vacationsAnalyticsResponse = await _restService.legacyManagementPanelService().get(vacationAnalyticsPath);

    final vacationsAnalyticsResponseDecoded = jsonDecode(vacationsAnalyticsResponse.data!);

    final vacationsAnalyticsModel = _vacationsAnalyticsModelMapper.fromMap(
      map: vacationsAnalyticsResponseDecoded,
    );

    return vacationsAnalyticsModel;
  }
}
