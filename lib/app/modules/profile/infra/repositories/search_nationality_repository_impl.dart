import '../../../../core/types/either.dart';
import '../../domain/failures/profile_failure.dart';
import '../../domain/repositories/search_nationality_repository.dart';
import '../../domain/types/profile_domain_types.dart';
import '../adapters/nationality_entity_adapter.dart';
import '../datasources/search_nationality_datasource.dart';

class SearchNationalityRepositoryImpl implements SearchNationalityRepository {
  final SearchNationalityDatasource _searchNationalityDatasource;
  final NationalityEntityAdapter _nationalityEntityAdapter;

  const SearchNationalityRepositoryImpl({
    required SearchNationalityDatasource searchNationalityDatasource,
    required NationalityEntityAdapter nationalityEntityAdapter,
  })  : _searchNationalityDatasource = searchNationalityDatasource,
        _nationalityEntityAdapter = nationalityEntityAdapter;

  @override
  SearchNationalityUsecaseCallback call({
    required String nationality,
  }) async {
    try {
      final searchNationalityModelList = await _searchNationalityDatasource.call(
        nationality: nationality,
      );

      final searchNationalityEntityList = searchNationalityModelList.map(
        (nationalityModel) {
          return _nationalityEntityAdapter.fromModel(
            nationalityModel: nationalityModel,
          );
        },
      ).toList();

      return right(searchNationalityEntityList);
    } catch (error) {
      return left(const ProfileDatasourceFailure());
    }
  }
}
