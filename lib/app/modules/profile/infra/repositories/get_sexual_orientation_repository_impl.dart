import '../../../../core/types/either.dart';
import '../../domain/failures/profile_failure.dart';
import '../../domain/repositories/get_sexual_orientation_repository.dart';
import '../../domain/types/profile_domain_types.dart';
import '../adapters/sexual_orientation_adapter.dart';
import '../datasources/get_sexual_orientation_datasource.dart';

class GetSexualOrientationRepositoryImpl implements GetSexualOrientationRepository {
  final GetSexualOrientationDatasource _getSexualOrientationDatasource;
  final SexualOrientationEntityAdapter _genderIdentityEntityAdapter;

  const GetSexualOrientationRepositoryImpl({
    required GetSexualOrientationDatasource getSexualOrientationDatasource,
    required SexualOrientationEntityAdapter genderIdentityEntityAdapter,
  })  : _getSexualOrientationDatasource = getSexualOrientationDatasource,
        _genderIdentityEntityAdapter = genderIdentityEntityAdapter;

  @override
  GetSexualOrientationUsecaseCallback call() async {
    try {
      final getGenderIdentitiesModel = await _getSexualOrientationDatasource.call();

      final getGenderIdentitiesEntity = getGenderIdentitiesModel.map(
        (genderIdentityModel) {
          return _genderIdentityEntityAdapter.fromModel(
            sexualOrientationModel: genderIdentityModel,
          );
        },
      ).toList();

      return right(getGenderIdentitiesEntity);
    } catch (error) {
      return left(const ProfileDatasourceFailure());
    }
  }
}
