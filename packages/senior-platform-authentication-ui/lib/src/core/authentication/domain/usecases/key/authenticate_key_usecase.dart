import '../../../../../../senior_platform_authentication_ui.dart';
import '../../entities/key_authentication_data.dart';

class AuthenticateKeyUsecase
    implements BaseUsecase<AuthenticationResponse?, String?> {
  late final SecureStorageRepository _secureStorageRepository;
  late final LoginWithKeyUsecase _loginWithKeyUsecase;
  late final StoreKeyAuthenticationDataUsecase
      _storeKeyAuthenticationDataUsecase;
  late final GetTenantLoginSettingsUsecase _getTenantLoginSettingsUsecase;

  AuthenticateKeyUsecase({
    SecureStorageRepository? secureStorageRepository,
    LoginWithKeyUsecase? loginWithKeyUsecase,
    StoreKeyAuthenticationDataUsecase? storeKeyAuthenticationDataUsecase,
    GetTenantLoginSettingsUsecase? getTenantLoginSettingsUsecase,
  }) {
    _secureStorageRepository =
        secureStorageRepository ?? SecureStorageRepositoryImpl();
    _loginWithKeyUsecase = loginWithKeyUsecase ?? LoginWithKeyUsecase();
    _storeKeyAuthenticationDataUsecase = storeKeyAuthenticationDataUsecase ??
        StoreKeyAuthenticationDataUsecase();
    _getTenantLoginSettingsUsecase =
        getTenantLoginSettingsUsecase ?? GetTenantLoginSettingsUsecase();
  }

  @override
  Future<AuthenticationResponse?> call([
    String? accessKey,
    LoginWithKey? loginWithKey,
  ]) async {
    if (loginWithKey == null) {
      accessKey ??= await _secureStorageRepository.readLastKey();

      if (accessKey == null) {
        return null;
      } else {
        loginWithKey =
            await _secureStorageRepository.readKey(accessKey: accessKey);
      }

      if (loginWithKey == null) {
        return null;
      }
    }

    TenantLoginSettings tenantLoginSettings =
        await _getTenantLoginSettingsUsecase
            .call(TenantLogin(tenantDomain: loginWithKey.tenantName));

    loginWithKey =
        loginWithKey.copyWith(tenantName: tenantLoginSettings.tenantName);

    final response = await _loginWithKeyUsecase.call(loginWithKey);

    if (response.token != null) {
      await _storeKeyAuthenticationDataUsecase(
        KeyAuthenticationData(
          loginWithKey: response.loginWithKey,
          token: response.token,
        ),
      );
    }

    return response;
  }
}
