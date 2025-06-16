import '../../../../core/types/either.dart';
import '../../domain/failures/profile_failure.dart';
import '../../domain/repositories/get_diversity_repository.dart';
import '../../domain/types/profile_domain_types.dart';
import '../adapters/diversity_entity_adapter.dart';
import '../datasources/get_diversity_datasource.dart';

class GetDiversityRepositoryImpl implements GetDiversityRepository {
  final GetDiversityDatasource _getDiversityDatasource;
  final DiversityEntityAdapter _diversityEntityAdapter;

  const GetDiversityRepositoryImpl({
    required GetDiversityDatasource getDiversityDatasource,
    required DiversityEntityAdapter diversityEntityAdapter,
  })  : _getDiversityDatasource = getDiversityDatasource,
        _diversityEntityAdapter = diversityEntityAdapter;

  @override
  GetDiversityUsecaseCallback call({
    required String personId,
  }) async {
    try {
      final diversityModel = await _getDiversityDatasource.call(
        personId: personId,
      );

      final diversityEntity = diversityModel != null
          ? _diversityEntityAdapter.fromModel(
              diversityModel: diversityModel,
            )
          : null;

      return right(diversityEntity);
    } catch (error) {
      return left(const ProfileDatasourceFailure());
    }
  }
}
