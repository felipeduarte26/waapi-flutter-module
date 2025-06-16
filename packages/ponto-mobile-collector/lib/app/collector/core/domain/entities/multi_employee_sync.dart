import '../../external/mappers/reminder_mapper.dart';
import '../enums/operation_mode_type.dart';
import '../input_model/company_dto.dart';
import '../input_model/configuration_dto.dart';
import '../input_model/employee_dto.dart';
import '../input_model/fence_dto.dart';
import '../input_model/manager_employee_dto.dart';
import '../input_model/platform_user_dto.dart';

class MultiEmployeeSync {
  final ConfigurationDto configuration;
  final EmployeeDto employee;

  MultiEmployeeSync({
    required this.configuration,
    required this.employee,
  });

  static MultiEmployeeSync fromJson(Map<String, dynamic> json) {
    List<FenceDto> fences = [];
    List<ManagerEmployeeDto> managers = [];
    List<PlatformUserDto> platformUsers = [];

    if (json['loginEmployee']['fences'].isNotEmpty) {
      List<dynamic> fencesData = json['loginEmployee']['fences'];
      fences = fencesData.map((e) => FenceDto.fromJson(e)).toList();
    }

    if (json['loginEmployee']['managers'] != null &&
        json['loginEmployee']['managers'].isNotEmpty) {
      List<dynamic> managersData = json['loginEmployee']['managers'];
      managers =
          managersData.map((e) => ManagerEmployeeDto.fromJson(e)).toList();
    }
    if (json['loginEmployee']['platformUsers'] != null &&
        json['loginEmployee']['platformUsers'].isNotEmpty) {
      List<dynamic> platformUsersData = json['loginEmployee']['platformUsers'];
      platformUsers =
          platformUsersData.map((e) => PlatformUserDto.fromJson(e)).toList();
    }

    return MultiEmployeeSync(
      configuration: ConfigurationDto(
        onlyOnline: json['loginConfiguration']['onlyOnline'] ?? false,
        operationMode: OperationModeType.build(
          json['loginConfiguration']['operationMode'],
        ),
        takePhoto: json['loginConfiguration']['takePhoto'] ?? false,
        timezone: json['loginConfiguration']['timezone'],
        allowChangeTime: json['loginConfiguration']['allowChangeTime'] ?? false,
        faceRecognition: json['loginConfiguration']['faceRecognition'] ?? false,
        managerId: json['loginConfiguration']['managerId'],
        isManager: json['loginConfiguration']['isManager'],
      ),
      employee: EmployeeDto(
        id: json['loginEmployee']['id'],
        name: json['loginEmployee']['name'],
        cpfNumber: json['loginEmployee']['cpfNumber'],
        mail: json['loginEmployee']['mail'],
        employeeCode: json['loginEmployee']['employeeCode'],
        fences: fences,
        managers: managers,
        platformUsers: platformUsers,
        nfcCode: json['loginEmployee']['nfcCode'],
        employeeType: json['loginEmployee']['employeeType'],
        registrationNumber: json['loginEmployee']['registrationNumber'],
        enabled: json['loginEmployee']['enabled'],
        faceRegistered: json['loginEmployee']['faceRegistered'],
        company: CompanyDto(
          id: json['loginEmployee']['company']['id'],
          identifier: json['loginEmployee']['company']['cnpj'],
          cnpj: json['loginEmployee']['company']['cnpj'],
          name: json['loginEmployee']['company']['name'],
          timeZone: json['loginEmployee']['company']['timeZone'],
          arpId: json['loginEmployee']['company']['arpId'],
          caepf: json['loginEmployee']['company']['caepf'],
          cnoNumber: json['loginEmployee']['company']['cnoNumber'],
        ),
        reminders: ReminderMapper.fromJsonToCollectorDtoList(
          json['loginEmployee']['reminders'],
          json['loginEmployee']['id'],
        ),
      ),
    );
  }
}
