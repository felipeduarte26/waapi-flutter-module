import 'package:mobile_authentication/mobile_authentication_service.dart'
    as auth;

import 'company_dto_mock.dart';
import 'manager_employee_dto_mock.dart';
import 'platform_user_employee_dto_mock.dart';

auth.LoginEmployeeDTO loginEmployeeDtoMock = auth.LoginEmployeeDTO(
  company: companyDtoMock,
  cpfNumber: 'cpfNumber',
  id: '83e1a9c8-11ec-4f8b-8a92-3f22782b4f9f',
  mail: 'mail',
  name: 'name',
  registrationNumber: '1',
  employeeType: auth.EmployeeType.companyEmployee,
  employeeCode: '123456789',
);


auth.LoginEmployeeDTO loginEmployeeDtoMockwithManagersAndPlatformUsers = auth.LoginEmployeeDTO(
  company: companyDtoMock,
  cpfNumber: 'cpfNumber',
  id: '83e1a9c8-11ec-4f8b-8a92-3f22782b4f9f',
  mail: 'mail',
  name: 'name',
  registrationNumber: '1',
  employeeType: auth.EmployeeType.companyEmployee,
  employeeCode: '123456789',
  managers: [managerEmployeeDtoMock],
  platformUsers: [platformUserEmployeeDtoMock],
);
