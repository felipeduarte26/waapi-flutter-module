import '../enums/token_type.dart';
import 'get_token_usecase.dart';

abstract class GetAccessTokenUsecase {
  Future<String?> call({TokenType tokenType = TokenType.first});
}

class GetAccessTokenUsecaseImpl implements GetAccessTokenUsecase {
  final GetTokenUsecase _getTokenUsecase;

  const GetAccessTokenUsecaseImpl({
    required GetTokenUsecase getTokenUsecase,
  }) : _getTokenUsecase = getTokenUsecase;

  @override
  Future<String?> call({TokenType tokenType = TokenType.first}) async {
    return (await _getTokenUsecase.call(tokenType: tokenType))?.accessToken;
  }
}
