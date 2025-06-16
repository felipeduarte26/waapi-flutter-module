import '../../../../core/services/rest_client/rest_service.dart';
import '../../infra/datasources/get_education_degree_datasource.dart';
import '../../infra/models/education_degree_model.dart';
import '../mappers/education_degree_model_mapper.dart';

class GetEducationDegreeDatasourceImpl implements GetEducationDegreeDatasource {
  final RestService _restService;
  final EducationDegreeModelMapper _educationDegreeModelMapper;

  const GetEducationDegreeDatasourceImpl({
    required RestService restService,
    required EducationDegreeModelMapper educationDegreeModelMapper,
  })  : _restService = restService,
        _educationDegreeModelMapper = educationDegreeModelMapper;

  @override
  Future<List<EducationDegreeModel>> call() async {
    final getEducationDegreeResult = await _restService.legacyManagementPanelService().get(
          '/education-degree/all',
        );

    return _educationDegreeModelMapper.fromJsonList(
      educationDegreeJson: getEducationDegreeResult.data ?? '{}',
    );
  }
}
