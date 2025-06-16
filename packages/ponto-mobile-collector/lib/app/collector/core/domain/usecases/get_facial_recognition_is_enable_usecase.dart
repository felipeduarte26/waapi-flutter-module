import '../../../../../ponto_mobile_collector.dart';
import '../../external/mappers/configuration_mapper.dart';
import '../entities/configuration.dart';
import '../input_model/configuration_dto.dart';
import '../input_model/employee_dto.dart';
import 'get_access_token_usecase.dart';
import 'get_execution_mode_usecase.dart';
import 'get_session_employee_usecase.dart';

abstract class GetFacialRecognitionIsEnableUsecase {
  Future<bool> call();
}

class GetFacialRecognitionIsEnableUsecaseImpl
    implements GetFacialRecognitionIsEnableUsecase {
  final GetSessionEmployeeUsecase _getSessionEmployeeUsecase;
  final IConfigurationRepository _configurationRepository;
  final GetExecutionModeUsecase _getExecutionModeUsecase;
  final GetAccessTokenUsecase _getAccessTokenUsecase;

  const GetFacialRecognitionIsEnableUsecaseImpl({
    required GetSessionEmployeeUsecase getSessionEmployeeUsecase,
    required IConfigurationRepository configurationRepository,
    required GetExecutionModeUsecase getExecutionModeUsecase,
    required GetAccessTokenUsecase getAccessTokenUsecase,
  })  : _getSessionEmployeeUsecase = getSessionEmployeeUsecase,
        _configurationRepository = configurationRepository,
        _getExecutionModeUsecase = getExecutionModeUsecase,
        _getAccessTokenUsecase = getAccessTokenUsecase;

  @override
  Future<bool> call() async {
    if ((await _getExecutionModeUsecase.call()).isIndividual()) {
      EmployeeDto? employee = _getSessionEmployeeUsecase.call();

      if (employee != null) {
        Configuration? entityConfiguration =
            await _configurationRepository.findByEmployeeId(
          employeeId: employee.id,
        );
        ConfigurationDto? employeeConfiguration = ConfigurationMapper
            .fromEntityToDtoCollector(entityConfiguration);
            
        return employeeConfiguration != null &&
            employeeConfiguration.faceRecognition != null &&
            employeeConfiguration.faceRecognition!;
      }
    } else {
      String? accessKeyToken =
          await _getAccessTokenUsecase.call(tokenType: TokenType.key);

      return accessKeyToken != null && accessKeyToken.isNotEmpty;
    }

    return false;
  }
}
