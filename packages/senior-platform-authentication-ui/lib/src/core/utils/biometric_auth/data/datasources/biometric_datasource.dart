import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import '../../../locale_helper.dart';

import '../../../../../../senior_platform_authentication_ui.dart';

abstract class BiometricDatasource {
  Future<bool> canCheckBiometrics();
  Future<BiometryStatus> biometricsAuthenticate();
  Future<bool> getAvailableBiometrics();
}

class BiometricDatasourceImpl implements BiometricDatasource {
  late final LocalAuthentication _localAuthentication;

  BiometricDatasourceImpl({
    LocalAuthentication? localAuthentication,
  }) {
    _localAuthentication = localAuthentication ?? LocalAuthentication();
  }

  //Checks if your device supports biometrics and if it is enabled
  @override
  Future<bool> canCheckBiometrics() async {
    try {
      return await _localAuthentication.canCheckBiometrics;
    } catch (e) {
      return false;
    }
  }

  //Authenticate the user using biometrics
  @override
  Future<BiometryStatus> biometricsAuthenticate() async {
    BiometryStatus biometryStatus = BiometryStatus.unknown;
    bool authenticated = false;

    try {
      authenticated = await _localAuthentication.authenticate(
        //message that will appear on the biometrics screen
        localizedReason: _getLocalizedReason(),
        authMessages: <AuthMessages>[
          AndroidAuthMessages(
            signInTitle: _getSignInTitle(),
            biometricHint: '',
          ),
        ],
        options: AuthenticationOptions(
          sensitiveTransaction: true,
          biometricOnly: SeniorAuthentication.enableBiometryOnly,
        ),
      );
      authenticated
          ? biometryStatus = BiometryStatus.success
          : biometryStatus = BiometryStatus.canceled;
    } catch (e) {
      biometryStatus = BiometryStatus.error;
    }
    return biometryStatus;
  }

  @override
  Future<bool> getAvailableBiometrics() async {
    try {
      final availableBiometrics =
          await _localAuthentication.getAvailableBiometrics();

      return availableBiometrics.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  String _getSignInTitle() {
    final String locale = LocaleHelper.languageAndCountryCode;
    switch (locale) {
      case 'pt':
        return 'Acesso à conta com biometria';
      case 'en':
        return 'Account access with biometrics';
      case 'es':
        return 'Acceso a la cuenta por biometría';
      default:
        return 'Acesso à conta com biometria';
    }
  }

  String _getLocalizedReason() {
    final String locale = LocaleHelper.languageAndCountryCode;
    switch (locale) {
      case 'pt':
        return 'Verifique sua identidade';
      case 'en':
        return 'Verify identity';
      case 'es':
        return 'Verifique su identidad';
      default:
        return 'Verifique sua identidade';
    }
  }
}
