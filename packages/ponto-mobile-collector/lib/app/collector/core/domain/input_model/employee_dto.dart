

import 'package:json_annotation/json_annotation.dart';

import 'biometric_patterns.dart';
import 'company_dto.dart';
import 'fence_dto.dart';
import 'manager_employee_dto.dart';
import 'platform_user_dto.dart';
import 'reminder_dto.dart';

part '../../../../../generated/app/collector/core/domain/input_model/employee_dto.g.dart';

@JsonSerializable()
class EmployeeDto {
  final String id;
  final String name;
  final String? pis;
  final String cpfNumber;
  final String? mail;
  final CompanyDto company;
  final List<BiometricPatterns>? biometricPatterns;
  final String? nfcCode;
  final List<FenceDto>? fences;
  final String? employeeType;
  final String? registrationNumber;
  final String? arpId;
  final bool? enabled;
  late String? faceRegistered;
  final String? employeeCode;  
  final List<ManagerEmployeeDto>? managers;
  final List<PlatformUserDto>? platformUsers;
  final List<ReminderDto>? reminders;

  EmployeeDto({
    this.biometricPatterns,
    required this.company,
    required this.cpfNumber,
    this.employeeType,
    this.fences,
    required this.id,
    this.mail,
    required this.name,
    this.nfcCode,
    this.pis,
    this.registrationNumber,
    this.arpId,
    this.enabled,
    this.faceRegistered,
    this.employeeCode,    
    this.managers,
    this.platformUsers,
    this.reminders,
  });

  factory EmployeeDto.fromJson(Map<String, dynamic> json) =>
      _$EmployeeDtoFromJson(json);

  Map<String, dynamic>  toJson() => _$EmployeeDtoToJson(this);

}
