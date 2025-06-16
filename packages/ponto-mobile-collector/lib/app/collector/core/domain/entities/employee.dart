import 'package:equatable/equatable.dart';

import 'company.dart';
import 'configuration.dart';
import 'fence.dart';
import 'manager_employee.dart';
import 'platform_user.dart';
import 'reminder.dart';

class Employee extends Equatable {
  final String id;
  final String? name;
  final String? mail;
  final String employeeType;
  final String? nfcCode;
  final String? registrationNumber;
  final String cpf;
  final String? pis;
  final String? arpId;
  final bool? enable;
  final String? faceRegistered;
  final String? employeeCode;
  final Company company;
  final List<Fence>? fences;
  final List<Reminder>? reminders;
  final List<PlatformUser>? platformUsers;
  final List<ManagerEmployee>? managerEmployees;
  final Configuration? configuration;
  

  const Employee({
    required this.id,
    required this.employeeType,
    required this.cpf,
    this.pis,
    this.arpId,
    this.enable,
    this.mail,
    this.name,
    this.nfcCode,
    this.registrationNumber,
    this.faceRegistered,
    this.employeeCode,
    required this.company,
    this.fences,
    this.reminders,
    this.platformUsers,
    this.managerEmployees,
    this.configuration,
  });

  Employee copyWith({
    String? id,
    String? name,
    String? mail,
    String? employeeType,
    String? nfcCode,
    String? registrationNumber,
    String? cpf,
    String? pis,
    String? arpId,
    bool? enable,
    String? faceRegistered,
    String? employeeCode,
    Company? company,
    List<Fence>? fences,
    List<PlatformUser>? platformUsers,
    List<ManagerEmployee>? managerEmployees,
    Configuration? configuration,
  }) {
    return Employee(
      id: id ?? this.id,
      name: name ?? this.name,
      mail: mail ?? this.mail,
      cpf: cpf ?? this.cpf,
      pis: pis ?? this.pis,
      employeeType: employeeType ?? this.employeeType,
      nfcCode: nfcCode ?? this.nfcCode,
      registrationNumber: registrationNumber ?? this.registrationNumber,
      arpId: arpId ?? this.arpId,
      enable: enable ?? this.enable,
      faceRegistered: faceRegistered ?? this.faceRegistered,
      employeeCode: employeeCode ?? this.employeeCode,
      company: company ?? this.company,
      fences: fences ?? this.fences,
      platformUsers: platformUsers ?? this.platformUsers,
      managerEmployees: managerEmployees ?? this.managerEmployees,
      configuration: configuration ?? this.configuration,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        mail,
        employeeType,
        nfcCode,
        registrationNumber,
        cpf,
        pis,
        arpId,
        enable,
        faceRegistered,
        employeeCode,
        company,
        fences,
        platformUsers,
        managerEmployees,
        configuration,
      ];
}
