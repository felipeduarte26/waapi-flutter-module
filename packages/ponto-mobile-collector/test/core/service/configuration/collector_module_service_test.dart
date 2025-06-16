import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_authentication/mobile_authentication_service.dart'
    as auth;
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/mobile_login_usecase_return.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/privacy_policy_entity.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/network_status.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/hlb_time_dto.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/synchronization_result.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/repositories/request_device_permissions_repository.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/face_recognition/i_face_recognition_sdk_authentication_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/check_feature_toggle_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/get_execution_mode_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/get_global_device_configuration_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/initialize_facial_recognition_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/load_user_permissions_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/mobile_login_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/sync_face_employee_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/execution_mode_enum.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/feature_toggle_enum.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/synchronization_enum.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/domain/usecase/init_clock_usecase.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';

import '../../../mocks/activation_dto_mock.dart';
import '../../../mocks/activation_entity_mock.dart';
import '../../../mocks/configuration_dto_mock.dart';
import '../../../mocks/configuration_entity_mock.dart';
import '../../../mocks/device_info_mock.dart';
import '../../../mocks/employee_dto_mock.dart';
import '../../../mocks/employee_entity_mock.dart';
import '../../../mocks/login_configuration_dto_mock.dart';
import '../../../mocks/login_employee_dto_mock.dart';
import '../../../mocks/token_mock.dart';

class MockPlatformService extends Mock implements IPlatformService {}

class MockMobileLoginUsecase extends Mock implements MobileLoginUsecase {}

class MockInitClockUsecase extends Mock implements InitClockUsecase {}

class MockSharedPreferencesService extends Mock
    implements ISharedPreferencesService {}

class MockActivationRepository extends Mock implements IActivationRepository {}

class MockConfigurationRepository extends Mock
    implements IConfigurationRepository {}

class MockEmployeeRepository extends Mock implements IEmployeeRepository {}

class MockSynchronizeClockingEventService extends Mock
    implements ISynchronizeClockingEventService {}

class MockGetTokenUsecase extends Mock implements GetTokenUsecase {}

class MockFaceRecognitionSdkAuthenticationService extends Mock
    implements IFaceRecognitionSdkAuthenticationService {}

class MockSyncFaceEmployeeUsecase extends Mock
    implements ISyncFaceEmployeeUsecase {}

class MockInitializeFacialRecognitionUsecase extends Mock
    implements InitializeFacialRecognitionUsecase {}

class MockSessionService extends Mock implements ISessionService {}

class MockGetLastVersionPrivacyPolicyUsecase extends Mock
    implements GetLastVersionPrivacyPolicyUsecase {}

class MockLoadUserPermissionsUsecase extends Mock
    implements LoadUserPermissionsUsecase {}

class MockRequestDevicePermissionRepository extends Mock
    implements RequestDevicePermissionRepository {}

class MockGetGlobalDeviceConfigurationUsecase extends Mock
    implements GetGlobalDeviceConfigurationUsecase {}

class MockGetExecutionModeUsecase extends Mock
    implements GetExecutionModeUsecase {}

class MockCheckFeatureToggleUsecase extends Mock
    implements CheckFeatureToggleUsecase {}

void main() {
  late CollectorModuleService service;
  late ISessionService mockSessionService;
  late IPlatformService mockPlatformService;
  late InitClockUsecase mockInitClockUsecase;
  late ISharedPreferencesService mockSharedPreferencesService;
  late IActivationRepository mockActivationRepository;
  late IConfigurationRepository mockConfigurationRepository;
  late IEmployeeRepository mockEmployeeRepository;
  late MockSynchronizeClockingEventService mockSynchronizeClockingEventService;
  late Stream<bool> connectivityStream;
  late GetTokenUsecase getTokenUsecase;
  late IFaceRecognitionSdkAuthenticationService
      mockFaceRecognitionSdkAuthenticationService;
  late InitializeFacialRecognitionUsecase initializeFacialRecognitionUsecase;
  late MobileLoginUsecase mobileLoginUsecase;
  late LoadUserPermissionsUsecase loadUserPermissionsUsecase;
  late RequestDevicePermissionRepository requestDevicePermissionRepository;
  late GetGlobalDeviceConfigurationUsecase getGlobalDeviceConfigurationUsecase;
  late GetExecutionModeUsecase getExecutionModeUsecase;
  late GetLastVersionPrivacyPolicyUsecase getLastVersionPrivacyPolicyUsecase;
  late CheckFeatureToggleUsecase checkFeatureToggleUsecase;

  const tHomePath = '/homePath';
  const tLoginPath = '/loginPath';

  var userIdentifier = 'username@tenant.com.br';

  PrivacyPolicyEntity privacyPolicy = PrivacyPolicyEntity(
    version: 1,
    urlVersion: 'urlVersion',
  );

  setUp(() {
    mockSessionService = MockSessionService();
    mockPlatformService = MockPlatformService();
    mockInitClockUsecase = MockInitClockUsecase();
    mockSharedPreferencesService = MockSharedPreferencesService();
    mockActivationRepository = MockActivationRepository();
    mockConfigurationRepository = MockConfigurationRepository();
    mockEmployeeRepository = MockEmployeeRepository();
    mockSynchronizeClockingEventService = MockSynchronizeClockingEventService();
    connectivityStream = StreamController<bool>().stream;
    getTokenUsecase = MockGetTokenUsecase();
    mockFaceRecognitionSdkAuthenticationService =
        MockFaceRecognitionSdkAuthenticationService();
    initializeFacialRecognitionUsecase =
        MockInitializeFacialRecognitionUsecase();
    mobileLoginUsecase = MockMobileLoginUsecase();
    loadUserPermissionsUsecase = MockLoadUserPermissionsUsecase();
    requestDevicePermissionRepository = MockRequestDevicePermissionRepository();
    getGlobalDeviceConfigurationUsecase =
        MockGetGlobalDeviceConfigurationUsecase();
    getExecutionModeUsecase = MockGetExecutionModeUsecase();
    getLastVersionPrivacyPolicyUsecase =
        MockGetLastVersionPrivacyPolicyUsecase();
    checkFeatureToggleUsecase = MockCheckFeatureToggleUsecase();

    registerFallbackValue(deviceInfoMock);
    registerFallbackValue(auth.Environment.dev);
    registerFallbackValue(TokenType.first);
    registerFallbackValue(const Duration(minutes: -180));
    registerFallbackValue(configurationDTOMock);
    registerFallbackValue(employeeMockDto);
    registerFallbackValue(activationDtoMock);
    registerFallbackValue(EnvironmentEnum.test);
    registerFallbackValue(tokenMock);

    when(
      () => getTokenUsecase.call(tokenType: any(named: 'tokenType')),
    ).thenAnswer((_) async => tokenMock);

    when(
      () => getLastVersionPrivacyPolicyUsecase.call(),
    ).thenAnswer((_) async => privacyPolicy);

    when(
      () => mockPlatformService.connectivityStatus(),
    ).thenAnswer((_) async => NetworkStatusEnum.active);

    when(() => mockPlatformService.connectivityStream()).thenAnswer(
      (_) => connectivityStream,
    );

    when(() => mockSynchronizeClockingEventService.startSynchronize())
        .thenAnswer(
      (_) async => SynchronizationResult(
        SynchronizationStatus.success,
        SynchronizationMessage.syncClockingEventSyncSuccess,
      ),
    );

    when(
      () => mockInitClockUsecase.call(),
    ).thenAnswer((_) async => Null);
    when(
      () => mockFaceRecognitionSdkAuthenticationService.initialize(),
    ).thenAnswer((_) async => {});

    when(
      () => mockPlatformService.isAndroid(),
    ).thenReturn(true);

    when(
      () => initializeFacialRecognitionUsecase.call(),
    ).thenAnswer((_) async => {});

    when(
      () => mockSessionService.clean(),
    ).thenAnswer((_) async => {});

    when(
      () => mockSessionService.setLogedUser(
        configurationDto: any(named: 'configurationDto'),
        employeeDto: any(named: 'employeeDto'),
        activationDto: any(named: 'activationDto'),
        username: tokenMock.username,
      ),
    ).thenAnswer((_) async => {});

    when(
      () => mockSessionService.hasEmployee(),
    ).thenReturn(true);

    when(
      () => mockSessionService.getEmployeeId(),
    ).thenReturn(employeeDtoMock.id);

    when(
      () => mockSessionService.getTimeZoneOffset(),
    ).thenReturn(Duration.zero);

    when(
      () => requestDevicePermissionRepository.call(),
    ).thenAnswer((_) async => {});

    when(
      () => getExecutionModeUsecase.call(),
    ).thenAnswer((_) async => ExecutionModeEnum.multiple);

    when(
      () => getGlobalDeviceConfigurationUsecase.call(),
    ).thenAnswer((_) async => null);

    service = CollectorModuleService(
      test: true,
      platformService: mockPlatformService,
      getTokenUsecase: getTokenUsecase,
      initClockUsecase: mockInitClockUsecase,
      mobileLoginUsecase: mobileLoginUsecase,
      activationRepository: mockActivationRepository,
      configurationRepository: mockConfigurationRepository,
      employeeRepository: mockEmployeeRepository,
      iSharedPreferencesService: mockSharedPreferencesService,
      sessionService: mockSessionService,
      synchronizeClockingEventService: mockSynchronizeClockingEventService,
      initializeFacialRecognitionUsecase: initializeFacialRecognitionUsecase,
      requestDevicePermissionRepository: requestDevicePermissionRepository,
      getLastVersionPrivacyPolicyUsecase: getLastVersionPrivacyPolicyUsecase,
      checkFeatureToggleUsecase: checkFeatureToggleUsecase,
    );
  });
  group('CollectorModuleService', () {
    test(
      'initialize with employee success test',
      () async {
        registerFallbackValue(deviceInfoMock);
        registerFallbackValue(auth.Environment.dev);
        registerFallbackValue(const UserName());
        registerFallbackValue(const Duration(minutes: -180));

        when(() => mockPlatformService.getDeviceInfoDto())
            .thenAnswer((_) async => deviceMockInfo);

        when(
          () => mockSessionService.getEmployeeId(),
        ).thenReturn(employeeDtoMock.id);

        when(
          () => checkFeatureToggleUsecase.call(
            featureToggle: FeatureToggleEnum.pilotdriver,
          ),
        ).thenAnswer((_) async => true);

        when(
          () => mockSharedPreferencesService.setFeatureToggle(
            featureToggle: FeatureToggleEnum.pilotdriver,
            employeeIdOrTenant: any(named: 'employeeIdOrTenant'),
            executionModeEnum: ExecutionModeEnum.driver,
            value: true,
          ),
        ).thenAnswer((_) async => Future<void>);

        when(
          () => mockActivationRepository.save(
            activation: activationEntityMock,
            employeeId: loginEmployeeDtoMock.id,
          ),
        ).thenAnswer((_) async => true);
        var mobileLoginUseReturn = MobileLoginUsecaseReturn();
        mobileLoginUseReturn.employeeLocal = employeeMockDto;
        mobileLoginUseReturn.activationLocal = activationDtoMock;
        mobileLoginUseReturn.configurationLocal = configurationDTOMock;
        mobileLoginUseReturn.noUsername = false;
        mobileLoginUseReturn.noInternetConnection = false;

        when(
          () => mobileLoginUsecase.call(
            any(),
            any(),
          ),
        ).thenAnswer(
          (_) async => mobileLoginUseReturn,
        );

        when(
          () => mockConfigurationRepository.save(
            config: configurationEntityMock,
            employeeId: loginEmployeeDtoMock.id,
            username: tokenMock.username,
          ),
        ).thenAnswer((_) async => true);

        when(
          () => mockEmployeeRepository.save(employee: employeeEntityMock),
        ).thenAnswer((_) async => true);

        when(
          () => getTokenUsecase.call(tokenType: any(named: 'tokenType')),
        ).thenAnswer((_) async => tokenMock);

        when(
          () => loadUserPermissionsUsecase.call(userIdentifier),
        ).thenAnswer((_) async => {});

        await service.initialize(
          environment: EnvironmentEnum.dev,
          appIdentifier: AppIdentfierEnum.ponto,
          hideBackButton: true,
          showNotificationButton: true,
          homePath: tHomePath,
          loginPath: tLoginPath,
        );

        expect(service.hasInitialized(), true);
        expect(service.getLoginPath(), tLoginPath);
        expect(service.getAppIdentfierEnum(), AppIdentfierEnum.ponto);

        verify(
          () => mockPlatformService.connectivityStatus(),
        ).called(1);

        verify(
          () => mockPlatformService.connectivityStream(),
        ).called(1);

        verify(
          () => mockSynchronizeClockingEventService.startSynchronize(),
        ).called(1);

        verify(
          () => checkFeatureToggleUsecase.call(
            featureToggle: FeatureToggleEnum.pilotdriver,
          ),
        ).called(1);

        verify(
          () => mockSharedPreferencesService.setFeatureToggle(
            featureToggle: FeatureToggleEnum.pilotdriver,
            employeeIdOrTenant: any(named: 'employeeIdOrTenant'),
            executionModeEnum: ExecutionModeEnum.driver,
            value: true,
          ),
        ).called(1);

        verify(
          () => mobileLoginUsecase.call(
            any(),
            any(),
          ),
        ).called(1);

        verify(() => mockInitClockUsecase.call());

        verify(() => getTokenUsecase.call(tokenType: any(named: 'tokenType')));

        verifyNoMoreInteractions(getExecutionModeUsecase);
        verifyNoMoreInteractions(getGlobalDeviceConfigurationUsecase);
        verifyNoMoreInteractions(mockPlatformService);
        verifyNoMoreInteractions(mobileLoginUsecase);
        verifyNoMoreInteractions(mockInitClockUsecase);
        verifyNoMoreInteractions(mockActivationRepository);
        verifyNoMoreInteractions(mockConfigurationRepository);
        verifyNoMoreInteractions(mockEmployeeRepository);
        verifyNoMoreInteractions(getTokenUsecase);
      },
    );

    test('Successful startup with employee and no connection test', () async {
      when(() => mockPlatformService.connectivityStatus())
          .thenAnswer((_) async => NetworkStatusEnum.inactive);

      when(
        () => mockConfigurationRepository.findByUsername(
          username: tokenMock.username!,
        ),
      ).thenAnswer((_) async => configurationEntityMock);

      when(
        () => mockActivationRepository.findByEmployeeId(
          employeeId: loginConfigurationDTOMock.id!,
        ),
      ).thenAnswer((_) async => activationEntityMock);

      when(
        () => mockEmployeeRepository.findById(
          id: loginConfigurationDTOMock.id!,
        ),
      ).thenAnswer((_) async => employeeEntityMock);

      when(
        () => loadUserPermissionsUsecase.call(userIdentifier),
      ).thenAnswer((_) async {});

      var mobileLoginUseReturn = MobileLoginUsecaseReturn();
      mobileLoginUseReturn.employeeLocal = employeeMockDto;
      mobileLoginUseReturn.activationLocal = activationDtoMock;
      mobileLoginUseReturn.configurationLocal = configurationDTOMock;
      mobileLoginUseReturn.noUsername = false;
      mobileLoginUseReturn.noInternetConnection = true;
      when(
        () => mobileLoginUsecase.call(
          any(),
          any(),
        ),
      ).thenAnswer((_) async => mobileLoginUseReturn);

      when(
        () => mockSessionService.getEmployeeId(),
      ).thenReturn(employeeDtoMock.id);

      when(
        () => checkFeatureToggleUsecase.call(
          featureToggle: FeatureToggleEnum.pilotdriver,
        ),
      ).thenAnswer((_) async => true);

      when(
        () => mockSharedPreferencesService.setFeatureToggle(
          featureToggle: FeatureToggleEnum.pilotdriver,
          employeeIdOrTenant: any(named: 'employeeIdOrTenant'),
          executionModeEnum: ExecutionModeEnum.driver,
          value: true,
        ),
      ).thenAnswer((_) async => Future<void>);

      await service.initialize(
        environment: EnvironmentEnum.dev,
        appIdentifier: AppIdentfierEnum.ponto,
        hideBackButton: true,
        showNotificationButton: true,
        homePath: tHomePath,
        loginPath: tLoginPath,
      );

      expect(service.hasInitialized(), true);

      verify(
        () => mockPlatformService.connectivityStatus(),
      ).called(1);

      verify(
        () => getTokenUsecase.call(tokenType: any(named: 'tokenType')),
      ).called(1);

      verify(
        () => mockConfigurationRepository.findByUsername(
          username: tokenMock.username!,
        ),
      ).called(1);

      verify(
        () => mockActivationRepository.findByEmployeeId(
          employeeId: loginConfigurationDTOMock.id!,
        ),
      ).called(1);

      verify(
        () => mockEmployeeRepository.findById(
          id: loginConfigurationDTOMock.id!,
        ),
      ).called(1);

      verify(
        () => mockPlatformService.connectivityStream(),
      ).called(1);

      verify(
        () => mockSynchronizeClockingEventService.startSynchronize(),
      ).called(1);

      verify(() => mockInitClockUsecase.call());

      verify(
        () => mobileLoginUsecase.call(
          any(),
          any(),
        ),
      ).called(1);

      verify(
        () => checkFeatureToggleUsecase.call(
          featureToggle: FeatureToggleEnum.pilotdriver,
        ),
      ).called(1);

      verify(
        () => mockSharedPreferencesService.setFeatureToggle(
          featureToggle: FeatureToggleEnum.pilotdriver,
          employeeIdOrTenant: any(named: 'employeeIdOrTenant'),
          executionModeEnum: ExecutionModeEnum.driver,
          value: true,
        ),
      ).called(1);

      verifyNoMoreInteractions(getExecutionModeUsecase);
      verifyNoMoreInteractions(mockPlatformService);
      verifyNoMoreInteractions(mobileLoginUsecase);
      verifyNoMoreInteractions(mockInitClockUsecase);
      verifyNoMoreInteractions(mockActivationRepository);
      verifyNoMoreInteractions(mockConfigurationRepository);
      verifyNoMoreInteractions(mockEmployeeRepository);
      verifyNoMoreInteractions(getTokenUsecase);
      verifyZeroInteractions(getGlobalDeviceConfigurationUsecase);
    });

    test('Initialization with error on call connectivityStatus service',
        () async {
      when(() => mockPlatformService.connectivityStatus())
          .thenThrow(PontoMobileCollectorException('connectivityStatusError'));

      final action = service.initialize(
        environment: EnvironmentEnum.dev,
        appIdentifier: AppIdentfierEnum.ponto,
        hideBackButton: true,
        showNotificationButton: true,
        homePath: tHomePath,
        loginPath: tLoginPath,
      );

      expect(
        () async => await action,
        throwsA(isA<PontoMobileCollectorException>()),
      );

      verifyZeroInteractions(mockPlatformService);
      verifyZeroInteractions(mobileLoginUsecase);
      verifyZeroInteractions(mockInitClockUsecase);
      verifyZeroInteractions(mockActivationRepository);
      verifyZeroInteractions(mockConfigurationRepository);
      verifyZeroInteractions(mockEmployeeRepository);
      verifyZeroInteractions(getTokenUsecase);
    });

    test(
      'Finalize with employee success test',
      () async {
        registerFallbackValue(const UserName());

        when(
          () => getTokenUsecase.call(tokenType: any(named: 'tokenType')),
        ).thenAnswer((_) async => tokenMock);

        await service.finalize();

        expect(service.hasInitialized(), false);


        verify(
          () => getTokenUsecase.call(tokenType: any(named: 'tokenType')),
        ).called(1);

        verifyNoMoreInteractions(getTokenUsecase);
        verifyZeroInteractions(mockPlatformService);
        verifyZeroInteractions(mockInitClockUsecase);
        verifyZeroInteractions(mobileLoginUsecase);
        verifyZeroInteractions(mockActivationRepository);
        verifyZeroInteractions(mockConfigurationRepository);
        verifyZeroInteractions(mockEmployeeRepository);
        verifyZeroInteractions(mockSynchronizeClockingEventService);
      },
    );

    test('Finalize without employee success test', () async {
      mockSessionService.setLogedUser(
        configurationDto: configurationDTOMock,
        activationDto: activationDtoMock,
        employeeDto: employeeMockDto,
        username: tokenMock.username,
      );

      registerFallbackValue(const UserName());

      when(
        () => getTokenUsecase.call(tokenType: any(named: 'tokenType')),
      ).thenAnswer((_) async => tokenMock);

      await service.finalize();

      expect(service.hasInitialized(), false);


      verify(
        () => getTokenUsecase.call(tokenType: any(named: 'tokenType')),
      ).called(1);

      verifyNoMoreInteractions(getTokenUsecase);
      verifyZeroInteractions(mockPlatformService);
      verifyZeroInteractions(mockInitClockUsecase);
      verifyZeroInteractions(mobileLoginUsecase);
      verifyZeroInteractions(mockActivationRepository);
      verifyZeroInteractions(mockConfigurationRepository);
      verifyZeroInteractions(mockEmployeeRepository);
      verifyZeroInteractions(mockSynchronizeClockingEventService);
    });

    test(
      'loadEnvFile test',
      () async {
        CollectorModuleService service = CollectorModuleService(
          test: true,
          platformService: mockPlatformService,
          getTokenUsecase: getTokenUsecase,
          initClockUsecase: mockInitClockUsecase,
          mobileLoginUsecase: mobileLoginUsecase,
          activationRepository: mockActivationRepository,
          configurationRepository: mockConfigurationRepository,
          employeeRepository: mockEmployeeRepository,
          iSharedPreferencesService: mockSharedPreferencesService,
          sessionService: mockSessionService,
          synchronizeClockingEventService: mockSynchronizeClockingEventService,
          initializeFacialRecognitionUsecase:
              initializeFacialRecognitionUsecase,
          requestDevicePermissionRepository: requestDevicePermissionRepository,
          getLastVersionPrivacyPolicyUsecase:
              getLastVersionPrivacyPolicyUsecase,
          checkFeatureToggleUsecase: checkFeatureToggleUsecase,
        );

        expect(
          await service.loadEnvFile(
            environment: EnvironmentEnum.test,
            test: true,
          ),
          true,
        );

        expect(
          await service.loadEnvFile(
            environment: EnvironmentEnum.dev,
            test: true,
          ),
          true,
        );

        expect(
          await service.loadEnvFile(
            environment: EnvironmentEnum.homolog,
            test: true,
          ),
          true,
        );

        expect(
          await service.loadEnvFile(
            environment: EnvironmentEnum.prod,
            test: true,
          ),
          true,
        );

        verifyZeroInteractions(getTokenUsecase);
        verifyZeroInteractions(mockPlatformService);
        verifyZeroInteractions(mockInitClockUsecase);
        verifyZeroInteractions(mobileLoginUsecase);
        verifyZeroInteractions(mockActivationRepository);
        verifyZeroInteractions(mockConfigurationRepository);
        verifyZeroInteractions(mockEmployeeRepository);
        verifyZeroInteractions(mockSynchronizeClockingEventService);
      },
    );

    test('Successful startup with employee and hlbTimeDto test', () async {
      when(
        () => mockPlatformService.connectivityStatus(),
      ).thenAnswer((_) async => NetworkStatusEnum.active);

      when(() => mockPlatformService.connectivityStream()).thenAnswer(
        (_) => connectivityStream,
      );

      when(() => mockSynchronizeClockingEventService.startSynchronize())
          .thenAnswer(
        (_) async => SynchronizationResult(
          SynchronizationStatus.success,
          SynchronizationMessage.syncClockingEventSyncSuccess,
        ),
      );

      when(
        () => mockSessionService.setLogedUser(
          configurationDto: any(named: 'configurationDto'),
          employeeDto: any(named: 'employeeDto'),
          activationDto: any(named: 'activationDto'),
          username: tokenMock.username,
        ),
      ).thenAnswer((_) async => {});

      when(
        () => mockSessionService.hasEmployee(),
      ).thenReturn(true);

      when(
        () => mockSessionService.getEmployeeId(),
      ).thenReturn(employeeDtoMock.id);

      when(
        () => mockSessionService.getTimeZoneOffset(),
      ).thenReturn(Duration.zero);

      when(
        () => mockSessionService.getEmployeeId(),
      ).thenReturn(employeeDtoMock.id);

      when(
        () => checkFeatureToggleUsecase.call(
          featureToggle: FeatureToggleEnum.pilotdriver,
        ),
      ).thenAnswer((_) async => true);

      when(
        () => mockSharedPreferencesService.setFeatureToggle(
          featureToggle: FeatureToggleEnum.pilotdriver,
          employeeIdOrTenant: any(named: 'employeeIdOrTenant'),
          executionModeEnum: ExecutionModeEnum.driver,
          value: true,
        ),
      ).thenAnswer((_) async => Future<void>);

      when(
        () => loadUserPermissionsUsecase.call(userIdentifier),
      ).thenAnswer((_) async => {});

      var mobileLoginUseReturn = MobileLoginUsecaseReturn();
      mobileLoginUseReturn.employeeLocal = employeeMockDto;
      mobileLoginUseReturn.activationLocal = activationDtoMock;
      mobileLoginUseReturn.configurationLocal = configurationDTOMock;
      mobileLoginUseReturn.noUsername = false;
      mobileLoginUseReturn.noInternetConnection = false;
      mobileLoginUseReturn.hlbTimeLocal = HlbTimeDto(
        hlbTime: null,
        defaultTimezone: 'America/Sao_Paulo',
      );
      when(
        () => mobileLoginUsecase.call(
          any(),
          any(),
        ),
      ).thenAnswer((_) async => mobileLoginUseReturn);

      await service.initialize(
        environment: EnvironmentEnum.dev,
        appIdentifier: AppIdentfierEnum.ponto,
        hideBackButton: true,
        showNotificationButton: true,
        homePath: tHomePath,
        loginPath: tLoginPath,
      );

      expect(service.hasInitialized(), true);

      verify(
        () => mockPlatformService.connectivityStatus(),
      ).called(1);

      verify(
        () => getTokenUsecase.call(tokenType: any(named: 'tokenType')),
      ).called(1);

      verify(
        () => mockPlatformService.connectivityStream(),
      ).called(1);

      verify(
        () => mockSynchronizeClockingEventService.startSynchronize(),
      ).called(1);

      verify(
        () => mobileLoginUsecase.call(
          any(),
          any(),
        ),
      ).called(1);

      verify(
        () => checkFeatureToggleUsecase.call(
          featureToggle: FeatureToggleEnum.pilotdriver,
        ),
      ).called(1);

      verify(
        () => mockSharedPreferencesService.setFeatureToggle(
          featureToggle: FeatureToggleEnum.pilotdriver,
          employeeIdOrTenant: any(named: 'employeeIdOrTenant'),
          executionModeEnum: ExecutionModeEnum.driver,
          value: true,
        ),
      ).called(1);

      verifyNoMoreInteractions(mockPlatformService);
      verifyNoMoreInteractions(mobileLoginUsecase);
      verifyNoMoreInteractions(getTokenUsecase);
    });
  });
}
