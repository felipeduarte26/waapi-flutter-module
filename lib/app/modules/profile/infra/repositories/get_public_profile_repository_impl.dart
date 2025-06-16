
import '../../../../core/types/either.dart';
import '../../domain/failures/profile_failure.dart';
import '../../domain/repositories/get_public_profile_repository.dart';
import '../../domain/types/profile_domain_types.dart';
import '../adapters/public_profile_entity_adapter.dart';
import '../datasources/get_public_profile_datasource.dart';

class GetPublicProfileRepositoryImpl implements GetPublicProfileRepository {
  final GetPublicProfileDatasource _getPublicProfileDatasource;
  final PublicProfileEntityAdapter _publicProfileEntityAdapter;
 

  const GetPublicProfileRepositoryImpl({
    required GetPublicProfileDatasource getPublicProfileDatasource,
    
    required PublicProfileEntityAdapter publicProfileEntityAdapter,
  })  : _getPublicProfileDatasource = getPublicProfileDatasource,
        
        _publicProfileEntityAdapter = publicProfileEntityAdapter;

  @override
  GetPublicProfileUsecaseCallback call({
    required String userName,
  }) async {
    try {
      final publicProfileModel = await _getPublicProfileDatasource.call(
        userName: userName,
      );

      final publicProfileEntity = _publicProfileEntityAdapter.fromModel(
        publicProfileModel: publicProfileModel,
      );

      return right(publicProfileEntity);
    } catch (error) {


      return left(const ProfileDatasourceFailure());
    }
  }
}
