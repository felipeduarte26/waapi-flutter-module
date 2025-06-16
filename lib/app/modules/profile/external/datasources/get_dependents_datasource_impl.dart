import '../../../../core/services/rest_client/rest_service.dart';
import '../../infra/datasources/get_dependents_datasource.dart';
import '../../infra/models/dependent_model.dart';
import '../mappers/dependent_model_mapper.dart';
import 'get_update_dependents_datasource_impl.dart';

class GetDependentsDatasourceImpl implements GetDependentsDatasource {
  final RestService _restService;
  final DependentModelMapper _dependentModelMapper;
  final GetUpdateDependentsDatasourceImpl _getUpdateDependentsDatasourceImpl;

  const GetDependentsDatasourceImpl({
    required RestService restService,
    required DependentModelMapper dependentModelMapper,
    required GetUpdateDependentsDatasourceImpl getUpdateDependentsDatasourceImpl,
  })  : _restService = restService,
        _dependentModelMapper = dependentModelMapper,
        _getUpdateDependentsDatasourceImpl = getUpdateDependentsDatasourceImpl;

  @override
  Future<List<DependentModel>> call({
    required String employeeId,
  }) async {
    final dependentResponse = await _restService.legacyManagementPanelService().get(
          '/dependent/all/$employeeId',
        );

    final data = dependentResponse.data ?? '{}';

    final dependents = _dependentModelMapper.decodeJsonFromKey(
      dependentJson: data,
      key: 'dependents',
    );

    final requestInserts = _dependentModelMapper.decodeJsonFromKey(
      dependentJson: data,
      key: 'requestUpdate',
    );

    final dependentsWithUpdateRequest = await Future.wait(
      dependents.where((dependent) => _dependentModelMapper.hasRequestUpdateId(map: dependent)).map(
            (dependent) async => await _getUpdateDependentsDatasourceImpl.call(
              requestUpdateId: dependent['requestUpdateId'],
            ),
          ),
    );

    dependents.removeWhere((dependent) => _dependentModelMapper.hasRequestUpdateId(map: dependent));

    final remainingDependents = await _dependentModelMapper.fromListDecoded(
      dependents: dependents,
      requestUpdate: requestInserts,
    );

    return [...dependentsWithUpdateRequest, ...remainingDependents];
  }
}
