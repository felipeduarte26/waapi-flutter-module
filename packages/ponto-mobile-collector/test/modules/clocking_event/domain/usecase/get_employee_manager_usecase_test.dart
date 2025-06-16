import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/repositories/database/iemployee_platform_user_repository.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/repositories/database/iemployee_repository.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/repositories/database/iplatform_user_repository.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/get_employee_manager_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/external/drift/collector_database.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';

import '../../../../mocks/employee_dto_mock.dart';
import '../../../../mocks/employee_entity_mock.dart';
import '../../../../mocks/platform_user_employee_dto_mock.dart';
import '../../../../mocks/platform_user_entity_mock.dart';

class MockEmployeeRepository extends Mock implements IEmployeeRepository {}

class MockEmployeePlatformUserRepository extends Mock
    implements IEmployeePlatformUserRepository {}

class MockGetStoredTokenUsecase extends Mock implements GetStoredTokenUsecase {}

class MockPlatformUserRepository extends Mock
    implements IPlatformUserRepository {}

void main() {
  late GetEmployeeManagerUsecaseImpl usecase;
  late MockEmployeeRepository mockEmployeeRepository;
  late MockEmployeePlatformUserRepository mockEmployeePlatformUserRepository;
  late MockGetStoredTokenUsecase mockGetStoredTokenUsecase;
  late MockPlatformUserRepository mockPlatformUserRepository;

  Token? tokenUser = const Token(
    version: 123,
    expiresIn: 1,
    tokenType: 'tokenTypeUser',
    accessToken: 'accessTokenUser',
    username: 'usernameUser',
    refreshToken: 'refreshTokenUser',
  );

  var employeePlatformUser = EmployeePlatformUsersTableData(
    employeeId: employeeDtoMock.id,
    platforUsersId: platformUserDtoMock.id.toString(),
  );

  var username = 'usernameUser';

  setUp(() {
    mockEmployeeRepository = MockEmployeeRepository();
    mockEmployeePlatformUserRepository = MockEmployeePlatformUserRepository();
    mockGetStoredTokenUsecase = MockGetStoredTokenUsecase();
    mockPlatformUserRepository = MockPlatformUserRepository();
    usecase = GetEmployeeManagerUsecaseImpl(
      employeeRepository: mockEmployeeRepository,
      employeePlatformUserRepository: mockEmployeePlatformUserRepository,
      platformUserRepository: mockPlatformUserRepository,
    );
  });

  test('should return null when no platform user id is found', () async {
    when(() => mockGetStoredTokenUsecase.call(const UserName()))
        .thenAnswer((_) async => (token: null, exception: null));


    when(
      () => mockPlatformUserRepository.findByUserName(
        username: username,
      ),
    ).thenAnswer((_) async => platformUserMock);

    when(
      () => mockEmployeePlatformUserRepository.findByPlatformUserId(
        platformUserId: platformUserMock.id.toString(),
      ),
    ).thenAnswer((_) async => null);

    final result = await usecase.call(username: username);

    expect(result, null);
    verifyNever(() => mockEmployeeRepository.findById(id: employeeDtoMock.id));
  });

  test('should return null when no employee platform user is found', () async {
    when(() => mockGetStoredTokenUsecase.call(const UserName()))
        .thenAnswer((_) async => (token: tokenUser, exception: null));

    when(
      () => mockPlatformUserRepository.findByUserName(
        username: username,
      ),
    ).thenAnswer((_) async => platformUserMock);

    when(
      () => mockEmployeePlatformUserRepository.findByPlatformUserId(
        platformUserId: platformUserMock.id.toString(),
      ),
    ).thenAnswer((_) async => null);

    final result = await usecase.call(username: username);

    expect(result, null);
    verify(
      () => mockPlatformUserRepository.findByUserName(
        username: username,
      ),
    ).called(1);

    verifyNever(() => mockEmployeeRepository.findById(id: employeeDtoMock.id));
  });

  test('should return employee when employee platform user is found', () async {
    when(() => mockGetStoredTokenUsecase.call(const UserName()))
        .thenAnswer((_) async => (token: tokenUser, exception: null));

    when(
      () => mockPlatformUserRepository.findByUserName(
        username: username,
      ),
    ).thenAnswer((_) async => platformUserMock);

    when(
      () => mockEmployeePlatformUserRepository.findByPlatformUserId(
        platformUserId: platformUserMock.id.toString(),
      ),
    ).thenAnswer((_) async => employeePlatformUser);

    when(() => mockEmployeeRepository.findById(id: employeeDtoMock.id))
        .thenAnswer((_) async => employeeEntityMock);

    final result = await usecase.call(username: username);

    expect(result!.arpId, employeeDtoMock.arpId);
    expect(result.id, employeeDtoMock.id);
    expect(result.name, employeeDtoMock.name);
    

    verify(
      () => mockPlatformUserRepository.findByUserName(
        username: username,
      ),
    ).called(1);

    verify(
      () => mockEmployeePlatformUserRepository.findByPlatformUserId(
        platformUserId: platformUserMock.id.toString(),
      ),
    ).called(1);
    verify(() => mockEmployeeRepository.findById(id: employeeDtoMock.id))
        .called(1);
  });
}
