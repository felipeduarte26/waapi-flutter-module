import 'package:flutter_test/flutter_test.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';

import '../../../../mocks/tenant_login_settings_mock.dart';
import '../../../../mocks/token_mock.dart';

void main() {
  group('KeyAuthenticationState', () {
    test('KeyAuthenticationState.initial test', () async {
      final state = KeyAuthenticationState.initial();
      expect(state.status, NetworkStatus.idle);
      expect(state.accessKey, '');
      expect(state.tenantName, '');
      expect(state.secret, '');
      expect(state.keyAuthenticationFlow, KeyAuthenticationFlow.unknown);
    });

    test('KeyAuthenticationState.copyWith no pass values test', () async {
      final state = KeyAuthenticationState.initial();
      final copyState = state.copyWith();
      expect(state, copyState);
    });

    test('KeyAuthenticationState.copyWith pass values test', () async {
      final state = KeyAuthenticationState(
        accessKey: 'accessKey',
        keyAuthenticationFlow: KeyAuthenticationFlow.domain,
        secret: 'secret',
        status: NetworkStatus.loading,
        tenantName: 'tenantName',
        authenticationResponse: authenticationResponseMock,
        errorType: ErrorType.tenantNotFound,
        tenantLoginSettings: tenantLoginSettingsMock,
      );

      final copyState = KeyAuthenticationState.initial().copyWith(
        accessKey: state.accessKey,
        authenticationResponse: state.authenticationResponse,
        errorType: state.errorType,
        keyAuthenticationFlow: state.keyAuthenticationFlow,
        secret: state.secret,
        status: state.status,
        tenantLoginSettings: state.tenantLoginSettings,
        tenantName: state.tenantName,
      );

      expect(state, copyState);
    });
  });
}
