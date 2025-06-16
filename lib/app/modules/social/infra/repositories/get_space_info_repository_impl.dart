
import '../../../../core/types/either.dart';
import '../../domain/failures/social_failure.dart';
import '../../domain/repositories/get_space_info_repository.dart';
import '../../domain/types/social_domain_types.dart';
import '../adapters/social_space_entity_adapter.dart';
import '../datasources/get_space_info_datasource.dart';

class GetSpaceInfoRepositoryImpl implements GetSpaceInfoRepository {
 
  final GetSpaceInfoDatasource _getSpaceInfoDatasource;
  final SocialSpaceEntityAdapter _socialSpaceEntityAdapter;

  GetSpaceInfoRepositoryImpl({
    
    required GetSpaceInfoDatasource getSpaceInfoDatasource,
    required SocialSpaceEntityAdapter socialSpaceEntityAdapter,
  })  : 
        _getSpaceInfoDatasource = getSpaceInfoDatasource,
        _socialSpaceEntityAdapter = socialSpaceEntityAdapter;

  @override
  GetSpaceInfoUsecaseCallback call({
    required String permaname,
  }) async {
    try {
      final socialSpaceModel = await _getSpaceInfoDatasource.call(
        permaname: permaname,
      );

      final socialSpaceEntity = _socialSpaceEntityAdapter.fromModel(
        spaceModel: socialSpaceModel,
      );

      return right(socialSpaceEntity);
    } catch (error) {


      return left(SocialDatasourceFailure());
    }
  }
}
