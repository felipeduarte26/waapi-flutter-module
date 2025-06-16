import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/repositories/database/iemployee_platform_user_repository.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/repositories/database/iplatform_user_repository.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/find_employee_by_username_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/external/drift/collector_database.dart';
import 'package:ponto_mobile_collector/app/collector/core/external/mappers/employee_mapper.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';

import '../../../../../mocks/employee_entity_mock.dart';
import '../../../../../mocks/platform_user_entity_mock.dart';

class MockEmployeeRepository extends Mock implements IEmployeeRepository {}

class MockConfigurationRepository extends Mock
    implements IConfigurationRepository {}

class MockEmployeePlatformUserRepository extends Mock
    implements IEmployeePlatformUserRepository {}

class MockPlatformUserRepository extends Mock
    implements IPlatformUserRepository {}

void main() {
  late FindEmployeeIdByUsernameUsecase usecase;

  late IEmployeeRepository employeeRepository;
  late IEmployeePlatformUserRepository employeePlatformUserRepository;
  late IPlatformUserRepository platformUserRepository;

  setUp(() {
    employeeRepository = MockEmployeeRepository();
    employeePlatformUserRepository = MockEmployeePlatformUserRepository();
    platformUserRepository = MockPlatformUserRepository();

    usecase = FindEmployeeIdByUsernameUsecaseImpl(
      employeeRepository: employeeRepository,
      employeePlatformUserRepository: employeePlatformUserRepository,
      platformUserRepository: platformUserRepository,
    );
  });

  group(
    'Find Employee Id By Username Usecase Test',
    () {
      test('Configuration not found should return null', () async {
        var username = 'username';
        when(
          () => platformUserRepository.findByUserName(
            username: username,
          ),
        ).thenAnswer((_) async => null);

        expect(await usecase.call(username: username), null);
      });

      test('PlatformUser found but no employee with Id should return null',
          () async {
        var username = 'username';

        when(
          () => platformUserRepository.findByUserName(
            username: username,
          ),
        ).thenAnswer((_) async => platformUserMock);

        when(
          () => employeePlatformUserRepository.findByPlatformUserId(
            platformUserId: platformUserMock.id!,
          ),
        ).thenAnswer((_) async => null);

        expect(await usecase.call(username: username), null);
      });
      test('PlatformUser and employee found should return employee', () async {
        var username = 'username';

        var employeePlatformUsersTableData =
            const EmployeePlatformUsersTableData(
          employeeId: 'id',
          platforUsersId: 'id',
        );

        when(
          () => platformUserRepository.findByUserName(
            username: username,
          ),
        ).thenAnswer((_) async => platformUserMock);

        when(
          () => employeePlatformUserRepository.findByPlatformUserId(
            platformUserId: platformUserMock.id!,
          ),
        ).thenAnswer((_) async => employeePlatformUsersTableData);

        when(
          () => employeeRepository.findById(
            id: employeePlatformUsersTableData.employeeId,
          ),
        ).thenAnswer((_) async => employeeEntityMock);

        var employeeDto = EmployeeMapper.fromEntityToDtoCollector(employeeEntityMock);

        var employeeResult = (await usecase.call(username: username));

        expect(employeeResult!.arpId, employeeDto!.arpId);
        expect(employeeResult.employeeCode, employeeDto.employeeCode);
        expect(employeeResult.enabled, employeeDto.enabled);
        expect(employeeResult.id, employeeDto.id);
        expect(employeeResult.name, employeeDto.name);
      });
    },
  );
}
