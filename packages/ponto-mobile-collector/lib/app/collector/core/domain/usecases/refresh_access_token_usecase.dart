import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';

import 'get_access_token_usecase.dart';

abstract class RefreshAccessTokenUsecase {
  Future<void> call();
}

class RefreshAccessTokenUsecaseImpl implements RefreshAccessTokenUsecase {
  final GetAccessTokenUsecase _getTokenUsecase;
  final RefreshStoredTokenUsecase _refreshStoredTokenUsecase;
  final RefreshKeyStoredTokenUsecase _refreshKeyStoredTokenUsecase;

  const RefreshAccessTokenUsecaseImpl({
    required GetAccessTokenUsecase getTokenUsecase,
    required RefreshStoredTokenUsecase refreshStoredTokenUsecase,
    required RefreshKeyStoredTokenUsecase refreshKeyStoredTokenUsecase,
  })  : _getTokenUsecase = getTokenUsecase,
        _refreshStoredTokenUsecase = refreshStoredTokenUsecase,
        _refreshKeyStoredTokenUsecase = refreshKeyStoredTokenUsecase;

  @override
  Future<void> call() async {
    await _refreshStoredTokenUsecase.call(const UserName());
    await _refreshKeyStoredTokenUsecase.call(null);
    ConfigService.instance.setToken(token: await _getTokenUsecase.call());
  }
}
