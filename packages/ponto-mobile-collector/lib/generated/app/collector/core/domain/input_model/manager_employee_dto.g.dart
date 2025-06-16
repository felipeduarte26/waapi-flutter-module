// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../../../app/collector/core/domain/input_model/manager_employee_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ManagerEmployeeDto _$ManagerEmployeeDtoFromJson(Map<String, dynamic> json) =>
    ManagerEmployeeDto(
      id: json['id'] as String?,
      mail: json['mail'] as String?,
      platformUsers: (json['platformUsers'] as List<dynamic>?)
          ?.map((e) => PlatformUserDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      platformUserName: json['platformUserName'] as String?,
      employees: (json['employees'] as List<dynamic>?)
          ?.map((e) => EmployeeDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ManagerEmployeeDtoToJson(ManagerEmployeeDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'mail': instance.mail,
      'platformUsers': instance.platformUsers,
      'platformUserName': instance.platformUserName,
      'employees': instance.employees,
    };
