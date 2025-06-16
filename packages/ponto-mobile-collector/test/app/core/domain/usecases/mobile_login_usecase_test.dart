import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/mobile_login_usecase_return.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/network_status.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/repositories/database/clocking_event_use_repository.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/repositories/database/imanager_employee_repository.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/repositories/database/imanager_repository.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/repositories/database/iplatform_user_repository.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/repositories/database/ireminder_repository.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/repositories/mobile_login_repository.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/load_user_permissions_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/mobile_login_usecase.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';

import '../../../../mocks/activation_dto_mock.dart';
import '../../../../mocks/activation_entity_mock.dart';
import '../../../../mocks/clocking_event_use_entity_mock.dart';
import '../../../../mocks/configuration_dto_mock.dart';
import '../../../../mocks/configuration_entity_mock.dart';
import '../../../../mocks/device_info_mock.dart';
import '../../../../mocks/employee_dto_mock.dart';
import '../../../../mocks/employee_entity_mock.dart';
import '../../../../mocks/mobile_login_usecase_return_mock.dart';
import '../../../../mocks/platform_user_employee_dto_mock.dart';
import '../../../../mocks/platform_user_entity_mock.dart';
import '../../../../mocks/reminder_entity_mock.dart';
import '../../../../mocks/token_mock.dart';

class MockPlatformService extends Mock implements IPlatformService {}

class MockUtils extends Mock implements IUtils {}

class MockEmployeeRepository extends Mock implements IEmployeeRepository {}

class MockManagerRepository extends Mock implements IManagerRepository {}

class MockIManagerEmployeeRepository extends Mock
    implements IManagerEmployeeRepository {}

class MockIManagerPlatformUserRepository extends Mock
    implements IManagerPlatformUserRepository {}

class MockIPlatformUserRepository extends Mock
    implements IPlatformUserRepository {}

class MockPlatformUserRepository extends Mock
    implements IPlatformUserRepository {}

class MockSharedPreferencesService extends Mock
    implements SharedPreferencesService {}

class MockConfigurationRepository extends Mock
    implements IConfigurationRepository {}

class MockActivationRepository extends Mock implements IActivationRepository {}

class MockSessionService extends Mock implements ISessionService {}

class MockMobileLoginRepository extends Mock implements MobileLoginRepository {}

class MockClockingEventUseRepository extends Mock
    implements ClockingEventUseRepository {}

class MockLoadUserPermissionsUsecase extends Mock
    implements LoadUserPermissionsUsecase {}

class MockReminderRepository extends Mock implements IReminderRepository {}

void main() {
  late IPlatformService platformService;
  late IUtils utils;
  late IEmployeeRepository employeeRepository;
  late IConfigurationRepository configurationRepository;
  late IActivationRepository activationRepository;
  late IManagerPlatformUserRepository managerPlatformUserRepository;
  late IPlatformUserRepository platformUserRepository;
  late IManagerEmployeeRepository managerEmployeeRepository;
  late SharedPreferencesService sharedPreferencesService;
  late ISessionService sessionService;
  late ClockingEventUseRepository clockingEventUseRepository;
  late LoadUserPermissionsUsecase loadUserPermissionsUsecase;
  late IReminderRepository reminderRepository;
  late MobileLoginRepository mobileLoginRepository;

  late MobileLoginUsecase mobileLoginUsecase;

  var userIdentifier = 'username@tenant.com.br';

  setUpAll(() {
    registerFallbackValue(employeeEntityMock);
    registerFallbackValue(EnvironmentEnum.test);
    registerFallbackValue(tokenMock);
    registerFallbackValue(configurationEntityMock);
    registerFallbackValue(activationEntityMock);
    registerFallbackValue(reminderEntityMock);
    registerFallbackValue(clockingEventUseEntityMock);
    registerFallbackValue(deviceMockInfo);
    registerFallbackValue(employeeMockDto);
    registerFallbackValue(configurationDTOMock);
    registerFallbackValue(platformUserMock);
    registerFallbackValue(platformUserDtoMock);
  });

  setUp(() {
    platformService = MockPlatformService();
    utils = MockUtils();
    employeeRepository = MockEmployeeRepository();
    configurationRepository = MockConfigurationRepository();
    activationRepository = MockActivationRepository();
    managerPlatformUserRepository = MockIManagerPlatformUserRepository();
    platformUserRepository = MockPlatformUserRepository();
    managerEmployeeRepository = MockIManagerEmployeeRepository();
    sharedPreferencesService = MockSharedPreferencesService();
    sessionService = MockSessionService();
    clockingEventUseRepository = MockClockingEventUseRepository();
    loadUserPermissionsUsecase = MockLoadUserPermissionsUsecase();
    reminderRepository = MockReminderRepository();
    mobileLoginRepository = MockMobileLoginRepository();

    when(() => reminderRepository.save(reminder: reminderEntityMock))
        .thenAnswer((invocation) => Future(() => true));

    mobileLoginUsecase = MobileLoginUsecaseImpl(
      platformService: platformService,
      employeeRepository: employeeRepository,
      activationRepository: activationRepository,
      configurationRepository: configurationRepository,
      sharedPreferencesService: sharedPreferencesService,
      managerPlatformUserRepository: managerPlatformUserRepository,
      platformUserRepository: platformUserRepository,
      sessionService: sessionService,
      loadUserPermissionsUsecase: loadUserPermissionsUsecase,
      clockingEventUseRepository: clockingEventUseRepository,
      reminderRepository: reminderRepository,
      mobileLoginRepository: mobileLoginRepository,
    );
  });
  group('MobileLogin use case', () {
    test('No internet Connection', () async {
      when(() => platformService.connectivityStatus()).thenAnswer(
        (_) async => Future.value(NetworkStatusEnum.inactive),
      );

      MobileLoginUsecaseReturn? mobileLoginUseReturn =
          await mobileLoginUsecase.call(
        EnvironmentEnum.test,
        tokenMock,
      );

      expect(mobileLoginUseReturn!.noInternetConnection, equals(true));
      expect(mobileLoginUseReturn.noUsername, equals(false));

      verify(() => platformService.connectivityStatus()).called(1);
      verifyNoMoreInteractions(utils);
      verifyNoMoreInteractions(employeeRepository);
      verifyNoMoreInteractions(configurationRepository);
      verifyNoMoreInteractions(activationRepository);
    });

    test('No user token', () async {
      when(() => platformService.connectivityStatus()).thenAnswer(
        (_) async => Future.value(NetworkStatusEnum.inactive),
      );
      Token tokenMock = const Token(
        accessToken: 'accessToken',
        expiresIn: 20000,
        hash: [1],
        refreshToken: 'refreshToken',
        salt: [1],
        tokenType: 'tokenType',
        username: null,
        version: 1,
        email: 'username@tenant.com.br',
        fullName: 'fullName',
        locale: 'en',
        tenantName: 'tenantName',
        type: 'type',
      );

      MobileLoginUsecaseReturn? mobileLoginUseReturn =
          await mobileLoginUsecase.call(
        EnvironmentEnum.test,
        tokenMock,
      );

      expect(mobileLoginUseReturn!.noInternetConnection, equals(true));
      expect(mobileLoginUseReturn.noUsername, equals(true));

      verifyNoMoreInteractions(platformService);
      verifyNoMoreInteractions(utils);
      verifyNoMoreInteractions(employeeRepository);
      verifyNoMoreInteractions(configurationRepository);
      verifyNoMoreInteractions(activationRepository);
    });

    test('With internet Connection', () async {
      when(
        () => employeeRepository.save(employee: any(named: 'employee')),
      ).thenAnswer((_) async => true);

      when(
        () => platformService.connectivityStatus(),
      ).thenAnswer((_) async => NetworkStatusEnum.active);

      when(
        () => mobileLoginRepository.call(any()),
      ).thenAnswer(
        (_) async => MobileLoginUsecaseReturn(
          noInternetConnection: false,
          noUsername: false,
          success: true,
          configurationLocal: configurationDTOMock,
          employeeLocal: employeeMockDto,
          activationLocal: activationDtoMock,
        ),
      );

      when(
        () => sessionService.setLogedUser(
          configurationDto: any(named: 'configurationDto'),
          employeeDto: any(named: 'employeeDto'),
          activationDto: any(named: 'activationDto'),
          username: any(named: 'username'),
        ),
      ).thenAnswer((_) async => {});

      when(
        () => loadUserPermissionsUsecase.call(any(), any()),
      ).thenAnswer((_) async => {});

      when(
        () => sharedPreferencesService.setSessionEmployeeId(
          employeeId: any(named: 'employeeId'),
        ),
      ).thenAnswer((_) async => {});

      when(
        () => sharedPreferencesService.setSessionPlatformUsername(
          platformUserName: any(named: 'platformUserName'),
        ),
      ).thenAnswer((_) async => {});

      when(
        () => sharedPreferencesService.setUserLoggedIsManager(
          value: any(named: 'value'),
        ),
      ).thenAnswer((_) async => {});

      when(
        () => activationRepository.save(
          activation: any(named: 'activation'),
          employeeId: any(named: 'employeeId'),
        ),
      ).thenAnswer((_) async => true);

      when(
        () => configurationRepository.save(
          config: any(named: 'config'),
          employeeId: any(named: 'employeeId'),
          username: any(named: 'username'),
        ),
      ).thenAnswer((_) async => true);

      when(
        () => reminderRepository.deleteByEmployeeId(
          employeeId: any(named: 'employeeId'),
        ),
      ).thenAnswer((_) async => {});

      when(
        () => clockingEventUseRepository.deleteByEmployeeId(
          employeeId: any(named: 'employeeId'),
        ),
      ).thenAnswer((_) async => 1);

      when(
        () => clockingEventUseRepository.save(
          clocking: any(named: 'clocking'),
          employeeId: any(named: 'employeeId'),
        ),
      ).thenAnswer((_) async => true);

      MobileLoginUsecaseReturn? mobileLoginUseReturn =
          await mobileLoginUsecase.call(
        EnvironmentEnum.test,
        tokenMock,
      );

      expect(mobileLoginUseReturn!.noInternetConnection, equals(false));
      expect(mobileLoginUseReturn.noUsername, equals(false));

      verify(
        () => platformService.connectivityStatus(),
      ).called(1);

      verify(
        () => activationRepository.save(
          activation: activationEntityMock,
          employeeId: employeeMockDto.id,
        ),
      ).called(1);

      /* verify(
        () => configurationRepository.save(
          config: configurationEntityMock,
          employeeId: employeeDtoMock.id,
          username: tokenMock.username,
        ),
      ).called(1);*/

      verify(
        () => employeeRepository.save(employee: any(named: 'employee')),
      ).called(1);

      /*verify(
        () => clockingEventUseRepository.save(
            clocking: clockingEventUseEntityMock,
            employeeId: employeeMockDto.id,),
      ).called(1);*/
      verify(
        () => clockingEventUseRepository.save(
          clocking: clockingEventUseEntityMock,
          employeeId: employeeMockDto.id,
        ),
      ).called(1);
    });

    test('Test saveManagersEmployee', () async {
      when(() => platformService.connectivityStatus()).thenAnswer(
        (_) async => Future.value(NetworkStatusEnum.active),
      );

      when(() => mobileLoginRepository.call(EnvironmentEnum.test))
          .thenAnswer((_) async => mobileLoginUsecaseReturnMock);

      when(
        () => loadUserPermissionsUsecase.call(
          tokenMock.username!,
          TokenType.user,
        ),
      ).thenAnswer((_) async => {});

      when(
        () => sharedPreferencesService.setSessionEmployeeId(
          employeeId: employeeMockDto.id,
        ),
      ).thenAnswer((_) async => {});

      when(
        () => sharedPreferencesService.setSessionPlatformUsername(
          platformUserName: userIdentifier,
        ),
      ).thenAnswer(
        (_) async => {},
      );

      when(
        () => platformUserRepository.save(
          platformUser: platformUserMock,
        ),
      ).thenAnswer((_) async => true);

      when(
        () => managerPlatformUserRepository.save(
          managerId: configurationEntityMock.managerId!,
          platformUserId: platformUserDtoMock.id!,
        ),
      ).thenAnswer((_) async => true);

      when(
        () => sharedPreferencesService.getUserLoggedIsManager(),
      ).thenAnswer((_) async => false);

      when(
        () => managerEmployeeRepository.existManagerByEmployeeId(
          employeeId: employeeMockDto.id,
        ),
      ).thenAnswer((_) async => false);

      when(
        () => sharedPreferencesService.setUserLoggedIsManager(value: true),
      ).thenAnswer((_) async => {});

      when(
        () => platformUserRepository.save(
          platformUser: any(named: 'platformUser'),
        ),
      ).thenAnswer((_) async => true);

      when(() => platformService.getDeviceInfoDto()).thenAnswer(
        (_) async => Future.value(deviceMockInfo),
      );

      when(
        () => employeeRepository.save(employee: any(named: 'employee')),
      ).thenAnswer((_) async => true);

      when(
        () => activationRepository.save(
          activation: activationEntityMock,
          employeeId: employeeMockDto.id,
        ),
      ).thenAnswer((_) async => true);

      when(
        () => configurationRepository.save(
          config: any(named: 'config'),
          employeeId: any(named: 'employeeId'),
          username: any(named: 'username'),
        ),
      ).thenAnswer((_) async => true);

      when(
        () => reminderRepository.deleteByEmployeeId(
          employeeId: employeeMockDto.id,
        ),
      ).thenAnswer((_) async => Future.value());

      when(
        () => clockingEventUseRepository.deleteByEmployeeId(
          employeeId: employeeMockDto.id,
        ),
      ).thenAnswer((invocation) async => 1);

      when(
        () => clockingEventUseRepository.save(
          clocking: clockingEventUseEntityMock,
          employeeId: employeeMockDto.id,
        ),
      ).thenAnswer((invocation) async => true);

      MobileLoginUsecaseReturn? mobileLoginUseReturn =
          await mobileLoginUsecase.call(
        EnvironmentEnum.test,
        tokenMock,
      );

      expect(mobileLoginUseReturn!.noInternetConnection, equals(false));
      expect(mobileLoginUseReturn.noUsername, equals(false));

      verify(
        () => platformService.connectivityStatus(),
      ).called(1);

      verify(
        () => activationRepository.save(
          activation: activationEntityMock,
          employeeId: employeeMockDto.id,
        ),
      ).called(1);

      verify(
        () => configurationRepository.save(
          config: any(named: 'config'),
          employeeId: any(named: 'employeeId'),
          username: any(named: 'username'),
        ),
      ).called(1);

      verify(
        () => employeeRepository.save(employee: any(named: 'employee')),
      ).called(1);

      verify(
        () => clockingEventUseRepository.save(
          clocking: clockingEventUseEntityMock,
          employeeId: employeeMockDto.id,
        ),
      ).called(1);
    });

    test('Test saveManagersEmployee when userLogged is Manager', () async {
      when(
        () => mobileLoginRepository.call(any()),
      ).thenAnswer(
        (_) async => MobileLoginUsecaseReturn(
          noInternetConnection: false,
          noUsername: false,
          success: true,
          configurationLocal: configurationDTOMock,
          employeeLocal: employeeMockDto,
          activationLocal: activationDtoMock,
        ),
      );
      when(() => platformService.connectivityStatus()).thenAnswer(
        (_) async => Future.value(NetworkStatusEnum.active),
      );

      when(
        () => loadUserPermissionsUsecase.call(
          tokenMock.username!,
          TokenType.user,
        ),
      ).thenAnswer((_) async => {});

      when(
        () => sharedPreferencesService.setSessionPlatformUsername(
          platformUserName: userIdentifier,
        ),
      ).thenAnswer(
        (_) async => {},
      );

      when(
        () => sharedPreferencesService.setSessionEmployeeId(
          employeeId: any(named: 'employeeId'),
        ),
      ).thenAnswer(
        (_) async => {},
      );

      when(
        () => platformUserRepository.save(
          platformUser: any(named: 'platformUser'),
        ),
      ).thenAnswer((_) async => true);

      when(
        () => managerPlatformUserRepository.save(
          managerId: any(named: 'managerId'),
          platformUserId: any(named: 'platformUserId'),
        ),
      ).thenAnswer((_) async => true);

      when(
        () => sharedPreferencesService.getUserLoggedIsManager(),
      ).thenAnswer((_) async => true);

      when(
        () => managerEmployeeRepository.existManagerByEmployeeId(
          employeeId: any(named: 'employeeId'),
        ),
      ).thenAnswer((_) async => true);

      when(
        () => sharedPreferencesService.setUserLoggedIsManager(value: true),
      ).thenAnswer((_) async => {});

      when(
        () => platformUserRepository.save(
          platformUser: any(named: 'platformUser'),
        ),
      ).thenAnswer((_) async => true);

      when(
        () => managerEmployeeRepository.deleteByEmployeeId(
          employeeId: any(named: 'employeeId'),
        ),
      ).thenAnswer((_) async => false);

      when(() => platformService.getDeviceInfoDto()).thenAnswer(
        (_) async => Future.value(deviceMockInfo),
      );

      when(
        () => employeeRepository.save(
          employee: any(named: 'employee'),
        ),
      ).thenAnswer((_) async => true);

      when(
        () => activationRepository.save(
          activation: any(named: 'activation'),
          employeeId: any(named: 'employeeId'),
        ),
      ).thenAnswer((_) async => true);

      when(
        () => configurationRepository.save(
          config: any(named: 'config'),
          employeeId: any(named: 'employeeId'),
          username: any(named: 'username'),
        ),
      ).thenAnswer((_) async => true);

      when(
        () => reminderRepository.deleteByEmployeeId(
          employeeId: any(named: 'employeeId'),
        ),
      ).thenAnswer((_) async => Future.value());

      when(
        () => clockingEventUseRepository.deleteByEmployeeId(
          employeeId: any(named: 'employeeId'),
        ),
      ).thenAnswer((invocation) async => 1);

      when(
        () => clockingEventUseRepository.save(
          clocking: any(named: 'clocking'),
          employeeId: any(named: 'employeeId'),
        ),
      ).thenAnswer((invocation) async => true);

      MobileLoginUsecaseReturn? mobileLoginUseReturn =
          await mobileLoginUsecase.call(
        EnvironmentEnum.test,
        tokenMock,
      );

      expect(mobileLoginUseReturn!.noInternetConnection, equals(false));
      expect(mobileLoginUseReturn.noUsername, equals(false));

      verify(
        () => platformService.connectivityStatus(),
      ).called(1);

      verify(
        () => activationRepository.save(
          activation: any(named: 'activation'),
          employeeId: any(named: 'employeeId'),
        ),
      ).called(1);

      verify(
        () => configurationRepository.save(
          config: any(named: 'config'),
          employeeId: any(named: 'employeeId'),
          username: any(named: 'username'),
        ),
      ).called(1);

      verify(
        () => employeeRepository.save(
          employee: any(named: 'employee'),
        ),
      ).called(1);
    });

    /*test('forbidden to call mobileLogin test', () async {
      when(
        () => mobileLoginRepository.call(any()),
      ).thenAnswer(
        (_) async => MobileLoginUsecaseReturn(
          noInternetConnection: false,
          noUsername: false,
          success: true,
          configurationLocal: configurationDTOMock,
          employeeLocal: employeeMockDto,
          activationLocal: activationDtoMock,
        ),
      );

      when(() => platformService.connectivityStatus()).thenAnswer(
        (_) async => NetworkStatusEnum.active,
      );

      when(() => platformService.getDeviceInfoDto()).thenAnswer(
        (_) async => deviceMockInfo,
      );

      MobileLoginUsecaseReturn? mobileLoginUseReturn =
          await mobileLoginUsecase.call(
        EnvironmentEnum.test,
        tokenMock,
      );

      expect(mobileLoginUseReturn!.noInternetConnection, true);
      expect(mobileLoginUseReturn.noUsername, false);
      expect(mobileLoginUseReturn.employeeLocal, null);

      verify(() => platformService.connectivityStatus());
      verify(() => platformService.getDeviceInfoDto());

      verifyNoMoreInteractions(platformService);
    });*/

    test('Save PlatformUserManager when employee.managers is not null',
        () async {
      when(() => platformService.connectivityStatus()).thenAnswer(
        (_) async => Future.value(NetworkStatusEnum.active),
      );

      when(
        () => loadUserPermissionsUsecase.call(
          'username@tenant.com.br',
        ),
      ).thenAnswer((_) async => {});

      when(() => platformService.getDeviceInfoDto()).thenAnswer(
        (_) async => Future.value(deviceMockInfo),
      );

      when(
        () => sharedPreferencesService.setSessionEmployeeId(
          employeeId: employeeDtoWithManagersAndPlatformUsersMock.id,
        ),
      ).thenAnswer(
        (_) async => {},
      );

      when(
        () => sharedPreferencesService.setUserLoggedIsManager(
          value: true,
        ),
      ).thenAnswer(
        (_) async => {},
      );

      when(
        () => sharedPreferencesService.setSessionPlatformUsername(
          platformUserName: userIdentifier,
        ),
      ).thenAnswer(
        (_) async => {},
      );

      when(
        () => configurationRepository.save(
          config: configurationEntityMock,
          employeeId: employeeDtoMock.id,
          username: tokenMock.username,
        ),
      ).thenAnswer((_) async => true);

      when(
        () => activationRepository.save(
          activation: activationEntityMock,
          employeeId: employeeEntityMock.id,
        ),
      ).thenAnswer((_) async => true);
    });

    /*test('unknown error when calling mobilelogin service test', () async {
      when(() => platformService.connectivityStatus()).thenAnswer(
        (_) async => NetworkStatusEnum.active,
      );

      when(() => platformService.getDeviceInfoDto()).thenAnswer(
        (_) async => deviceMockInfo,
      );

      MobileLoginUsecaseReturn? mobileLoginUseReturn =
          await mobileLoginUsecase.call(
        EnvironmentEnum.test,
        tokenMock,
      );

      expect(mobileLoginUseReturn!.success, false);

      verify(() => platformService.connectivityStatus());

      verify(() => platformService.getDeviceInfoDto());
    });*/
  });
}
