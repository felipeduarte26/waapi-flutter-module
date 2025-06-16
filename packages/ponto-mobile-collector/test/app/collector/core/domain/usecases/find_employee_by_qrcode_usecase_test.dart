import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/employee_dto.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/repositories/database/iemployee_repository.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/find_employee_by_qrcode_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/external/mappers/employee_mapper.dart';

import '../../../../../mocks/employee_entity_mock.dart';

class MockEmployeeRepository extends Mock implements IEmployeeRepository {}

void main() {
  const String employeeCode = '123456789';
  late FindEmployeeIdByQrCodeUsecase findEmployeeIdByQrCodeUsecase;
  late IEmployeeRepository employeeRepository;

  setUp(() {
    employeeRepository = MockEmployeeRepository();

    findEmployeeIdByQrCodeUsecase = FindEmployeeIdByQrCodeUsecaseImpl(
      employeeRepository: employeeRepository,
    );

    when(
      () => employeeRepository.findByEmployeeCodeAndEnable(
        employeeCode: employeeCode,
      ),
    ).thenAnswer((_) async => employeeEntityMock);
  });

  group('FindEmployeeIdByQrCodeUsecase', () {
    test('get employee call test', () async {
      EmployeeDto? employee =
          await findEmployeeIdByQrCodeUsecase.call(qrcode: employeeCode);

      var employeeEntity = EmployeeMapper.fromDtoToEntityCollector(employee);

      expect(employee!.name, employeeEntity!.name);
      expect(employee.arpId, employeeEntity.arpId);
      expect(employee.employeeCode, employeeEntity.employeeCode);
      expect(employee.enabled, employeeEntity.enable);
      expect(employee.id, employeeEntity.id);
            
      verify(
        () => employeeRepository.findByEmployeeCodeAndEnable(
          employeeCode: employeeCode,
        ),
      );
    });
  });
}
