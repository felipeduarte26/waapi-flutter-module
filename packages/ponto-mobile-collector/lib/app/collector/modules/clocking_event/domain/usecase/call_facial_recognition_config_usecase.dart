import '../../../../../../ponto_mobile_collector.dart';
import '../../../../core/domain/entities/configuration.dart';
import '../../../../core/domain/input_model/configuration_dto.dart';
import '../../../../core/domain/input_model/employee_dto.dart';
import '../../../../core/domain/repositories/face_recognition_check_face_repository.dart';
import '../../../../core/domain/services/face_recognition/i_face_recognition_sdk_authentication_service.dart';
import '../../../../core/domain/usecases/check_user_permission_usecase.dart';
import '../../../../core/external/mappers/configuration_mapper.dart';
import '../../../../core/external/mappers/employee_mapper.dart';
import '../../../../core/infra/utils/enum/user_action_enum.dart';
import '../../../../core/infra/utils/enum/user_resource_enum.dart';

abstract class ICallFacialRecognitionConfigUsecase {
  Future<bool> call({bool checkSyncedFace, bool checkCameraPermission});
}

class CallFacialRecognitionConfigUsecase
    implements ICallFacialRecognitionConfigUsecase {
  final ISharedPreferencesService sharedPreferencesService;
  final IPlatformService platformService;
  final IFaceRecognitionSdkAuthenticationService
      faceRecognitionSdkAuthenticationService;
  final IConfigurationRepository configurationRepository;
  final IPermissionService permissionService;
  final CheckUserPermissionUsecase checkUserPermissionUsecase;
  final EmployeeRepository employeeRepository;
  final FaceRecognitionCheckFaceRepository faceRecognitionCheckFaceRepository;

  const CallFacialRecognitionConfigUsecase({
    required this.sharedPreferencesService,
    required this.platformService,
    required this.faceRecognitionSdkAuthenticationService,
    required this.configurationRepository,
    required this.permissionService,
    required this.checkUserPermissionUsecase,
    required this.employeeRepository,
    required this.faceRecognitionCheckFaceRepository,
  });

  @override
  Future<bool> call({
    bool checkSyncedFace = true,
    bool checkCameraPermission = true,
  }) async {
    if (checkCameraPermission) {
      bool hasCameraAccess =
          await permissionService.checkPermissionIsAuthorized(
        permission: DevicePermissionEnum.camera,
      );

      if (!hasCameraAccess) {
        return false;
      }
    }

    String? employeeId = await sharedPreferencesService.getSessionEmployeeId();
    var userIdentifier =
        await sharedPreferencesService.getSessionPlatformUsername();

    if (employeeId == null) {
      return false;
    }

    Configuration? configEntity = 
        await configurationRepository.findByEmployeeId(
      employeeId: employeeId,
    );
    ConfigurationDto? loginConfigurationDTO = ConfigurationMapper.fromEntityToDtoCollector(configEntity);

    var employeeEntity = await employeeRepository.findById(id: employeeId);
    EmployeeDto? employeeDto = EmployeeMapper.fromEntityToDtoCollector(employeeEntity);

    if (employeeDto == null) {
      return false;
    }

    if (loginConfigurationDTO == null) {
      return false;
    }

    bool faceRecognition = loginConfigurationDTO.faceRecognition ?? false;

    if (!faceRecognition) {
      return false;
    }

    if (employeeDto.faceRegistered != employeeDto.id.replaceAll('-', '')) {
      return false;
    }

    if (checkCameraPermission &&
        !await faceRecognitionCheckFaceRepository.call(
          employeeId: employeeId,
        )) {
      return false;
    }

    bool facialAuthPermission =
        await sharedPreferencesService.getUserPermission(
      userName: userIdentifier!,
      action: UserActionEnum.allow.action,
      resource: UserResourceEnum.facialAuth.resource,
    );

    return !faceRecognitionSdkAuthenticationService
            .getInitializationIsRunning() &&
        facialAuthPermission;
  }
}
