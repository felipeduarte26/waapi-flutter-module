
import '../../../../core/types/either.dart';
import '../../domain/failures/profile_failure.dart';
import '../../domain/repositories/get_profile_repository.dart';
import '../../domain/types/profile_domain_types.dart';
import '../adapters/profile_entity_adapter.dart';
import '../datasources/get_person_datasource.dart';
import '../datasources/get_profile_datasource.dart';

class GetProfileRepositoryImpl implements GetProfileRepository {
  final GetProfileDatasource _getProfileDatasource;
  final GetPersonDatasource _getPersonDatasource;
  final ProfileEntityAdapter _profileEntityAdapter;
 

  GetProfileRepositoryImpl({
    required GetProfileDatasource getProfileDatasource,
    required GetPersonDatasource getPersonDatasource,
    required ProfileEntityAdapter profileEntityAdapter,
    
  })  : _getProfileDatasource = getProfileDatasource,
        _getPersonDatasource = getPersonDatasource,
        _profileEntityAdapter = profileEntityAdapter;
        

  @override
  GetProfileUsecaseCallback call({
    required String employeeId,
    required String personId,
  }) async {
    try {
      final profileModel = await _getProfileDatasource.call(
        employeeId: employeeId,
      );

      final personModel = await _getPersonDatasource.call(
        personId: personId,
      );

      final profileEntity = _profileEntityAdapter.fromModel(
        profileModel: profileModel,
        personModel: personModel,
      );

      return right(profileEntity);
    } catch (error) {


      return left(const ProfileDatasourceFailure());
    }
  }
}
