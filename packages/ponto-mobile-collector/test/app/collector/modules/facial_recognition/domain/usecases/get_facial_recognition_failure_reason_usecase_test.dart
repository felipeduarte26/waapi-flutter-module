import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/facial_recognition_status_enum.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/repositories/database/iconfiguration_repository.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/repositories/face_recognition_check_face_repository.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/face_recognition/i_face_recognition_sdk_authentication_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/permission/ipermission_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/shared_preferences/ishared_preferences_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/check_user_permission_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/repositories/database/employee_repository.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/device_permission_enum.dart';
import 'package:ponto_mobile_collector/app/collector/modules/facial_recognition/domain/usecases/get_facial_recognition_failure_reason_usecase.dart';

import '../../../../../../mocks/configuration_entity_mock.dart';
import '../../../../../../mocks/employee_entity_mock.dart';

class MockSharedPreferencesService extends Mock
    implements ISharedPreferencesService {}

class MockFaceRecognitionSdkAuthenticationService extends Mock
    implements IFaceRecognitionSdkAuthenticationService {}

class MockPermissionService extends Mock implements IPermissionService {}

class MockCheckUserPermissionUsecase extends Mock
    implements CheckUserPermissionUsecase {}

class MockEmployeeRepository extends Mock implements EmployeeRepository {}

class MockFaceRecognitionCheckFaceRepository extends Mock
    implements FaceRecognitionCheckFaceRepository {}

class MockConfigurationRepository extends Mock
    implements IConfigurationRepository {}

void main() {
  late GetFacialRecognitionFailureReasonUsecase usecase;
  late MockSharedPreferencesService mockSharedPreferencesService;
  late MockFaceRecognitionSdkAuthenticationService
      mockFaceRecognitionSdkAuthenticationService;
  late MockPermissionService mockPermissionService;
  late MockCheckUserPermissionUsecase mockCheckUserPermissionUsecase;
  late MockEmployeeRepository mockEmployeeRepository;
  late MockFaceRecognitionCheckFaceRepository
      mockFaceRecognitionCheckFaceRepository;
  late MockConfigurationRepository mockConfigurationRepository;

  setUp(() {
    mockSharedPreferencesService = MockSharedPreferencesService();
    mockFaceRecognitionSdkAuthenticationService =
        MockFaceRecognitionSdkAuthenticationService();
    mockPermissionService = MockPermissionService();
    mockCheckUserPermissionUsecase = MockCheckUserPermissionUsecase();
    mockEmployeeRepository = MockEmployeeRepository();
    mockFaceRecognitionCheckFaceRepository =
        MockFaceRecognitionCheckFaceRepository();
    mockConfigurationRepository = MockConfigurationRepository();

    usecase = GetFacialRecognitionFailureReasonUsecaseImpl(
      sharedPreferencesService: mockSharedPreferencesService,
      faceRecognitionSdkAuthenticationService:
          mockFaceRecognitionSdkAuthenticationService,
      permissionService: mockPermissionService,
      checkUserPermissionUsecase: mockCheckUserPermissionUsecase,
      employeeRepository: mockEmployeeRepository,
      faceRecognitionCheckFaceRepository:
          mockFaceRecognitionCheckFaceRepository,
      configurationRepository: mockConfigurationRepository,
    );

    when(() => mockSharedPreferencesService.getSessionEmployeeId())
        .thenAnswer((_) async => 'employeeId');
    when(
      () => mockFaceRecognitionSdkAuthenticationService
          .getInitializationIsRunning(),
    ).thenReturn(false);
    when(
      () => mockPermissionService.checkPermissionIsAuthorized(
        permission: DevicePermissionEnum.camera,
      ),
    ).thenAnswer((_) async => true);
    when(() => mockEmployeeRepository.findById(id: 'employeeId')).thenAnswer(
      (_) async => employeeEntityMock,
    );
    when(
      () => mockFaceRecognitionCheckFaceRepository.call(
        employeeId: 'employeeId',
      ),
    ).thenAnswer((_) async => true);
  });

  test('should return internalException if employeeId is null', () async {
    when(() => mockSharedPreferencesService.getSessionEmployeeId())
        .thenAnswer((_) async => null);

    final result = await usecase.call();
    expect(result, FacialRecognitionStatusEnum.internalException);
  });

  test('should return null if faceRecognition is false or null', () async {
    when(
      () => mockConfigurationRepository.findByEmployeeId(
        employeeId: 'employeeId',
      ),
    ).thenAnswer((_) async => configurationEntityFaceRecognitionNullMock);

    final result = await usecase.call();
    expect(result, null);
  });

  test('should return noCameraPermission if camera access is not granted',
      () async {
    when(
      () => mockConfigurationRepository.findByEmployeeId(
        employeeId: 'employeeId',
      ),
    ).thenAnswer((_) async => configurationEntityMock);

    when(
      () => mockPermissionService.checkPermissionIsAuthorized(
        permission: DevicePermissionEnum.camera,
      ),
    ).thenAnswer((_) async => false);

    final result = await usecase.call();
    expect(result, FacialRecognitionStatusEnum.noCameraPermission);
  });

  test('should return internalException if employee is null', () async {
    when(
      () => mockConfigurationRepository.findByEmployeeId(
        employeeId: 'employeeId',
      ),
    ).thenAnswer((_) async => configurationEntityMock);

    when(() => mockEmployeeRepository.findById(id: 'employeeId'))
        .thenAnswer((_) async => null);

    final result = await usecase.call();
    expect(result, FacialRecognitionStatusEnum.internalException);
  });

  test('should return notSynced if face recognition check fails', () async {
    when(
      () => mockConfigurationRepository.findByEmployeeId(
        employeeId: 'employeeId',
      ),
    ).thenAnswer((_) async => configurationEntityMock);

    when(
      () => mockFaceRecognitionCheckFaceRepository.call(
        employeeId: 'employeeId',
      ),
    ).thenAnswer((_) async => false);

    final result = await usecase.call();
    expect(result, FacialRecognitionStatusEnum.notSynced);
  });

  test('should return noFaceRegistered if faceRegistered does not match',
      () async {
    when(
      () => mockConfigurationRepository.findByEmployeeId(
        employeeId: 'employeeId',
      ),
    ).thenAnswer((_) async => configurationEntityMock);

    when(() => mockEmployeeRepository.findById(id: 'employeeId')).thenAnswer(
      (_) async => employeeEntityMockNoFaceRegistered,
    );

    final result = await usecase.call();
    expect(result, FacialRecognitionStatusEnum.noFaceRegistered);
  });

  test('should return initializationRunning if initialization is running',
      () async {
    when(
      () => mockConfigurationRepository.findByEmployeeId(
        employeeId: 'employeeId',
      ),
    ).thenAnswer((_) async => configurationEntityMock);

    when(
      () => mockFaceRecognitionSdkAuthenticationService
          .getInitializationIsRunning(),
    ).thenReturn(true);

    final result = await usecase.call();
    expect(result, FacialRecognitionStatusEnum.initializationRunning);
  });

  test('should return internalException if none of the conditions are met',
      () async {
    when(
      () => mockConfigurationRepository.findByEmployeeId(
        employeeId: 'employeeId',
      ),
    ).thenAnswer((_) async => configurationEntityMock);
    final result = await usecase.call();
    expect(result, FacialRecognitionStatusEnum.internalException);
  });
}
