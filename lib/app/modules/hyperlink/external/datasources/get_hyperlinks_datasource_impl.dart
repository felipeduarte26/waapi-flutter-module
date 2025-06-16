import '../../../../core/services/rest_client/rest_service.dart';
import '../../infra/datasources/get_hyperlinks_datasource.dart';
import '../../infra/models/hyperlink_model.dart';
import '../mappers/get_hyperlinks_model_mapper.dart';

class GetHyperlinksDatasourceImpl implements GetHyperlinksDatasource {
  final RestService _restService;
  final GetHyperlinksModelMapper _getHyperlinksModelMapper;

  const GetHyperlinksDatasourceImpl({
    required RestService restService,
    required GetHyperlinksModelMapper getHyperlinksModelMapper,
  })  : _restService = restService,
        _getHyperlinksModelMapper = getHyperlinksModelMapper;

  @override
  Future<List<HyperlinkModel>> call({
    required String employeeId,
    required String userRoleId,
  }) async {
    final getHyperlinkResult = await _restService.legacyManagementPanelService().get(
          '/hyperlink/all/$employeeId/$userRoleId',
        );

    return _getHyperlinksModelMapper.fromJsonList(
      json: getHyperlinkResult.data ?? '{}',
    );
  }
}
