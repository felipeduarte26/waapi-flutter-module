import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart'
    as clock;
import 'package:mobile_authentication/mobile_authentication_service.dart'
    as auth;
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/manager_employee_dto.dart';

import 'platform_user_employee_dto_mock.dart';

clock.ManagerEmployeeDto managerMock = clock.ManagerEmployeeDto(
  employees: [],
  id: '1',
  mail: 'name',
  platformUsers: [platformUserDtoMock],
  platformUserName: 'teste',
);

auth.ManagerEmployeeDTO managerEmployeeDtoMock = auth.ManagerEmployeeDTO(
  id: '1',
  mail: 'name',
  platformUsers: const [],
  platformUserName: ' teste',
);

ManagerEmployeeDto managerDtoMock = ManagerEmployeeDto(
  id: '1',
  mail: 'name',
  platformUsers: const [],
  platformUserName: ' teste',
);
