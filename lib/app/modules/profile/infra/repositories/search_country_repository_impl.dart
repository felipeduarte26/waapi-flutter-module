import '../../../../core/types/either.dart';
import '../../domain/failures/profile_failure.dart';
import '../../domain/repositories/search_country_repository.dart';
import '../../domain/types/profile_domain_types.dart';
import '../adapters/country_entity_adapter.dart';
import '../datasources/search_country_datasource.dart';

class SearchCountryRepositoryImpl implements SearchCountryRepository {
  final SearchCountryDatasource _searchCountryDatasource;
  final CountryEntityAdapter _countryEntityAdapter;

  const SearchCountryRepositoryImpl({
    required SearchCountryDatasource searchCountryDatasource,
    required CountryEntityAdapter countryEntityAdapter,
  })  : _searchCountryDatasource = searchCountryDatasource,
        _countryEntityAdapter = countryEntityAdapter;

  @override
  SearchCountryUsecaseCallback call({
    required String country,
  }) async {
    try {
      final searchCountryModelList = await _searchCountryDatasource.call(
        country: country,
      );

      final searchCountryEntityList = searchCountryModelList.map(
        (countryModel) {
          return _countryEntityAdapter.fromModel(
            countryModel: countryModel,
          );
        },
      ).toList();

      return right(searchCountryEntityList);
    } catch (error) {
      return left(const ProfileDatasourceFailure());
    }
  }
}
