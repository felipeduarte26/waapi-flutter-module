import 'dart:developer';

import '../../../../../senior_platform_authentication_ui.dart';

/// Get current user on local storage.
///
/// This usecase does not syncronize the user local data with remote data.
/// Use it to get the user that is saved on local storage.
class GetStoredUserUsecase implements BaseUsecase<User?, UserName> {
  late final SecureStorageRepository _secureStorageRepository;
  late final ClearStoredDataUsecase _clearStoredDataUsecase;

  GetStoredUserUsecase({
    SecureStorageRepository? secureStorageRepository,
    ClearStoredDataUsecase? clearStoredDataUsecase,
  }) {
    _secureStorageRepository =
        secureStorageRepository ?? SecureStorageRepositoryImpl();
    _clearStoredDataUsecase =
        clearStoredDataUsecase ?? ClearStoredDataUsecase();
  }

  @override
  Future<User?> call(UserName username) async {
    try {
      final currentUsername = username.currentUsername?.isEmpty ?? true
          ? await _secureStorageRepository.readLastUser() ?? ''
          : username.currentUsername!;

      return await _secureStorageRepository.readUser(
        username: currentUsername,
      );
    } catch (e) {
      log('GET STORED USER ERROR >>>> ${e.toString()}');
      try {
        await _clearStoredDataUsecase(username);
      } catch (e) {
        return null;
      }
      return null;
    }
  }
}
