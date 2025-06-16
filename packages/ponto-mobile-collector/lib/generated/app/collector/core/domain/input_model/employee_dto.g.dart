// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../../../app/collector/core/domain/input_model/employee_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeeDto _$EmployeeDtoFromJson(Map<String, dynamic> json) => EmployeeDto(
      biometricPatterns: (json['biometricPatterns'] as List<dynamic>?)
          ?.map((e) => BiometricPatterns.fromJson(e as Map<String, dynamic>))
          .toList(),
      company: CompanyDto.fromJson(json['company'] as Map<String, dynamic>),
      cpfNumber: json['cpfNumber'] as String,
      employeeType: json['employeeType'] as String?,
      fences: (json['fences'] as List<dynamic>?)
          ?.map((e) => FenceDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      id: json['id'] as String,
      mail: json['mail'] as String?,
      name: json['name'] as String,
      nfcCode: json['nfcCode'] as String?,
      pis: json['pis'] as String?,
      registrationNumber: json['registrationNumber'] as String?,
      arpId: json['arpId'] as String?,
      enabled: json['enabled'] as bool?,
      faceRegistered: json['faceRegistered'] as String?,
      employeeCode: json['employeeCode'] as String?,
      managers: (json['managers'] as List<dynamic>?)
          ?.map((e) => ManagerEmployeeDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      platformUsers: (json['platformUsers'] as List<dynamic>?)
          ?.map((e) => PlatformUserDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      reminders: (json['reminders'] as List<dynamic>?)
          ?.map((e) => ReminderDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EmployeeDtoToJson(EmployeeDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'pis': instance.pis,
      'cpfNumber': instance.cpfNumber,
      'mail': instance.mail,
      'company': instance.company,
      'biometricPatterns': instance.biometricPatterns,
      'nfcCode': instance.nfcCode,
      'fences': instance.fences,
      'employeeType': instance.employeeType,
      'registrationNumber': instance.registrationNumber,
      'arpId': instance.arpId,
      'enabled': instance.enabled,
      'faceRegistered': instance.faceRegistered,
      'employeeCode': instance.employeeCode,
      'managers': instance.managers,
      'platformUsers': instance.platformUsers,
      'reminders': instance.reminders,
    };
