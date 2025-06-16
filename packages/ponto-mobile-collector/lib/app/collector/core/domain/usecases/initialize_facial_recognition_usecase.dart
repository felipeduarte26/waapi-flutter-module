import '../../../../../ponto_mobile_collector.dart';
import '../../external/mappers/configuration_mapper.dart';
import '../entities/configuration.dart';
import '../input_model/configuration_dto.dart';
import '../input_model/employee_dto.dart';
import '../services/face_recognition/i_face_recognition_sdk_authentication_service.dart';
import 'get_access_token_usecase.dart';
import 'get_execution_mode_usecase.dart';
import 'get_session_employee_usecase.dart';

abstract class InitializeFacialRecognitionUsecase {
  Future<void> call();
}

class InitializeFacialRecognitionUsecaseImpl
    implements InitializeFacialRecognitionUsecase {
  final GetSessionEmployeeUsecase _getSessionEmployeeUsecase;
  final IConfigurationRepository _configurationRepository;
  final IFaceRecognitionSdkAuthenticationService
      _faceRecognitionSdkAuthenticationService;
  final GetExecutionModeUsecase _getExecutionModeUsecase;
  final GetAccessTokenUsecase _getAccessTokenUsecase;

  const InitializeFacialRecognitionUsecaseImpl({
    required IFaceRecognitionSdkAuthenticationService
        faceRecognitionSdkAuthenticationService,
    required GetSessionEmployeeUsecase getSessionEmployeeUsecase,
    required IConfigurationRepository configurationRepository,
    required GetExecutionModeUsecase getExecutionModeUsecase,
    required GetAccessTokenUsecase getAccessTokenUsecase,
  })  : _faceRecognitionSdkAuthenticationService =
            faceRecognitionSdkAuthenticationService,
        _getSessionEmployeeUsecase = getSessionEmployeeUsecase,
        _configurationRepository = configurationRepository,
        _getExecutionModeUsecase = getExecutionModeUsecase,
        _getAccessTokenUsecase = getAccessTokenUsecase;

  @override
  Future<void> call() async {
    if ((await _getExecutionModeUsecase.call()).isIndividualOrDriver()) {
      EmployeeDto? employee = _getSessionEmployeeUsecase.call();

      if (employee != null) {
        
        Configuration? configurationEntity = await _configurationRepository.findByEmployeeId(
          employeeId: employee.id,
        );
        ConfigurationDto? employeeConfiguration = ConfigurationMapper
            .fromEntityToDtoCollector(configurationEntity);

        if (employeeConfiguration != null &&
            employeeConfiguration.faceRecognition != null &&
            employeeConfiguration.faceRecognition!) {
          await _faceRecognitionSdkAuthenticationService.initialize();
        }
      }
    } else {
      String? accessKeyToken =
          await _getAccessTokenUsecase.call(tokenType: TokenType.key);
      if (accessKeyToken != null && accessKeyToken.isNotEmpty) {
        await _faceRecognitionSdkAuthenticationService.initialize();
      }
    }
  }
}
