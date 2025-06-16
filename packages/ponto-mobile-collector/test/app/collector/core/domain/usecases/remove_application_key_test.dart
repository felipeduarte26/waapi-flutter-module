import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/repositories/database/iemployee_platform_user_repository.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/repositories/database/imanager_employee_repository.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/repositories/database/imanager_repository.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/repositories/database/iplatform_user_repository.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/remove_application_key_usecase.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';

import '../../../../../mocks/token_mock.dart';

class MockEmployeePlatformUserRepository extends Mock
    implements IEmployeePlatformUserRepository {}

class MockEmployeeFenceRepository extends Mock
    implements IEmployeeFenceRepository {}

class MockEmployeeRepository extends Mock implements IEmployeeRepository {}

class MockCompanyRepository extends Mock implements ICompanyRepository {}

class MockManagerPlatformUserRepository extends Mock
    implements IManagerPlatformUserRepository {}

class MockManagerEmployeeRepository extends Mock
    implements IManagerEmployeeRepository {}

class MockManagerRepository extends Mock implements IManagerRepository {}

class MockPlatformUserRepository extends Mock
    implements IPlatformUserRepository {}

class MockClockingEventRepository extends Mock
    implements IClockingEventRepository {}

class MockSharedPreferences extends Mock implements ISharedPreferencesService {}

class MockSessionService extends Mock implements ISessionService {}

class MockClearKeyStoredDataUsecase extends Mock
    implements ClearKeyStoredDataUsecase {}

class MockGetStoredKeyUsecase extends Mock implements GetStoredKeyUsecase {}

void main() {
  late IEmployeePlatformUserRepository employeePlatformUserRepository;
  late IEmployeeFenceRepository employeeFenceRepository;
  late IEmployeeRepository employeeRepository;
  late ICompanyRepository companyRepository;
  late IManagerPlatformUserRepository managerPlatformUserRepository;
  late IManagerEmployeeRepository managerEmployeeRepository;
  late IManagerRepository managerRepository;
  late IPlatformUserRepository platformUserRepository;
  late IClockingEventRepository clockingEventRepository;
  late ISharedPreferencesService sharedPreferencesService;
  late ISessionService sessionService;
  late RemoveApplicationKeyUsecase removeApplicationKeyUsecase;
  late MockClearKeyStoredDataUsecase clearKeyStoredDataUsecase;
  late MockGetStoredKeyUsecase getStoredKeyUsecase;

  const ApplicationKey applicationKeyMock = ApplicationKey(
    accessKey: 'accessKey',
    tenantName: 'tenantName',
  );

  setUp(
    () {
      employeePlatformUserRepository = MockEmployeePlatformUserRepository();
      employeeFenceRepository = MockEmployeeFenceRepository();
      employeeRepository = MockEmployeeRepository();
      companyRepository = MockCompanyRepository();
      managerPlatformUserRepository = MockManagerPlatformUserRepository();
      managerEmployeeRepository = MockManagerEmployeeRepository();
      managerRepository = MockManagerRepository();
      platformUserRepository = MockPlatformUserRepository();
      clockingEventRepository = MockClockingEventRepository();
      sharedPreferencesService = MockSharedPreferences();
      sessionService = MockSessionService();
      clearKeyStoredDataUsecase = MockClearKeyStoredDataUsecase();
      getStoredKeyUsecase = MockGetStoredKeyUsecase();

      removeApplicationKeyUsecase = RemoveApplicationKeyUsecaseImpl(
        employeePlatformUserRepository: employeePlatformUserRepository,
        employeeFenceRepository: employeeFenceRepository,
        employeeRepository: employeeRepository,
        companyRepository: companyRepository,
        managerPlatformUserRepository: managerPlatformUserRepository,
        managerEmployeeRepository: managerEmployeeRepository,
        managerRepository: managerRepository,
        platformUserRepository: platformUserRepository,
        clockingEventRepository: clockingEventRepository,
        sharedPreferencesService: sharedPreferencesService,
        clearKeyStoredDataUsecase: clearKeyStoredDataUsecase,
        getStoredKeyUsecase: getStoredKeyUsecase,
        sessionService: sessionService,
      );

      registerFallbackValue(
        LogoutOfflineRequested(
          username: tokenMock.username!,
          eraseKeyToken: true,
        ),
      );

      when(
        () => employeePlatformUserRepository.deleteAll(),
      ).thenAnswer(
        (_) async {},
      );

      when(
        () => employeeFenceRepository.deleteAll(),
      ).thenAnswer(
        (_) async {},
      );

      when(
        () => employeeRepository.deleteAll(),
      ).thenAnswer(
        (_) async {},
      );

      when(
        () => companyRepository.deleteAll(),
      ).thenAnswer(
        (_) async {},
      );

      when(
        () => managerPlatformUserRepository.deleteAll(),
      ).thenAnswer(
        (_) async {},
      );

      when(
        () => managerEmployeeRepository.deleteAll(),
      ).thenAnswer(
        (_) async {},
      );

      when(
        () => managerRepository.deleteAll(),
      ).thenAnswer(
        (_) async {},
      );

      when(
        () => platformUserRepository.deleteAll(),
      ).thenAnswer(
        (_) async {},
      );

      when(
        () => clockingEventRepository.deleteAllSynced(),
      ).thenAnswer(
        (_) async {},
      );

      when(
        () => sharedPreferencesService.clearAll(),
      ).thenAnswer(
        (_) async => true,
      );

      when(
        () => sessionService.clean(),
      ).thenAnswer(
        (_) async {},
      );

      when(
        () => clearKeyStoredDataUsecase.call(applicationKeyMock.accessKey),
      ).thenAnswer(
        (_) async {},
      );

      when(
        () => getStoredKeyUsecase.call(null),
      ).thenAnswer(
        (_) async => applicationKeyMock,
      );
    },
  );

  test(
    'Should return without exception when all repositories are deleted',
    () async {
      await removeApplicationKeyUsecase.call();

      verify(() => employeePlatformUserRepository.deleteAll()).called(1);
      verify(() => employeeFenceRepository.deleteAll()).called(1);
      verify(() => employeeRepository.deleteAll()).called(1);
      verify(() => companyRepository.deleteAll()).called(1);
      verify(() => managerPlatformUserRepository.deleteAll()).called(1);
      verify(() => managerEmployeeRepository.deleteAll()).called(1);
      verify(() => managerRepository.deleteAll()).called(1);
      verify(() => platformUserRepository.deleteAll()).called(1);
      verify(() => clockingEventRepository.deleteAllSynced()).called(1);
      verify(() => sharedPreferencesService.clearAll()).called(1);
      verify(() => sessionService.clean()).called(1);
    },
  );

  test(
    'Should throw an exception when [employeePlatformUserRepository] throws an exception',
    () async {
      when(
        () => employeePlatformUserRepository.deleteAll(),
      ).thenThrow(
        Exception(),
      );

      expect(
        () async => await removeApplicationKeyUsecase.call(),
        throwsA(isA<Exception>()),
      );
    },
  );

  test(
    'Should throw an exception when [employeeFenceRepository] throws an exception',
    () async {
      when(
        () => employeeFenceRepository.deleteAll(),
      ).thenThrow(
        Exception(),
      );

      expect(
        () async => await removeApplicationKeyUsecase.call(),
        throwsA(isA<Exception>()),
      );
    },
  );

  test(
    'Should throw an exception when [employeeRepository] throws an exception',
    () async {
      when(
        () => employeeRepository.deleteAll(),
      ).thenThrow(
        Exception(),
      );

      expect(
        () async => await removeApplicationKeyUsecase.call(),
        throwsA(isA<Exception>()),
      );
    },
  );

  test(
    'Should throw an exception when [companyRepository] throws an exception',
    () async {
      when(
        () => companyRepository.deleteAll(),
      ).thenThrow(
        Exception(),
      );

      expect(
        () async => await removeApplicationKeyUsecase.call(),
        throwsA(isA<Exception>()),
      );
    },
  );

  test(
    'Should throw an exception when [managerPlatformUserRepository] throws an exception',
    () async {
      when(
        () => managerPlatformUserRepository.deleteAll(),
      ).thenThrow(
        Exception(),
      );

      expect(
        () async => await removeApplicationKeyUsecase.call(),
        throwsA(isA<Exception>()),
      );
    },
  );

  test(
    'Should throw an exception when [managerEmployeeRepository] throws an exception',
    () async {
      when(
        () => managerEmployeeRepository.deleteAll(),
      ).thenThrow(
        Exception(),
      );

      expect(
        () async => await removeApplicationKeyUsecase.call(),
        throwsA(isA<Exception>()),
      );
    },
  );

  test(
    'Should throw an exception when [managerRepository] throws an exception',
    () async {
      when(
        () => managerRepository.deleteAll(),
      ).thenThrow(
        Exception(),
      );

      expect(
        () async => await removeApplicationKeyUsecase.call(),
        throwsA(isA<Exception>()),
      );
    },
  );

  test(
    'Should throw an exception when [platformUserRepository] throws an exception',
    () async {
      when(
        () => platformUserRepository.deleteAll(),
      ).thenThrow(
        Exception(),
      );

      expect(
        () async => await removeApplicationKeyUsecase.call(),
        throwsA(isA<Exception>()),
      );
    },
  );

  test(
    'Should throw an exception when [clockingEventRepository] throws an exception',
    () async {
      when(
        () => clockingEventRepository.deleteAllSynced(),
      ).thenThrow(
        Exception(),
      );

      expect(
        () async => await removeApplicationKeyUsecase.call(),
        throwsA(isA<Exception>()),
      );
    },
  );

  test(
    'Should throw an exception when [sharedPreferencesService] throws an exception',
    () async {
      when(
        () => sharedPreferencesService.clearAll(),
      ).thenThrow(
        Exception(),
      );

      expect(
        () async => await removeApplicationKeyUsecase.call(),
        throwsA(isA<Exception>()),
      );
    },
  );

  test(
    'Should throw an exception when [getTokenUsecase] throws an exception',
    () async {
      when(
        () => getStoredKeyUsecase.call(null),
      ).thenThrow(
        Exception(),
      );

      expect(
        () async => await removeApplicationKeyUsecase.call(),
        throwsA(isA<Exception>()),
      );
    },
  );

  test(
    'Should throw an exception when [authenticationBloc] throws an exception',
    () async {
      when(
        () => clearKeyStoredDataUsecase.call(applicationKeyMock.accessKey),
      ).thenThrow(
        Exception(),
      );

      expect(
        () async => await removeApplicationKeyUsecase.call(),
        throwsA(isA<Exception>()),
      );
    },
  );

  test(
    'Should throw an exception when [sessionService] throws an exception',
    () async {
      when(
        () => sessionService.clean(),
      ).thenThrow(
        Exception(),
      );

      expect(
        () async => await removeApplicationKeyUsecase.call(),
        throwsA(isA<Exception>()),
      );
    },
  );
}
