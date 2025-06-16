import '../../../../core/types/either.dart';
import '../../domain/failures/profile_failure.dart';
import '../../domain/repositories/search_ethnicity_repository.dart';
import '../../domain/types/profile_domain_types.dart';
import '../adapters/ethnicity_entity_adapter.dart';
import '../datasources/search_ethnicity_datasource.dart';

class SearchEthnicityRepositoryImpl implements SearchEthnicityRepository {
  final SearchEthnicityDatasource _searchEthnicityDatasource;
  final EthnicityEntityAdapter _ethnicityEntityAdapter;

  const SearchEthnicityRepositoryImpl({
    required SearchEthnicityDatasource searchEthnicityDatasource,
    required EthnicityEntityAdapter ethnicityEntityAdapter,
  })  : _searchEthnicityDatasource = searchEthnicityDatasource,
        _ethnicityEntityAdapter = ethnicityEntityAdapter;

  @override
  SearchEthnicityUsecaseCallback call({
    required String ethnicity,
  }) async {
    try {
      final searchEthnicityModelList = await _searchEthnicityDatasource.call(
        ethnicity: ethnicity,
      );

      final searchEthnicityEntityList = searchEthnicityModelList.map((ethnicityModel) {
        return _ethnicityEntityAdapter.fromModel(
          ethnicityModel: ethnicityModel,
        );
      }).toList();

      return right(searchEthnicityEntityList);
    } catch (error) {
      return left(const ProfileDatasourceFailure());
    }
  }
}
