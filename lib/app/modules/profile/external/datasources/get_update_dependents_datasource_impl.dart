import 'dart:convert';

import '../../../../core/services/rest_client/rest_service.dart';
import '../../infra/datasources/get_update_dependents_datasources.dart';
import '../../infra/models/dependent_model.dart';
import '../mappers/dependent_model_mapper.dart';

class GetUpdateDependentsDatasourceImpl implements GetUpdateDependentsDatasource {
  final RestService _restService;
  final DependentModelMapper _dependentModelMapper;

  const GetUpdateDependentsDatasourceImpl({
    required RestService restService,
    required DependentModelMapper dependentModelMapper,
  })  : _restService = restService,
        _dependentModelMapper = dependentModelMapper;

  @override
  Future<DependentModel> call({
    required String requestUpdateId,
  }) async {
    final updateDependentResult = await _restService.legacyManagementPanelService().get(
          '/dependent-update-request/$requestUpdateId',
        );

    final updateDependent = jsonDecode(updateDependentResult.data ?? '{}');

    return _dependentModelMapper.updateDependentFromMap(map: updateDependent);
  }
}
