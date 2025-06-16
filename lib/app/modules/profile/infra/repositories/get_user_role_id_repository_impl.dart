import '../../../../core/types/either.dart';
import '../../domain/failures/profile_failure.dart';
import '../../domain/repositories/get_user_role_id_repository.dart';
import '../../domain/types/profile_domain_types.dart';
import '../datasources/get_user_role_id_datasource.dart';

class GetUserRoleIdRepositoryImpl implements GetUserRoleIdRepository {
  final GetUserRoleIdDatasource _getUserRoleIdDatasource;

  const GetUserRoleIdRepositoryImpl({
    required GetUserRoleIdDatasource getUserRoleIdDatasource,
  }) : _getUserRoleIdDatasource = getUserRoleIdDatasource;

  @override
  GetUserRoleIdUsecaseCallback call() async {
    try {
      final userRoleId = await _getUserRoleIdDatasource.call();

      return right(userRoleId);
    } catch (error) {
      return left(const ProfileDatasourceFailure());
    }
  }
}
