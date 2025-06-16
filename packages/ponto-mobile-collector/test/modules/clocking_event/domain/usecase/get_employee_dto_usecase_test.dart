import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/domain/usecase/get_employee_dto_usecase.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';

import '../../../../mocks/employee_entity_mock.dart';

class MockEmployeeRepository extends Mock implements IEmployeeRepository {}

void main() {
  const String tId = 'emplooyeeId';
  late IGetEmployeeDtoUsecase getEmployeeDtoUseca;
  late IEmployeeRepository employeeRepository;

  setUp(
    () {
      employeeRepository = MockEmployeeRepository();
      getEmployeeDtoUseca =
          GetEmployeeDtoUsecase(employeeRepository: employeeRepository);
    },
  );

  group(
    'GetEmployeeDtoUsecase',
    () {
      test(
        'call test',
        () {
          when(
            () => employeeRepository.findById(id: tId),
          ).thenAnswer((_) async => employeeEntityMock);

          getEmployeeDtoUseca.call(id: tId);

          verify(
            () => employeeRepository.findById(id: tId),
          ).called(1);

          verifyNoMoreInteractions(employeeRepository);
        },
      );
    },
  );
}
