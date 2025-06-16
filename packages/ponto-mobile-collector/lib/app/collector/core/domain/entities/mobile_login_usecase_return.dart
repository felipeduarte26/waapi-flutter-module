import '../input_model/activation_dto.dart';
import '../input_model/configuration_dto.dart';
import '../input_model/employee_dto.dart';
import '../input_model/hlb_time_dto.dart';

class MobileLoginUsecaseReturn {
  EmployeeDto? employeeLocal;
  HlbTimeDto? hlbTimeLocal;
  ActivationDto? activationLocal;
  ConfigurationDto? configurationLocal;
  late bool noInternetConnection;
  late bool noUsername;
  bool success = false;

  MobileLoginUsecaseReturn({
    this.employeeLocal,
    this.hlbTimeLocal,
    this.activationLocal,
    this.configurationLocal,
    this.noInternetConnection = false,
    this.noUsername = false,
    this.success = false,
  });
}
