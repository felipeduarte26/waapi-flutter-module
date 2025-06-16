import 'dart:developer';

import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';

class UserTokenService {
  final GetStoredTokenUsecase _getStoredTokenUsecase;

  UserTokenService({
    required GetStoredTokenUsecase getStoredTokenUsecase,
  }) : _getStoredTokenUsecase = getStoredTokenUsecase {
    initializeToken();
  }

  Token? token;

  Future<void> initializeToken() async {
    try {
      final tokenResult = await _getStoredTokenUsecase.call(const UserName());

      token = tokenResult.token;
    } catch (error) {
      log(error.toString());
    }
  }
}
