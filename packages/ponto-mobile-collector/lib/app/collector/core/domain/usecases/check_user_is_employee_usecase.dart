import '../entities/platform_user.dart';
import '../repositories/database/iemployee_platform_user_repository.dart';
import '../repositories/database/iplatform_user_repository.dart';

abstract class CheckUserIsEmployeeUsecase {
  Future<bool?> call({required String username});
}

class CheckUserIsEmployeeUsecaseImpl implements CheckUserIsEmployeeUsecase {
  final IEmployeePlatformUserRepository employeePlatformUserRepository;
  final IPlatformUserRepository platformUserRepository;

  CheckUserIsEmployeeUsecaseImpl({
    required this.employeePlatformUserRepository,
    required this.platformUserRepository,
  });

  @override
  Future<bool?> call({required String username}) async {
    PlatformUser? platformuser = await platformUserRepository.findByUserName(
      username: username,
    );
    if (platformuser == null) {
      return false;
    }

    var platformUserEmployee =
        await employeePlatformUserRepository.findByPlatformUserId(
      platformUserId: platformuser.id!,
    );

    if (platformUserEmployee != null) {
      return true;
    }
    return false;
  }
}
