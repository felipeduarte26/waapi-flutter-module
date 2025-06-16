import 'dart:developer';

import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';

import '../enums/token_type.dart';
import '../services/session/isession_service.dart';
import 'get_token_usecase.dart';

/// Deauthenticate the user user located in the authentication library
abstract class DeauthenticateUserUsecase {
  Future<void> call();
}

class DeauthenticateUserUsecaseImpl implements DeauthenticateUserUsecase {
  final AuthenticationBloc _authenticationBloc;
  final GetTokenUsecase _getTokenUsecase;
  final ISessionService _sessionService;

  const DeauthenticateUserUsecaseImpl({
    required AuthenticationBloc authenticationBloc,
    required GetTokenUsecase getTokenUsecase,
    required ISessionService sessionService,
  })  : _authenticationBloc = authenticationBloc,
        _getTokenUsecase = getTokenUsecase,
        _sessionService = sessionService;

  @override
  Future<void> call() async {
    Token? userToken = await _getTokenUsecase(tokenType: TokenType.user);
    if (userToken != null) {
      _authenticationBloc.add(
        LogoutOfflineRequested(
          username: userToken.username!,
        ),
      );

      log('DeauthenticateUserUsecase: Logoff user');
    }
    await _sessionService.clean();
  }
}
