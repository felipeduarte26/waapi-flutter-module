import '../../../../core/types/either.dart';
import '../../domain/failures/profile_failure.dart';
import '../../domain/repositories/get_gender_identity_repository.dart';
import '../../domain/types/profile_domain_types.dart';
import '../adapters/gender_identity_adapter.dart';
import '../datasources/get_gender_identity_datasource.dart';

class GetGenderIdentityRepositoryImpl implements GetGenderIdentityRepository {
  final GetGenderIdentityDatasource _getGenderIdentityDatasource;
  final GenderIdentityEntityAdapter _genderIdentityEntityAdapter;

  const GetGenderIdentityRepositoryImpl({
    required GetGenderIdentityDatasource getGenderIdentityDatasource,
    required GenderIdentityEntityAdapter genderIdentityEntityAdapter,
  })  : _getGenderIdentityDatasource = getGenderIdentityDatasource,
        _genderIdentityEntityAdapter = genderIdentityEntityAdapter;

  @override
  GetGenderIdentityUsecaseCallback call() async {
    try {
      final getGenderIdentitiesModel = await _getGenderIdentityDatasource.call();

      final getGenderIdentitiesEntity = getGenderIdentitiesModel.map(
        (genderIdentityModel) {
          return _genderIdentityEntityAdapter.fromModel(
            genderIdentityModel: genderIdentityModel,
          );
        },
      ).toList();

      return right(getGenderIdentitiesEntity);
    } catch (error) {
      return left(const ProfileDatasourceFailure());
    }
  }
}
