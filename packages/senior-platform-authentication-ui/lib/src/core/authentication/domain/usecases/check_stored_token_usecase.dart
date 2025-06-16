import 'package:senior_platform_authentication/senior_platform_authentication.dart';
import '../../data/repositories/secure_storage_repository.dart';
import '../entities/user_name.dart';
import 'check_status_connection_usecase.dart';

/// Verifies if the current stored token is valid.
///
/// Return `true` if the token is valid and `false` if not.
class CheckStoredTokenUsecase implements BaseUsecase<bool, UserName> {
  late final SecureStorageRepository _secureStorageRepository;
  late final GetUserUsecase _getUserUsecase;
  late final CheckStatusConnectionUsecase _checkStatusConnectionUsecase;

  CheckStoredTokenUsecase({
    SecureStorageRepository? secureStorageRepository,
    required GetUserUsecase getUserUsecase,
    required CheckStatusConnectionUsecase checkStatusConnectionUsecase,
  }) {
    _secureStorageRepository =
        secureStorageRepository ?? SecureStorageRepositoryImpl();
    _getUserUsecase = getUserUsecase;
    _checkStatusConnectionUsecase = checkStatusConnectionUsecase;
  }

  @override
  Future<bool> call(UserName username, {bool checkOnline = true}) async {
    try {
      final currentUsername = username.currentUsername?.isEmpty ?? true
          ? await _secureStorageRepository.readLastUser() ?? ''
          : username.currentUsername!;

      final token =
          await _secureStorageRepository.readToken(username: currentUsername);

      final tokenExpirationDate = await _secureStorageRepository
          .readTokenExpirationDate(username: currentUsername);

      if (token == null) {
        return false;
      }

      if (token.accessToken.isEmpty) {
        return false;
      }

      if (token.refreshToken.isEmpty) {
        return false;
      }

      if (tokenExpirationDate == null) {
        return false;
      }

      if (tokenExpirationDate.isBefore(DateTime.now())) {
        return false;
      }

      if (checkOnline) {
        final isOnline = await _checkStatusConnectionUsecase.call(NoParams());
        if (isOnline) {
          await _getUserUsecase.call(
            GetUserInput(
              accessToken: token.accessToken,
              includePhoto: SeniorAuthentication.includePhoto,
            ),
          );
        }
      }

      return true;
    } catch (e) {
      return e is TimeoutException;
    }
  }
}
