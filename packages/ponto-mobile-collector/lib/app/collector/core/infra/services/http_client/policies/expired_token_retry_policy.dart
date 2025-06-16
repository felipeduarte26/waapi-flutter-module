import 'package:http_interceptor/http_interceptor.dart';

import '../../../../domain/enums/token_type.dart';
import '../../../../domain/usecases/authenticate_registered_key_usecase.dart';
import '../../../../domain/usecases/get_access_token_usecase.dart';
import '../../../../domain/usecases/refresh_access_token_usecase.dart';

class ExpiredTokenRetryPolicy extends RetryPolicy {
  final RefreshAccessTokenUsecase _refreshAccessTokenUsecase;
  final GetAccessTokenUsecase _getAccessTokenUsecase;
  final AuthenticateRegisteredKeyUsecase _authenticateRegisteredKeyUsecase;

  ExpiredTokenRetryPolicy({
    required RefreshAccessTokenUsecase refreshAccessTokenUsecase,
    required GetAccessTokenUsecase getAccessTokenUsecase,
    required AuthenticateRegisteredKeyUsecase authenticateRegisteredKeyUsecase,
  })  : _refreshAccessTokenUsecase = refreshAccessTokenUsecase,
        _getAccessTokenUsecase = getAccessTokenUsecase,
        _authenticateRegisteredKeyUsecase = authenticateRegisteredKeyUsecase;

  //Number of retry
  @override
  int get maxRetryAttempts {
    return 1;
  }

  @override
  Future<bool> shouldAttemptRetryOnResponse(BaseResponse response) async {
    if (response.statusCode == 401) {
      bool? isMultiple =
          (await _getAccessTokenUsecase.call(tokenType: TokenType.key)) != null;
      if (isMultiple) {
        await _authenticateRegisteredKeyUsecase.call();
      } else {
        await _refreshAccessTokenUsecase.call();
      }

      return true;
    }

    return false;
  }
}
