import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/user_permission_check_entity.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/user_permissions_entity.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/synchronization_result.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/face_recognition/i_face_recognition_sdk_authentication_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/check_conection_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/check_user_permission_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/get_execution_mode_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/register_face_employee_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/sync_employee_by_id_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/sync_face_employee_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/sync_multiple_face_employees_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/execution_mode_enum.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/synchronization_enum.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/user_action_enum.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/user_resource_enum.dart';
import 'package:ponto_mobile_collector/app/collector/core/presenter/widgets/collector_camera/request_camera_permissions_modal_widget.dart';
import 'package:ponto_mobile_collector/app/collector/modules/facial_recognition/domain/usecases/person_exists_on_facial_recognition_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/modules/facial_recognition/presenter/cubit/face_registration/face_registration_cubit.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';

import '../../../../../../mocks/status_face_employee_mock.dart';
import '../../../../../../mocks/status_face_employee_mock_face_isnt_visible.dart';
import '../../../../../../mocks/status_face_employee_mock_low_quality_photo.dart';
import '../../../../../../mocks/status_face_employee_mock_person_already_exists.dart';

class MockHasConnectivityUsecase extends Mock
    implements IHasConnectivityUsecase {}

class MockPersonExistsOnFacialRecognitionUsecase extends Mock
    implements IPersonExistsOnFacialRecognitionUsecase {}

class MockRegisterFaceEmployeeUsecase extends Mock
    implements IRegisterFaceEmployeeUsecase {}

class MockSyncFaceEmployeeUsecase extends Mock
    implements ISyncFaceEmployeeUsecase {}

class MockFaceRecognitionSdkAuthenticationService extends Mock
    implements IFaceRecognitionSdkAuthenticationService {}

class MockCheckUserPermissionUsecase extends Mock
    implements CheckUserPermissionUsecase {}

class MockRequestCameraPermissionsModalWidget extends Mock
    implements RequestCameraPermissionsModalWidget {}

class MockGetExecutionModeUsecase extends Mock
    implements GetExecutionModeUsecase {}

class MockSyncMultipleFaceEmployeesUsecase extends Mock
    implements ISyncMultipleFaceEmployeesUsecase {}

class MockSyncEmployeeByIdUsecase extends Mock
    implements SyncEmployeeByIdUsecase {}

void main() {
  String? employeeIdSelected;

  UserPermissionCheckEntity tUserPermissionCheckEntity =
      UserPermissionCheckEntity(
    action: UserActionEnum.allow.action,
    resource: UserResourceEnum.facialAuth.resource,
  );

  UserPermissionsEntity tUserPermissionsEntity = const UserPermissionsEntity(
    authorized: true,
    permissions: [],
  );

  UserPermissionsEntity tUserPermissionsEntityFalse =
      const UserPermissionsEntity(
    authorized: false,
    permissions: [],
  );

  late FaceRegistrationCubit faceRegistrationCubit;
  late IHasConnectivityUsecase hasConnectivityUsecase;
  late IPersonExistsOnFacialRecognitionUsecase
      personExistsOnFacialRecognitionUsecase;
  late IRegisterFaceEmployeeUsecase registerFaceEmployeeUsecase;
  late ISyncFaceEmployeeUsecase syncFaceEmployeeUsecase;
  late IFaceRecognitionSdkAuthenticationService
      faceRecognitionSdkAuthenticationService;
  late CheckUserPermissionUsecase checkUserPermissionUsecase;
  late RequestCameraPermissionsModalWidget requestCameraPermissionsModalWidget;
  late GetExecutionModeUsecase getExecutionModeUsecase;
  late ISyncMultipleFaceEmployeesUsecase syncMultipleFaceEmployeesUsecase;
  late SyncEmployeeByIdUsecase syncEmployeeByIdUsecase;

  setUp(() {
    hasConnectivityUsecase = MockHasConnectivityUsecase();
    personExistsOnFacialRecognitionUsecase =
        MockPersonExistsOnFacialRecognitionUsecase();
    registerFaceEmployeeUsecase = MockRegisterFaceEmployeeUsecase();
    syncFaceEmployeeUsecase = MockSyncFaceEmployeeUsecase();
    faceRecognitionSdkAuthenticationService =
        MockFaceRecognitionSdkAuthenticationService();
    checkUserPermissionUsecase = MockCheckUserPermissionUsecase();
    requestCameraPermissionsModalWidget =
        MockRequestCameraPermissionsModalWidget();
    getExecutionModeUsecase = MockGetExecutionModeUsecase();
    syncMultipleFaceEmployeesUsecase = MockSyncMultipleFaceEmployeesUsecase();
    syncEmployeeByIdUsecase = MockSyncEmployeeByIdUsecase();

    registerFallbackValue(Duration.zero);

    faceRegistrationCubit = FaceRegistrationCubit(
      hasConnectivityUsecase: hasConnectivityUsecase,
      personExistsOnFacialRecognitionUsecase:
          personExistsOnFacialRecognitionUsecase,
      registerFaceEmployeeUsecase: registerFaceEmployeeUsecase,
      syncFaceEmployeeUsecase: syncFaceEmployeeUsecase,
      faceRecognitionSdkAuthenticationService:
          faceRecognitionSdkAuthenticationService,
      checkUserPermissionUsecase: checkUserPermissionUsecase,
      delayToInit: 0,
      requestCameraPermissionsModalWidget: requestCameraPermissionsModalWidget,
      getExecutionModeUsecase: getExecutionModeUsecase,
      syncMultipleFaceEmployeesUsecase: syncMultipleFaceEmployeesUsecase,
      syncEmployeeByIdUsecase: syncEmployeeByIdUsecase,
    );

    when(
      () => getExecutionModeUsecase.call(),
    ).thenAnswer((_) async => ExecutionModeEnum.individual);

    when(
      () => syncMultipleFaceEmployeesUsecase.call(
        delayToInit: any(named: 'delayToInit'),
      ),
    ).thenAnswer(
      (_) async => true,
    );

    when(
      () => checkUserPermissionUsecase.call(
        userPermissionCheckEntity: [tUserPermissionCheckEntity],
      ),
    ).thenAnswer((_) async => tUserPermissionsEntity);

    when(() => hasConnectivityUsecase.call()).thenAnswer((_) async => true);

    when(() => personExistsOnFacialRecognitionUsecase.call(employeeIdSelected))
        .thenAnswer((_) async => true);
    when(() => requestCameraPermissionsModalWidget.checkPermission())
        .thenAnswer((_) async => true);
  });

  group('FaceRegistrationCubit', () {
    blocTest(
      'emits [FaceRegistrationCheckingInformationInProgress], [FaceRegistrationOffline]'
      ' when checkInformation is call and no connection test',
      setUp: () {
        when(() => hasConnectivityUsecase.call())
            .thenAnswer((_) async => false);
      },
      build: () => faceRegistrationCubit,
      act: (cubit) async => await cubit.checkInformation(employeeIdSelected),
      expect: () => [
        isA<FaceRegistrationCheckingInformationInProgress>(),
        isA<FaceRegistrationOffline>(),
      ],
    );

    blocTest(
      'emits [FaceRegistrationCheckingInformationInProgress], [FaceRegistrationNoPermission]'
      ' when checkInformation is call and no permission test',
      setUp: () {
        when(
          () => checkUserPermissionUsecase.call(
            userPermissionCheckEntity: [tUserPermissionCheckEntity],
          ),
        ).thenAnswer((_) async => tUserPermissionsEntityFalse);
      },
      build: () => faceRegistrationCubit,
      act: (cubit) async => await cubit.checkInformation(employeeIdSelected),
      expect: () => [
        isA<FaceRegistrationCheckingInformationInProgress>(),
        isA<FaceRegistrationNoPermission>(),
      ],
    );

    blocTest(
      'emits [FaceRegistrationCheckingInformationInProgress], [FaceRegistrationFailure]'
      ' when checkInformation is call test',
      setUp: () {
        when(
          () => personExistsOnFacialRecognitionUsecase.call(employeeIdSelected),
        ).thenAnswer((_) async => null);
      },
      build: () => faceRegistrationCubit,
      act: (cubit) async => await cubit.checkInformation(employeeIdSelected),
      expect: () => [
        isA<FaceRegistrationCheckingInformationInProgress>(),
        isA<FaceRegistrationFailure>(),
      ],
    );

    blocTest(
      'emits [FaceRegistrationCheckingInformationInProgress] and [PersonExistsOnFacialRecognitionPlatform]'
      ' when checkInformation is call test',
      setUp: () {
        when(() => syncFaceEmployeeUsecase.call()).thenAnswer(
          (_) async => SynchronizationResult(
            SynchronizationStatus.success,
            SynchronizationMessage.syncClockingEventSyncSuccess,
          ),
        );
      },
      build: () => faceRegistrationCubit,
      act: (cubit) async => await cubit.checkInformation(employeeIdSelected),
      expect: () => [
        isA<FaceRegistrationCheckingInformationInProgress>(),
        isA<PersonExistsOnFacialRecognitionPlatform>(),
      ],
    );

    blocTest(
      'emits [FaceRegistrationCheckingInformationInProgress], [PersonNotExistsOnFacialRecognitionPlatform]'
      ' when checkIfPersonExistsOnFacialRecognitionPlatform is call test and person not exists',
      setUp: () {
        when(
          () => personExistsOnFacialRecognitionUsecase.call(employeeIdSelected),
        ).thenAnswer((_) async => false);
      },
      build: () => faceRegistrationCubit,
      act: (cubit) async => await cubit.checkInformation(employeeIdSelected),
      expect: () => [
        isA<FaceRegistrationCheckingInformationInProgress>(),
        isA<PersonNotExistsOnFacialRecognitionPlatform>(),
      ],
    );

    blocTest(
      'emits [FaceCaptureInProgress]'
      ' when startFaceCapture is call test',
      build: () => faceRegistrationCubit,
      act: (cubit) async => await cubit.startFaceCapture(),
      expect: () => [
        isA<FaceCaptureInProgress>(),
      ],
    );

    blocTest(
      'emits [FaceRegistrationInProgress], [FaceRegistrationFailure]'
      ' when registerFace is call and register failure test',
      setUp: () {
        when(
          () => registerFaceEmployeeUsecase.call(
            'imageBaase64',
            employeeIdSelected,
          ),
        ).thenAnswer((_) async => null);
      },
      build: () => faceRegistrationCubit,
      act: (cubit) async => await cubit.registerFace('imageBaase64'),
      expect: () => [
        isA<FaceRegistrationInProgress>(),
        isA<FaceRegistrationFailure>(),
      ],
    );

    blocTest(
      'emits [FaceRegistrationInProgress], [FaceRegistrationFailure]'
      ' when registerFace is call and register successfully test',
      setUp: () {
        registerFallbackValue(Duration.zero);

        when(
          () => registerFaceEmployeeUsecase.call(
            'imageBaase64',
            employeeIdSelected,
          ),
        ).thenAnswer((_) async => statusFaceEmployeeMock);

        when(
          () => faceRecognitionSdkAuthenticationService.initialize(
            delayToInit: any(named: 'delayToInit'),
            forceFaceSync: true,
          ),
        ).thenAnswer((_) async => {});
      },
      build: () => faceRegistrationCubit,
      act: (cubit) async => await cubit.registerFace('imageBaase64'),
      expect: () => [
        isA<FaceRegistrationInProgress>(),
        isA<FaceRegistrationSuccess>(),
      ],
    );

    blocTest(
      'emits [FaceRegistrationInProgress], [PersonExistsOnFacialRecognitionPlatform]'
      ' when registerFace is call and register successfully test',
      setUp: () {
        registerFallbackValue(const Duration(seconds: 1));
        when(
          () => faceRecognitionSdkAuthenticationService.initialize(
            delayToInit: any(named: 'delayToInit'),
            forceFaceSync: true,
          ),
        ).thenAnswer((_) async => {});

        when(
          () => registerFaceEmployeeUsecase.call(
            'imageBaase64',
            employeeIdSelected,
          ),
        ).thenAnswer((_) async => statusFaceEmployeeMockPersonAlreadyExists);
      },
      build: () => faceRegistrationCubit,
      act: (cubit) async => await cubit.registerFace('imageBaase64'),
      expect: () => [
        isA<FaceRegistrationInProgress>(),
        isA<FaceRegistrationFailure>(),
      ],
    );
    blocTest(
      'emits [FaceRegistrationInProgress], [FaceRegistrationFaceIsntVisible]'
      ' when registerFace is call and register successfully test',
      setUp: () {
        when(
          () => registerFaceEmployeeUsecase.call(
            'imageBaase64',
            employeeIdSelected,
          ),
        ).thenAnswer((_) async => statusFaceEmployeeMockFaceIsntVisible);
      },
      build: () => faceRegistrationCubit,
      act: (cubit) async => await cubit.registerFace('imageBaase64'),
      expect: () => [
        isA<FaceRegistrationInProgress>(),
        isA<FaceRegistrationAlert>(),
      ],
    );
    blocTest(
      'emits [FaceRegistrationInProgress], [FaceRegistrationLowQualityPhoto]'
      ' when registerFace is call and register successfully test',
      setUp: () {
        when(
          () => registerFaceEmployeeUsecase.call(
            'imageBaase64',
            employeeIdSelected,
          ),
        ).thenAnswer((_) async => statusFaceEmployeeMockLowQualityPhoto);
      },
      build: () => faceRegistrationCubit,
      act: (cubit) async => await cubit.registerFace('imageBaase64'),
      expect: () => [
        isA<FaceRegistrationInProgress>(),
        isA<FaceRegistrationAlert>(),
      ],
    );

    blocTest(
      'call restartRegistrationProcess test',
      build: () => faceRegistrationCubit,
      act: (cubit) async => cubit.restartRegistrationProcess(),
      expect: () => [
        isA<PersonNotExistsOnFacialRecognitionPlatform>(),
      ],
    );
  });
}
