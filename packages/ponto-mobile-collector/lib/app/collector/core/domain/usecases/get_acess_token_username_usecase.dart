import '../enums/token_type.dart';
import 'get_token_usecase.dart';

abstract class GetAccessTokenUsernameUsecase {
  Future<String?> call();
}

class GetAccessTokenUsernameUsecaseImpl
    implements GetAccessTokenUsernameUsecase {
  final GetTokenUsecase _getTokenUsecase;

  const GetAccessTokenUsernameUsecaseImpl({
    required GetTokenUsecase getTokenUsecase,
  }) : _getTokenUsecase = getTokenUsecase;

  @override
  Future<String?> call() async {
    return (await _getTokenUsecase.call(tokenType: TokenType.user))?.username;
  }
}
