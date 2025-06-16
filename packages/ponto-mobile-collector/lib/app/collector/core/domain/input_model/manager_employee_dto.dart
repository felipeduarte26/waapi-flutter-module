import 'package:json_annotation/json_annotation.dart';

import 'employee_dto.dart';
import 'platform_user_dto.dart';

part '../../../../../generated/app/collector/core/domain/input_model/manager_employee_dto.g.dart';

@JsonSerializable()
class ManagerEmployeeDto {
  final String? id;
  final String? mail;
  final List<PlatformUserDto>? platformUsers;
  final String? platformUserName;
  final List<EmployeeDto>? employees;

  ManagerEmployeeDto({
    this.id,
    this.mail,
    this.platformUsers,
    this.platformUserName,
    this.employees,
  });

  factory ManagerEmployeeDto.fromJson(Map<String, dynamic> json) =>
      _$ManagerEmployeeDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ManagerEmployeeDtoToJson(this);


}
