import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';

import '../../../../../ponto_mobile_collector.dart';
import '../../infra/utils/enum/execution_mode_enum.dart';

abstract class GetExecutionModeUsecase {
  Future<ExecutionModeEnum> call();
}

class GetExecutionModeUsecaseImpl implements GetExecutionModeUsecase {
  final ISessionService _sessionService;
  final GetTokenUsecase _getTokenUsecase;

  const GetExecutionModeUsecaseImpl({
    required ISessionService sessionService,
    required GetTokenUsecase getTokenUsecase,
  })  : _sessionService = sessionService,
        _getTokenUsecase = getTokenUsecase;

  @override
  Future<ExecutionModeEnum> call() async {
    Token? keyAccessToken =
        await _getTokenUsecase.call(tokenType: TokenType.key);
    if (keyAccessToken != null) {
      return ExecutionModeEnum.multiple;
    }

    if (_sessionService.hasEmployee()) {
      return _sessionService.getExecutionMode();
    }

    return ExecutionModeEnum.multiple;
  }
}
