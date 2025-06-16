import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../senior_platform_authentication_ui.dart';
import 'biometric_security_state.dart';

class BiometricSecurityCubit extends Cubit<BiometricSecurityState> {
  final AuthenticationBloc _authenticationBloc;

  BiometricSecurityCubit({
    required AuthenticationBloc authenticationBloc,
  })  : _authenticationBloc = authenticationBloc,
        super(BiometricSecurityState.initial());

  void unauthenticated({required BiometryStatus biometryStatus}) {
    if (SeniorAuthentication.enableLoginOffline) {
      _authenticationBloc.add(LogoutOfflineRequested(
          username: _authenticationBloc.state.username ?? ''));
    } else {
      _authenticationBloc.add(
        const LogoutOnlineRequested(),
      );
    }
    _authenticationBloc.add(
      AuthenticationStatusChanged(
        AuthenticationStatus.unknown,
        biometryStatus: biometryStatus,
      ),
    );
  }

  Future<void> checkAuthentication() async {
    _authenticationBloc.add(
      const CheckAuthenticationRequested(),
    );
  }
}
