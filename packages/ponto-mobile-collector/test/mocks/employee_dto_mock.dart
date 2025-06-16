import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart'
    as clock;
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/employee_dto.dart';

import 'clock_company_dto_mock.dart';
import 'manager_employee_dto_mock.dart';
import 'platform_user_employee_dto_mock.dart';
import 'reminder_dto_mock.dart';

clock.EmployeeDto employeeDtoMock = clock.EmployeeDto(
  id: '83e1a9c8-11ec-4f8b-8a92-3f22782b4f9f',
  name: 'name',
  employeeType: 'employeeType',
  company: clockCompanyDtoMock,
  cpf: 'cpf',
  arpId: 'arpId',
  registrationNumber: 'registrationNumber',
  mail: 'mail',
  nfcCode: 'nfcCode',
  faceRegistered: '83e1a9c811ec4f8b8a923f22782b4f9f',
  employeeCode: '123456789',
);

clock.EmployeeDto employeeDtoMockNoFaceRegistered = clock.EmployeeDto(
  id: '83e1a9c8-11ec-4f8b-8a92-3f22782b4f9f',
  name: 'name',
  employeeType: 'employeeType',
  company: clockCompanyDtoMock,
  cpf: 'cpf',
  arpId: 'arpId',
  registrationNumber: 'registrationNumber',
  mail: 'mail',
  nfcCode: 'nfcCode',
  faceRegistered: null,
  employeeCode: '123456789',
);

clock.EmployeeDto employeeDtoWithManagersAndPlatformUsersMock =
    clock.EmployeeDto(
  id: '83e1a9c8-11ec-4f8b-8a92-3f22782b4f9f',
  name: 'name',
  employeeType: 'employeeType',
  company: clockCompanyDtoMock,
  cpf: 'cpf',
  arpId: 'arpId',
  registrationNumber: 'registrationNumber',
  mail: 'mail',
  nfcCode: 'nfcCode',
  faceRegistered: '83e1a9c811ec4f8b8a923f22782b4f9f',
  employeeCode: '123456789',
  managers: [
    managerMock,
  ],
  platformUsers: [
    platformUserDtoMock,
  ],
  reminders: [
    reminderDto,
  ],
);

clock.EmployeeDto employeeNoFaceDtoMock = clock.EmployeeDto(
  id: '83e1a9c8-11ec-4f8b-8a92-3f22782b4f9f',
  name: 'name',
  employeeType: 'employeeType',
  company: clockCompanyDtoMock,
  cpf: 'cpf',
  arpId: 'arpId',
  registrationNumber: 'registrationNumber',
  mail: 'mail',
  nfcCode: 'nfcCode',
  faceRegistered: null,
  employeeCode: '123456789',
);

EmployeeDto employeeMockDto = EmployeeDto(
  id: '83e1a9c8-11ec-4f8b-8a92-3f22782b4f9f',
  name: 'name',
  employeeType: 'employeeType',
  company: companyDtoMock,
  cpfNumber: 'cpf',
  arpId: 'arpId',
  registrationNumber: 'registrationNumber',
  mail: 'mail',
  nfcCode: 'nfcCode',
  faceRegistered: '83e1a9c811ec4f8b8a923f22782b4f9f',
  employeeCode: '123456789',
  managers: [managerDtoMock],
);

EmployeeDto employeeMockDto2 = EmployeeDto(
  id: '2',
  name: 'name other employee',
  employeeType: 'employeeType',
  company: companyDtoMock,
  cpfNumber: 'cpf',
  arpId: 'arpId',
  registrationNumber: 'registrationNumber',
  mail: 'mail',
  nfcCode: 'nfcCode',
  faceRegistered: '83e1a9c811ec4f8b8a923f22782b4f9f',
  employeeCode: '123456789',
  managers: [managerDtoMock],
);

EmployeeDto employeeNoFaceMockDto = EmployeeDto(
  id: '83e1a9c8-11ec-4f8b-8a92-3f22782b4f9f',
  name: 'name',
  employeeType: 'employeeType',
  company: companyDtoMock,
  cpfNumber: 'cpf',
  arpId: 'arpId',
  registrationNumber: 'registrationNumber',
  mail: 'mail',
  nfcCode: 'nfcCode',
  faceRegistered: null,
  employeeCode: '123456789',
);
