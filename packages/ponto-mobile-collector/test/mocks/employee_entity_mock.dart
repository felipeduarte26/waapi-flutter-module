import 'package:ponto_mobile_collector/app/collector/core/domain/entities/company.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/employee.dart';

import 'manager_employee_entity_mock.dart';
import 'platform_user_entity_mock.dart';

Employee employeeEntityMock = Employee(
  id: '83e1a9c8-11ec-4f8b-8a92-3f22782b4f9f',
  name: 'name',
  employeeType: 'employeeType',
  company: companyEntityMock,
  cpf: 'cpf',
  arpId: 'arpId',
  registrationNumber: 'registrationNumber',
  mail: 'mail',
  nfcCode: 'nfcCode',
  faceRegistered: '83e1a9c811ec4f8b8a923f22782b4f9f',
  employeeCode: '123456789',
  managerEmployees: [managerEntityMock],
);

Company companyEntityMock = const Company(
  name: 'name',
  cnpj: 'identifier',
  timeZone: 'timeZone',
  arpId: 'arpId',
  caepf: 'caepf',
  cnoNumber: 'cnoNumber',
  id: 'id',
);

Employee employeeEntityMockNoFaceRegistered = Employee(
  id: '83e1a9c8-11ec-4f8b-8a92-3f22782b4f9f',
  name: 'name',
  employeeType: 'employeeType',
  company: companyEntityMock,
  cpf: 'cpf',
  arpId: 'arpId',
  registrationNumber: 'registrationNumber',
  mail: 'mail',
  nfcCode: 'nfcCode',
  faceRegistered: null,
  employeeCode: '123456789',
);


Employee employeeWithManagersAndPlatformUsersMock =
    Employee(
  id: '83e1a9c8-11ec-4f8b-8a92-3f22782b4f9f',
  name: 'name',
  employeeType: 'employeeType',
  company: companyEntityMock,
  cpf: 'cpf',
  arpId: 'arpId',
  registrationNumber: 'registrationNumber',
  mail: 'mail',
  nfcCode: 'nfcCode',
  faceRegistered: '83e1a9c811ec4f8b8a923f22782b4f9f',
  employeeCode: '123456789',
  managerEmployees: [
    managerEntityMock,
  ],
  platformUsers: [
    platformUserMock,
  ],
);
