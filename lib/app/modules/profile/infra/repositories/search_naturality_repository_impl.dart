import '../../../../core/types/either.dart';
import '../../domain/failures/profile_failure.dart';
import '../../domain/repositories/search_naturality_repository.dart';
import '../../domain/types/profile_domain_types.dart';
import '../adapters/city_entity_adapter.dart';
import '../datasources/search_naturality_datasource.dart';

class SearchNaturalityRepositoryImpl implements SearchNaturalityRepository {
  final SearchNaturalityDatasource _searchNaturalityDatasource;
  final CityEntityAdapter _naturalityEntityAdapter;

  const SearchNaturalityRepositoryImpl({
    required SearchNaturalityDatasource searchNaturalityDatasource,
    required CityEntityAdapter naturalityEntityAdapter,
  })  : _searchNaturalityDatasource = searchNaturalityDatasource,
        _naturalityEntityAdapter = naturalityEntityAdapter;

  @override
  SearchNaturalityUsecaseCallback call({
    required String naturality,
  }) async {
    try {
      final searchNaturalityModelList = await _searchNaturalityDatasource.call(
        naturality: naturality,
      );

      final searchNaturalityEntityList = searchNaturalityModelList.map(
        (naturalityModel) {
          return _naturalityEntityAdapter.fromModel(
            cityModel: naturalityModel,
          );
        },
      ).toList();

      return right(searchNaturalityEntityList);
    } catch (error) {
      return left(const ProfileDatasourceFailure());
    }
  }
}
