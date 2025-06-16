import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/repositories/database/iemployee_platform_user_repository.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/repositories/database/iplatform_user_repository.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/check_user_is_employee_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/external/drift/collector_database.dart';

import '../../../../../mocks/platform_user_entity_mock.dart';



class MockIEmployeePlatformUserRepository extends Mock implements IEmployeePlatformUserRepository {}

class MockIPlatformUserRepository extends Mock implements IPlatformUserRepository {}

void main() {
  late CheckUserIsEmployeeUsecaseImpl usecase;
  late MockIEmployeePlatformUserRepository mockEmployeePlatformUserRepository;
  late MockIPlatformUserRepository mockPlatformUserRepository;

  setUp(() {
    mockEmployeePlatformUserRepository = MockIEmployeePlatformUserRepository();
    mockPlatformUserRepository = MockIPlatformUserRepository();
    usecase = CheckUserIsEmployeeUsecaseImpl(
      employeePlatformUserRepository: mockEmployeePlatformUserRepository,
      platformUserRepository: mockPlatformUserRepository,
    );
  });

  group('CheckUserIsEmployeeUsecase', () {
    const username = 'username';
    EmployeePlatformUsersTableData employeePlatformUsersTableData = const EmployeePlatformUsersTableData(employeeId:'123' , platforUsersId: 'id' );

    test('should return true if the user is an employee', () async {

      when(() => mockPlatformUserRepository.findByUserName(username: username))
          .thenAnswer((_) async => platformUserMock);
      when(() => mockEmployeePlatformUserRepository.findByPlatformUserId(
              platformUserId: platformUserMock.id!,),)
          .thenAnswer((_) async => employeePlatformUsersTableData);

      final result = await usecase.call(username: username);

      expect(result, true);
       verify(() => mockPlatformUserRepository.findByUserName(username: username));
      verify(()  => mockEmployeePlatformUserRepository.findByPlatformUserId(
              platformUserId: platformUserMock.id!,),)
          .called(1);
    });

    test('should return false if the user is not an employee', () async {
     
      when(() => mockPlatformUserRepository.findByUserName(username: username))
          .thenAnswer((_) async => platformUserMock);
      when(() => mockEmployeePlatformUserRepository.findByPlatformUserId(
            platformUserId: platformUserMock.id!,),)
          .thenAnswer((_) async => null);

      final result = await usecase.call(username: username);

      expect(result, false);
         verify(() => mockPlatformUserRepository.findByUserName(username: username));
      verify(()  => mockEmployeePlatformUserRepository.findByPlatformUserId(
              platformUserId: platformUserMock.id!,),)
          .called(1);
    });

    test('should return false if the user does not exist', () async {
   when(() => mockPlatformUserRepository.findByUserName(username: username))
          .thenAnswer((_) async => null);

      final result = await usecase.call(username: username);

      expect(result, false);
     verify(() => mockPlatformUserRepository.findByUserName(username: username));
      verifyNever(() => mockEmployeePlatformUserRepository.findByPlatformUserId(
          platformUserId: any(named: 'platformUserId'),),);
    });
  });
}
