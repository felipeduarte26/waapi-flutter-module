import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';

abstract class AuthenticateRegisteredKeyUsecase {
  Future<bool> call();
}

class AuthenticateRegisteredKeyUsecaseImpl
    implements AuthenticateRegisteredKeyUsecase {
  final AuthenticateKeyUsecase _authenticateKeyUsecase;

  const AuthenticateRegisteredKeyUsecaseImpl({
    required AuthenticateKeyUsecase authenticateKeyUsecase,
  }) : _authenticateKeyUsecase = authenticateKeyUsecase;

  @override
  Future<bool> call() async {
    AuthenticationResponse? response = await _authenticateKeyUsecase.call();
    return response != null;
  }
}
