import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';

import '../enums/token_type.dart';

abstract class GetTokenUsecase {
  Future<Token?> call({TokenType tokenType = TokenType.first});
}

class GetTokenUsecaseImpl implements GetTokenUsecase {
  final GetStoredTokenUsecase _getStoredTokenUsecase;
  final GetStoredKeyTokenUsecase _getStoredKeyTokenUsecase;

  const GetTokenUsecaseImpl({
    required GetStoredTokenUsecase getStoredTokenUsecase,
    required GetStoredKeyTokenUsecase getStoredKeyTokenUsecase,
  })  : _getStoredTokenUsecase = getStoredTokenUsecase,
        _getStoredKeyTokenUsecase = getStoredKeyTokenUsecase;

  @override
  Future<Token?> call({TokenType tokenType = TokenType.first}) async {
    switch (tokenType) {
      case TokenType.key:
        return await _getStoredKeyTokenUsecase.call(null);
      case TokenType.user:
        return (await _getStoredTokenUsecase.call(const UserName())).token;
      default:
        Token? token = await _getStoredKeyTokenUsecase.call(null);
        token ??= (await _getStoredTokenUsecase.call(const UserName())).token;
        return token;
    }
  }
}
