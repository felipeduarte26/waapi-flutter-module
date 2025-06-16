import '../../../../core/types/either.dart';
import '../../domain/entities/disability_entity.dart';
import '../../domain/failures/profile_failure.dart';
import '../../domain/repositories/get_disability_repository.dart';
import '../../domain/types/profile_domain_types.dart';
import '../adapters/disability_entity_adapter.dart';
import '../datasources/get_disability_datasource.dart';

const int code = -1;

class GetDisabilityRepositoryImpl implements GetDisabilityRepository {
  final GetDisabilityDatasource _getDisabilityDatasource;
  final DisabilityEntityAdapter _disabilityEntityAdapter;

  const GetDisabilityRepositoryImpl({
    required GetDisabilityDatasource getDisabilityDatasource,
    required DisabilityEntityAdapter disabilityEntityAdapter,
  })  : _getDisabilityDatasource = getDisabilityDatasource,
        _disabilityEntityAdapter = disabilityEntityAdapter;

  @override
  GetDisabilityUsecaseCallback call() async {
    try {
      final getDisabilityModelList = await _getDisabilityDatasource.call();

      final getDisabilityEntityList = getDisabilityModelList
          .map(
            (disabilityModel) {
              if (disabilityModel.code != code) {
                return _disabilityEntityAdapter.fromModel(
                  disabilityModel: disabilityModel,
                );
              }
              return null;
            },
          )
          .whereType<DisabilityEntity>() // Filtra e remove elementos nulos
          .toList();

      return right(getDisabilityEntityList);
    } catch (error) {
      return left(const ProfileDatasourceFailure());
    }
  }
}
