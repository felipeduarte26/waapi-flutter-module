
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/multi_employee_sync.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/operation_mode_type.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/configuration_dto.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/employee_dto.dart';

import 'clock_company_dto_mock.dart';

MultiEmployeeSync multiEmployeeSyncMock = MultiEmployeeSync(
  employee: EmployeeDto(
    id: '1',
    name: 'John Doe',
    cpfNumber: '99999999999',
    employeeType: 'employeeType',
    arpId: 'arpId',
    enabled: true,
    mail: 'mail@email.com.br',
    nfcCode: 'nfcCode',
    company: companyDtoMock,
  ),
  configuration: ConfigurationDto(
    onlyOnline: true,
    operationMode: OperationModeType.single,
    timezone: 'America/Sao_Paulo',
    takePhoto: true,
  ),
);
