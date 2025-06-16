import '../../../../../senior_platform_authentication_ui.dart';

typedef TokenResult = ({Token? token, Exception? exception});

/// Get current token on local storage.
///
/// This usecase does not syncronize the token local data with remote data.
/// Use it to get the token that is saved on local storage.
class GetStoredTokenUsecase implements BaseUsecase<TokenResult, UserName> {
  late final SecureStorageRepository _secureStorageRepository;
  late final ClearStoredDataUsecase _clearStoredDataUsecase;

  GetStoredTokenUsecase({
    SecureStorageRepository? secureStorageRepository,
    ClearStoredDataUsecase? clearStoredDataUsecase,
  }) {
    _secureStorageRepository =
        secureStorageRepository ?? SecureStorageRepositoryImpl();
    _clearStoredDataUsecase =
        clearStoredDataUsecase ?? ClearStoredDataUsecase();
  }

  @override
  Future<TokenResult> call(UserName username) async {
    try {
      final currentUsername = username.currentUsername?.isEmpty ?? true
          ? await _secureStorageRepository.readLastUser() ?? ''
          : username.currentUsername!;

      final token =
          await _secureStorageRepository.readToken(username: currentUsername);

      return (token: token, exception: null);
    } catch (e) {
      try {
        await _clearStoredDataUsecase(username);
      } catch (clearException) {
        // Ignore clear exception, we will return the original one
      }
      return (token: null, exception: e as Exception);
    }
  }
}
