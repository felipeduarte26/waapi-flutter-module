import '../../../../core/pagination/pagination_requirements.dart';
import '../../../../core/services/rest_client/rest_service.dart';
import '../../infra/datasources/search_person_by_term_datasource.dart';
import '../../infra/models/person_model.dart';
import '../mappers/person_model_mapper.dart';

class SearchPersonByTermDatasourceImpl implements SearchPersonByTermDatasource {
  final RestService _restService;
  final PersonModelMapper _personModelMapper;

  const SearchPersonByTermDatasourceImpl({
    required RestService restService,
    required PersonModelMapper personModelMapper,
  })  : _restService = restService,
        _personModelMapper = personModelMapper;

  @override
  Future<List<PersonModel>> call({
    required PaginationRequirements paginationRequirements,
  }) async {
    final responseListPerson = await _restService.legacyManagementPanelService().get(
      '/search/person/analytics',
      queryParameters: {
        'start': paginationRequirements.offset,
        'size': paginationRequirements.limit,
        'q': paginationRequirements.queryText,
      },
    );

    return _personModelMapper.fromJsonList(
      personJson: responseListPerson.data!,
    );
  }
}
