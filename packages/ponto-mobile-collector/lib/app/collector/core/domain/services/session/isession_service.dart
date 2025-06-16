import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart'
    as clock;

import '../../../../../../ponto_mobile_collector.dart';
import '../../../infra/utils/enum/execution_mode_enum.dart';
import '../../input_model/activation_dto.dart';
import '../../input_model/configuration_dto.dart';
import '../../input_model/employee_dto.dart';

abstract class ISessionService {
  ConfigurationDto getConfiguration();
  EmployeeDto getEmployee();
  clock.OperationModeEnum getOperationMode();
  String getEmployeeId();
  ExecutionModeEnum getExecutionMode();
  DeviceAuthorizationStatusEnum checkDeviceStatus();
  void setLogedUser({
    EmployeeDto? employeeDto,
    ActivationDto? activationDto,
    required ConfigurationDto configurationDto,
    String? username,
  });
  String? getUserName();
  Duration? getTimeZoneOffset();
  bool hasEmployee();
  String getCompanyId();
  Future<void> clean();
  void setFaceRegistered({required String id});
}
