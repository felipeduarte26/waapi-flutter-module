// ignore_for_file: unused_local_variable

import 'dart:async';

import 'package:dart_mobile_clocking_event/src/dto/manager_employee_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/repositories/database/iemployee_repository.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/repositories/database/imanager_employee_repository.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/repositories/database/imanager_repository.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/repositories/database/iplatform_user_repository.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/shared_preferences/ishared_preferences_service.dart';
import 'package:ponto_mobile_collector/app/collector/modules/time_adjustment/domain/usecases/get_employees_by_manager_usecase.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';

import '../../../../mocks/employee_dto_mock.dart';
import '../../../../mocks/employee_entity_mock.dart';
import '../../../../mocks/platform_user_entity_mock.dart';

class MockPlatformUserRepository extends Mock
    implements IPlatformUserRepository {}

class MockIEmployeeRepository extends Mock implements IEmployeeRepository {}

class MockManagerRepository extends Mock implements IManagerRepository {}

class MockManagerEmployeeRepository extends Mock
    implements IManagerEmployeeRepository {}

class MockISharedPreferencesService extends Mock
    implements ISharedPreferencesService {}

class MockGetStoredTokenUsecase extends Mock implements GetStoredTokenUsecase {}

void main() {
  late GetEmployeesByManagerUsecase useCase;
  late IPlatformUserRepository platformUserRepository;
  late IManagerRepository managerRepository;
  late IManagerEmployeeRepository managerEmployeeRepository;
  late IEmployeeRepository employeeRepository;
  late ISharedPreferencesService sharedPreferencesService;
  late GetStoredTokenUsecase getStoredTokenUsecase;

  String usernameUserLoggeed = 'usernameUser';

  setUp(() {
    platformUserRepository = MockPlatformUserRepository();
    managerRepository = MockManagerRepository();
    managerEmployeeRepository = MockManagerEmployeeRepository();
    employeeRepository = MockIEmployeeRepository();
    sharedPreferencesService = MockISharedPreferencesService();
    getStoredTokenUsecase = MockGetStoredTokenUsecase();
    useCase = GetEmployeesByManagerUsecaseImpl(
      platformUserRepository: platformUserRepository,
      managerRepository: managerRepository,
      employeeRepository: employeeRepository,
    );
  });
  test(
      'should return empty list of employees when usernameUserLoggeed is empty',
      () async {
    when(() => platformUserRepository.findByUserName(username: ''))
        .thenAnswer((_) async => null);

    when(() => getStoredTokenUsecase.call(const UserName()))
        .thenAnswer((_) async => (token: null, exception: null));

    when(
      () => sharedPreferencesService.getSessionPlatformUsername(),
    ).thenAnswer(
      (invocation) => Future.value(''),
    );
    // Act
    final result = await useCase.call(
      username: '',
    );
    // Assert
    expect(result, isEmpty);
  });

  test('should return empty list of employees when managerId is empty',
      () async {
    when(
      () => platformUserRepository.findByUserName(
        username: any(
          named: 'username',
        ),
      ),
    ).thenAnswer((_) async => Future.value(platformUserMock));

    when(() => getStoredTokenUsecase.call(const UserName()))
        .thenAnswer((_) async => (token: null, exception: null));
    when(
      () => sharedPreferencesService.getSessionPlatformUsername(),
    ).thenAnswer(
      (invocation) => Future.value(usernameUserLoggeed),
    );

    FutureOr<ManagerEmployeeDto?>? managerDtoMock;
    when(
      () => managerRepository.findByPlatformUserId(
        platformUserId: any(
          named: 'platformUserId',
        ),
      ),
    ).thenAnswer((_) async => Future.value(managerDtoMock));

    // Act
    final result = await useCase.call(username: usernameUserLoggeed);
    // Assert
    expect(result, isEmpty);
  });

  test(
      'should return list of employees when usernameUserLoggeed is from a manager',
      () async {
    when(() => getStoredTokenUsecase.call(const UserName()))
        .thenAnswer((_) async => (token: null, exception: null));
    when(
      () => platformUserRepository.findByUserName(
        username: any(
          named: 'username',
        ),
      ),
    ).thenAnswer((_) async => Future.value(platformUserMock));

    when(
      () => sharedPreferencesService.getSessionPlatformUsername(),
    ).thenAnswer(
      (invocation) => Future.value(usernameUserLoggeed),
    );

    when(
      () => sharedPreferencesService.getSessionEmployeeId(),
    ).thenAnswer(
      (invocation) => Future.value(employeeDtoMock.id),
    );

    when(
      () => employeeRepository.findById(id: employeeDtoMock.id),
    ).thenAnswer(
      (invocation) => Future.value(employeeEntityMock),
    );

    when(
      () => employeeRepository.findEmployeesByManager(
        managerId: any(named: 'managerId'),
      ),
    ).thenAnswer((_) async => Future.value([employeeEntityMock]));

    FutureOr<ManagerEmployeeDto?> managerDtoMock = ManagerEmployeeDto(
      employees: [],
      id: '1',
      mail: 'name',
      platformUsers: const [],
      platformUserName: ' teste',
    );
    when(
      () => managerRepository.findByPlatformUserId(
        platformUserId: any(
          named: 'platformUserId',
        ),
      ),
    ).thenAnswer((_) async => Future.value(managerDtoMock));

    // Act
    final result = await useCase.call(
      username: usernameUserLoggeed,
      employeeIdsFromClockingEventList: [employeeEntityMock.id],
    );
    // Assert
    expect(result!.first.arpId, employeeEntityMock.arpId);
    expect(result.first.id, employeeEntityMock.id);
    expect(result.first.cpf, employeeEntityMock.cpf);
    expect(result.first.name, employeeEntityMock.name);
  });
}
