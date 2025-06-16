import '../../../../core/types/either.dart';
import '../../domain/failures/profile_failure.dart';
import '../../domain/repositories/get_administrative_region_repository.dart';
import '../../domain/types/profile_domain_types.dart';
import '../adapters/administrative_region_entity_adapter.dart';
import '../datasources/get_administrative_region_datasource.dart';

class GetAdministrativeRegionRepositoryImpl implements GetAdministrativeRegionRepository {
  final GetAdministrativeRegionDatasource _getAdministrativeRegionDatasource;
  final AdministrativeRegionEntityAdapter _administrativeRegionEntityAdapter;

  const GetAdministrativeRegionRepositoryImpl({
    required GetAdministrativeRegionDatasource getAdministrativeRegionDatasource,
    required AdministrativeRegionEntityAdapter administrativeRegionEntityAdapter,
  })  : _getAdministrativeRegionDatasource = getAdministrativeRegionDatasource,
        _administrativeRegionEntityAdapter = administrativeRegionEntityAdapter;

  @override
  GetAdministrativeRegionUsecaseCallback call({
    required String cityId,
  }) async {
    try {
      final getAdministrativeRegionModelList = await _getAdministrativeRegionDatasource.call(
        cityId: cityId,
      );

      final getAdministrativeRegionEntityList = getAdministrativeRegionModelList.map(
        (administrativeRegionModel) {
          return _administrativeRegionEntityAdapter.fromModel(
            administrativeRegionModel: administrativeRegionModel,
          );
        },
      ).toList();

      return right(getAdministrativeRegionEntityList);
    } catch (error) {
      return left(const ProfileDatasourceFailure());
    }
  }
}
