import '../../../../../../senior_platform_authentication_ui.dart';

/// Verifies if the current stored token is valid.
///
/// Return `true` if the token is valid and `false` if not.
class CheckKeyStoredTokenUsecase implements BaseUsecase<bool, String> {
  late final SecureStorageRepository _secureStorageRepository;
  late final CheckStatusConnectionUsecase _checkStatusConnectionUsecase;
  late final AuthenticateKeyUsecase _authenticationKeyUsecase;

  CheckKeyStoredTokenUsecase({
    SecureStorageRepository? secureStorageRepository,
    CheckStatusConnectionUsecase? checkStatusConnectionUsecase,
    AuthenticateKeyUsecase? authenticateKeyUsecase,
  }) {
    _secureStorageRepository =
        secureStorageRepository ?? SecureStorageRepositoryImpl();
    _checkStatusConnectionUsecase = checkStatusConnectionUsecase ??
        CheckStatusConnectionUsecase(
            getConnectivityStatusUsecase: GetConnectivityStatusUsecase());
    _authenticationKeyUsecase =
        authenticateKeyUsecase ?? AuthenticateKeyUsecase();
  }

  @override
  Future<bool> call([String? accessKey]) async {
    try {
      final currentAccessKey = accessKey?.isEmpty ?? true
          ? await _secureStorageRepository.readLastKey() ?? ''
          : accessKey!;

      final loginWithKey =
          await _secureStorageRepository.readKey(accessKey: currentAccessKey);

      if (loginWithKey == null) {
        return false;
      }

      final token = await _secureStorageRepository.readKeyToken(
          accessKey: currentAccessKey);

      final tokenExpirationDate = await _secureStorageRepository
          .readKeyTokenExpirationDate(accessKey: currentAccessKey);

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

      final isOnline = await _checkStatusConnectionUsecase.call(NoParams());
      if (isOnline) {
        final response = await _authenticationKeyUsecase.call();
        if (response == null || response.token == null) {
          return false;
        }
      }

      return true;
    } catch (_) {
      return false;
    }
  }
}
