import '../../../../../ponto_mobile_collector.dart';
import '../../infra/utils/enum/execution_mode_enum.dart';
import '../../infra/utils/enum/feature_toggle_enum.dart';
import '../repositories/check_feature_toggle_repository.dart';
import 'check_conection_usecase.dart';
import 'get_access_token_usecase.dart';
import 'get_execution_mode_usecase.dart';

abstract class CheckFeatureToggleUsecase {
  Future<bool> call({
    required FeatureToggleEnum featureToggle,
    bool onlyOnline,
  });
}

class CheckFeatureToggleUsecaseImpl implements CheckFeatureToggleUsecase {
  final CheckFeatureToggleRepository _checkFeatureToggleRepository;
  final GetAccessTokenUsecase _getAccessTokenUsecase;
  final ISharedPreferencesService _sharedPreferencesService;
  final IHasConnectivityUsecase _hasConnectivityUsecase;
  final GetExecutionModeUsecase _getExecutionModeUsecase;

  const CheckFeatureToggleUsecaseImpl({
    required CheckFeatureToggleRepository checkFeatureToggleRepository,
    required GetAccessTokenUsecase getAccessTokenUsecase,
    required ISharedPreferencesService sharedPreferencesService,
    required IHasConnectivityUsecase hasConnectivityUsecase,
    required GetExecutionModeUsecase getExecutionModeUsecase,
  })  : _checkFeatureToggleRepository = checkFeatureToggleRepository,
        _getAccessTokenUsecase = getAccessTokenUsecase,
        _sharedPreferencesService = sharedPreferencesService,
        _hasConnectivityUsecase = hasConnectivityUsecase,
        _getExecutionModeUsecase = getExecutionModeUsecase;

  @override
  Future<bool> call({
    required FeatureToggleEnum featureToggle,
    bool onlyOnline = false,
  }) async {
    String? accessToken;
    ExecutionModeEnum executionModeEnum = await _getExecutionModeUsecase();

    if (executionModeEnum == ExecutionModeEnum.multiple) {
      accessToken = await _getAccessTokenUsecase.call(tokenType: TokenType.key);
    } else {
      accessToken =
          await _getAccessTokenUsecase.call(tokenType: TokenType.user);
    }

    if (accessToken == null) {
      return false;
    }

    bool featureReturn = false;
    bool hasConnectivity = await _hasConnectivityUsecase.call();
    String? employeeIdOrTenant;

    if (executionModeEnum == ExecutionModeEnum.multiple) {
      employeeIdOrTenant = await _sharedPreferencesService.getTenant();
    } else {
      employeeIdOrTenant =
          await _sharedPreferencesService.getSessionEmployeeId();
    }

    if (employeeIdOrTenant == null) {
      return false;
    }

    if (hasConnectivity) {
      featureReturn = await _checkFeatureToggleRepository.call(
        featureToggle: featureToggle,
        tokenType:
            executionModeEnum.isMultiple() ? TokenType.key : TokenType.user,
      );
    } else {
      if (onlyOnline) {
        return false;
      }

      featureReturn = await _sharedPreferencesService.getFeatureToggle(
        employeeIdOrTenant: employeeIdOrTenant,
        executionModeEnum: executionModeEnum,
        featureToggle: featureToggle,
      );
    }

    await _sharedPreferencesService.setFeatureToggle(
      employeeIdOrTenant: employeeIdOrTenant,
      executionModeEnum: executionModeEnum,
      featureToggle: featureToggle,
      value: featureReturn,
    );

    return featureReturn;
  }
}
