import '../repositories/get_user_role_id_repository.dart';
import '../types/profile_domain_types.dart';

abstract class GetUserRoleIdUsecase {
  GetUserRoleIdUsecaseCallback call();
}

class GetUserRoleIdUsecaseImpl implements GetUserRoleIdUsecase {
  final GetUserRoleIdRepository _getUserRoleIdRepository;

  const GetUserRoleIdUsecaseImpl({
    required GetUserRoleIdRepository getUserRoleIdRepository,
  }) : _getUserRoleIdRepository = getUserRoleIdRepository;

  @override
  GetUserRoleIdUsecaseCallback call() {
    return _getUserRoleIdRepository.call();
  }
}
