import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/domain/entities/status_face_employee.dart';
import '../../../../../core/domain/entities/user_permission_check_entity.dart';
import '../../../../../core/domain/entities/user_permissions_entity.dart';
import '../../../../../core/domain/services/face_recognition/i_face_recognition_sdk_authentication_service.dart';
import '../../../../../core/domain/usecases/check_conection_usecase.dart';
import '../../../../../core/domain/usecases/check_user_permission_usecase.dart';
import '../../../../../core/domain/usecases/get_execution_mode_usecase.dart';
import '../../../../../core/domain/usecases/register_face_employee_usecase.dart';
import '../../../../../core/domain/usecases/sync_employee_by_id_usecase.dart';
import '../../../../../core/domain/usecases/sync_face_employee_usecase.dart';
import '../../../../../core/domain/usecases/sync_multiple_face_employees_usecase.dart';
import '../../../../../core/infra/utils/enum/execution_mode_enum.dart';
import '../../../../../core/infra/utils/enum/user_action_enum.dart';
import '../../../../../core/infra/utils/enum/user_resource_enum.dart';
import '../../../../../core/presenter/widgets/collector_camera/request_camera_permissions_modal_widget.dart';
import '../../../domain/enums/face_registration_status_enum.dart';
import '../../../domain/usecases/person_exists_on_facial_recognition_usecase.dart';
import 'face_registrarion_state.dart';

class FaceRegistrationCubit extends Cubit<FaceRegistrationState> {
  String? _employeeSelected;

  final IHasConnectivityUsecase _hasConnectivityUsecase;
  final IPersonExistsOnFacialRecognitionUsecase
      _personExistsOnFacialRecognitionUsecase;
  final IRegisterFaceEmployeeUsecase _registerFaceEmployeeUsecase;
  final ISyncFaceEmployeeUsecase _syncFaceEmployeeUsecase;
  final IFaceRecognitionSdkAuthenticationService
      _faceRecognitionSdkAuthenticationService;
  final CheckUserPermissionUsecase _checkUserPermissionUsecase;
  final int delayToInit;
  final RequestCameraPermissionsModalWidget
      _requestCameraPermissionsModalWidget;
  final ISyncMultipleFaceEmployeesUsecase _syncMultipleFaceEmployeesUsecase;
  final GetExecutionModeUsecase _getExecutionModeUsecase;
  final SyncEmployeeByIdUsecase _syncEmployeeByIdUsecase;

  FaceRegistrationCubit({
    required IHasConnectivityUsecase hasConnectivityUsecase,
    required IPersonExistsOnFacialRecognitionUsecase
        personExistsOnFacialRecognitionUsecase,
    required IRegisterFaceEmployeeUsecase registerFaceEmployeeUsecase,
    required ISyncFaceEmployeeUsecase syncFaceEmployeeUsecase,
    required IFaceRecognitionSdkAuthenticationService
        faceRecognitionSdkAuthenticationService,
    required CheckUserPermissionUsecase checkUserPermissionUsecase,
    required RequestCameraPermissionsModalWidget
        requestCameraPermissionsModalWidget,
    required ISyncMultipleFaceEmployeesUsecase syncMultipleFaceEmployeesUsecase,
    required GetExecutionModeUsecase getExecutionModeUsecase,
    required SyncEmployeeByIdUsecase syncEmployeeByIdUsecase,
    this.delayToInit = 30,
  })  : _hasConnectivityUsecase = hasConnectivityUsecase,
        _personExistsOnFacialRecognitionUsecase =
            personExistsOnFacialRecognitionUsecase,
        _registerFaceEmployeeUsecase = registerFaceEmployeeUsecase,
        _syncFaceEmployeeUsecase = syncFaceEmployeeUsecase,
        _faceRecognitionSdkAuthenticationService =
            faceRecognitionSdkAuthenticationService,
        _checkUserPermissionUsecase = checkUserPermissionUsecase,
        _requestCameraPermissionsModalWidget =
            requestCameraPermissionsModalWidget,
        _syncMultipleFaceEmployeesUsecase = syncMultipleFaceEmployeesUsecase,
        _getExecutionModeUsecase = getExecutionModeUsecase,
        _syncEmployeeByIdUsecase = syncEmployeeByIdUsecase,
        super(FaceRegistrationInitial());

  void setContext(BuildContext context) {
    _requestCameraPermissionsModalWidget.setContext(context);
  }

  Future<void> checkInformation(String? employeeIdSelected) async {
    emit(FaceRegistrationCheckingInformationInProgress());
    _employeeSelected = employeeIdSelected;

    if (!(await _hasConnectivityUsecase.call())) {
      return emit(FaceRegistrationOffline());
    }

    UserPermissionCheckEntity userPermissionCheckEntity =
        UserPermissionCheckEntity(
      action: UserActionEnum.allow.action,
      resource: UserResourceEnum.facialAuth.resource,
    );

    UserPermissionsEntity hasPermission =
        await _checkUserPermissionUsecase.call(
      userPermissionCheckEntity: [userPermissionCheckEntity],
    );

    if (!hasPermission.authorized) {
      return emit(FaceRegistrationNoPermission());
    }

    bool? personExistsOnFacialRecognition =
        await _personExistsOnFacialRecognitionUsecase.call(employeeIdSelected);

    if (personExistsOnFacialRecognition == null) {
      return emit(
        FaceRegistrationFailure(
          FaceRegistrationStatusEnum.externalIdIsAlreadyInUse,
        ),
      );
    } else if (personExistsOnFacialRecognition) {
      _syncFaceEmployeeUsecase.call();
      return emit(PersonExistsOnFacialRecognitionPlatform());
    }

    emit(PersonNotExistsOnFacialRecognitionPlatform());
  }

  Future<void> startFaceCapture() async {
    var cameraPermission =
        await _requestCameraPermissionsModalWidget.checkPermission();
    if (cameraPermission) {
      emit(FaceCaptureInProgress());
    }
  }

  Future<void> registerFace(String imageBase64) async {
    emit(FaceRegistrationInProgress());
    StatusFaceEmployee? gryfoFaceEmployee =
        await _registerFaceEmployeeUsecase.call(imageBase64, _employeeSelected);

    if (gryfoFaceEmployee != null) {
      log(gryfoFaceEmployee.message!);

      if (gryfoFaceEmployee.success!) {
        _syncFace();
        return emit(FaceRegistrationSuccess());
      }

      FaceRegistrationStatusEnum faceRegistrationStatusEnum =
          FaceRegistrationStatusEnum.build(
        statusCode: gryfoFaceEmployee.statusCode!,
      );

      switch (faceRegistrationStatusEnum) {
        case FaceRegistrationStatusEnum.veryBlurryImage:
        case FaceRegistrationStatusEnum.moreThanOneFaceFoundInTheImage:
        case FaceRegistrationStatusEnum.facesNotFoundInTheImage:
        case FaceRegistrationStatusEnum.nonFrontalFace:
        case FaceRegistrationStatusEnum.poorQualityImage:
        case FaceRegistrationStatusEnum.verySmallFaceInTheImage:
        case FaceRegistrationStatusEnum.faceTooCloseToTheEdgeOfTheImage:
        case FaceRegistrationStatusEnum.evidenceOfFraud:
        case FaceRegistrationStatusEnum.idsWithCloseImagesWereFound:
        case FaceRegistrationStatusEnum.glassesDetectedOrTooMuchEyeShadow:
        case FaceRegistrationStatusEnum.lowConfidenceFaceDetection:
          return emit(FaceRegistrationAlert(faceRegistrationStatusEnum));
        case FaceRegistrationStatusEnum.errorReadingTheImage:
        case FaceRegistrationStatusEnum
              .externalIdCannotContainSpecialCharacters:
        case FaceRegistrationStatusEnum.personNotFound:
        case FaceRegistrationStatusEnum.imageNotFound:
        case FaceRegistrationStatusEnum.errorWhenDeletingThePerson:
        case FaceRegistrationStatusEnum.imageTooLarge:
        case FaceRegistrationStatusEnum.externalIdIsAlreadyInUse:
        case FaceRegistrationStatusEnum.unknownError:
          return emit(FaceRegistrationFailure(faceRegistrationStatusEnum));
      }
    } else {
      emit(FaceRegistrationFailure(FaceRegistrationStatusEnum.unknownError));
    }
  }

  void _syncFace() async {
    ExecutionModeEnum executionModeEnum = await _getExecutionModeUsecase.call();
    if (executionModeEnum.isMultiple()) {
      await _syncEmployeeByIdUsecase.call(employeeId: _employeeSelected);
      _syncMultipleFaceEmployeesUsecase.call(
        delayToInit: Duration(seconds: delayToInit),
      );
    } else {
      _faceRecognitionSdkAuthenticationService.initialize(
        delayToInit: Duration(seconds: delayToInit),
        forceFaceSync: true,
      );
    }
  }

  void restartRegistrationProcess() {
    emit(PersonNotExistsOnFacialRecognitionPlatform());
  }
}
