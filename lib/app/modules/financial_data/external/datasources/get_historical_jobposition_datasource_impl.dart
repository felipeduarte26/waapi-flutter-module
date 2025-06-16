import 'dart:convert';

import '../../../../core/services/rest_client/rest_service.dart';
import '../../infra/datasources/get_historical_jobposition_datasource.dart';
import '../../infra/models/historical_job_position_model.dart';
import '../mappers/historical_job_position_model_mapper.dart';

class GetHistoricalJobpositionDatasourceImpl implements GetHistoricalJobpositionDataSource {
  final RestService _restService;
  final HistoricalJobPositionModelMapper _historicalJobPositionModelMapper;

  GetHistoricalJobpositionDatasourceImpl({
    required RestService restService,
    required HistoricalJobPositionModelMapper historicalJobPositionModelMapper,
  })  : _restService = restService,
        _historicalJobPositionModelMapper = historicalJobPositionModelMapper;

  @override
  Future<List<HistoricalJobPositionModel>> call({
    required String employeeId,
  }) async {
    try {
      final response = await _restService.legacyManagementPanelService().get(
            '/historical-jobposition/$employeeId?offset=0&limit=100',
          );

      final historicalJobPositionDecode = jsonDecode(
        response.data!,
      );

      final historicalJobPositionList = _historicalJobPositionModelMapper.fromMap(
        listMap: historicalJobPositionDecode,
      );

      return historicalJobPositionList;
    } catch (e) {
      return List<HistoricalJobPositionModel>.empty();
    }
  }
}
