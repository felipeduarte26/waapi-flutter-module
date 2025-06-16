import '../../../../core/domain/entities/configuration.dart';
import '../../../../core/domain/entities/employee.dart';
import '../../../../core/domain/enums/facial_recognition_status_enum.dart';
import '../../../../core/domain/input_model/configuration_dto.dart';
import '../../../../core/domain/input_model/employee_dto.dart';
import '../../../../core/domain/repositories/database/iconfiguration_repository.dart';
import '../../../../core/domain/repositories/face_recognition_check_face_repository.dart';
import '../../../../core/domain/services/face_recognition/i_face_recognition_sdk_authentication_service.dart';
import '../../../../core/domain/services/permission/ipermission_service.dart';

import '../../../../core/domain/services/shared_preferences/ishared_preferences_service.dart';
import '../../../../core/domain/usecases/check_user_permission_usecase.dart';
import '../../../../core/external/mappers/configuration_mapper.dart';
import '../../../../core/external/mappers/employee_mapper.dart';
import '../../../../core/infra/repositories/database/employee_repository.dart';
import '../../../../core/infra/utils/enum/device_permission_enum.dart';

abstract class GetFacialRecognitionFailureReasonUsecase {
  Future<FacialRecognitionStatusEnum?> call();
}

class GetFacialRecognitionFailureReasonUsecaseImpl
    implements GetFacialRecognitionFailureReasonUsecase {
  final ISharedPreferencesService sharedPreferencesService;

  final IFaceRecognitionSdkAuthenticationService
      faceRecognitionSdkAuthenticationService;
  final IPermissionService permissionService;
  final CheckUserPermissionUsecase checkUserPermissionUsecase;
  final EmployeeRepository employeeRepository;
  final FaceRecognitionCheckFaceRepository faceRecognitionCheckFaceRepository;
  final IConfigurationRepository configurationRepository;

  GetFacialRecognitionFailureReasonUsecaseImpl({
    required this.sharedPreferencesService,
    required this.faceRecognitionSdkAuthenticationService,
    required this.permissionService,
    required this.checkUserPermissionUsecase,
    required this.employeeRepository,
    required this.faceRecognitionCheckFaceRepository,
    required this.configurationRepository,
  });

  @override
  Future<FacialRecognitionStatusEnum?> call() async {
    String? employeeId = await sharedPreferencesService.getSessionEmployeeId();

    if (employeeId != null) {
      
      Configuration? configEntity = await configurationRepository.findByEmployeeId(
        employeeId: employeeId,
      );
      ConfigurationDto? loginConfigurationDTO = ConfigurationMapper.fromEntityToDtoCollector(configEntity);

      bool faceRecognition = loginConfigurationDTO?.faceRecognition ?? false;

      if (!faceRecognition) {
        return null;
      }
    } else {
      return FacialRecognitionStatusEnum.internalException;
    }

    Employee? employeeEntity = await employeeRepository.findById(id: employeeId);

    EmployeeDto? employeeDto = EmployeeMapper.fromEntityToDtoCollector(employeeEntity);

    if (employeeDto == null) {
      return FacialRecognitionStatusEnum.internalException;
    }

    bool hasCameraAccess = await permissionService.checkPermissionIsAuthorized(
      permission: DevicePermissionEnum.camera,
    );

    if (!hasCameraAccess) {
      return FacialRecognitionStatusEnum.noCameraPermission;
    }

    if (employeeDto.faceRegistered != employeeDto.id.replaceAll('-', '')) {
      return FacialRecognitionStatusEnum.noFaceRegistered;
    }

    if (faceRecognitionSdkAuthenticationService.getInitializationIsRunning()) {
      return FacialRecognitionStatusEnum.initializationRunning;
    }

    if (hasCameraAccess &&
        !await faceRecognitionCheckFaceRepository.call(
          employeeId: employeeId,
        )) {
      return FacialRecognitionStatusEnum.notSynced;
    }

    return FacialRecognitionStatusEnum.internalException;
  }
}
