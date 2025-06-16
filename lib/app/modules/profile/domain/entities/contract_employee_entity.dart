import 'package:equatable/equatable.dart';

import '../../enums/employee_situation_enum.dart';
import '../../enums/employment_relationship_enum.dart';
import '../../enums/relationship_type_enum.dart';
import '../../enums/stability_type_enum.dart';
import 'address_entity.dart';
import 'employer_entity.dart';
import 'salary_entity.dart';

class ContractEmployeeEntity extends Equatable {
  final EmployeeSituationEnum? situation;
  final String? employeeType;
  final RelationshipTypeEnum? relationshipType;
  final String? leaveReason;
  final DateTime? leaveEstimatedEndDate;
  final DateTime? hireDate;
  final String? registerNumber;
  final int? registrationNumber;
  final int? companyNumber;
  final StabilityTypeEnum? stabilityReason;
  final DateTime? stabilityEndDate;
  final String? jobPositionName;
  final String? cboCode;
  final String? departmentName;
  final String? costCenterName;
  final String? workshiftName;
  final EmploymentRelationshipEnum? employmentRelationship;
  final String? workstationName;
  final AddressEntity? employeeAddress;
  final EmployerEntity? employer;
  final SalaryEntity? salary;

  const ContractEmployeeEntity({
    this.situation,
    this.employeeType,
    this.relationshipType,
    this.leaveReason,
    this.leaveEstimatedEndDate,
    this.hireDate,
    this.registerNumber,
    this.registrationNumber,
    this.companyNumber,
    this.stabilityReason,
    this.stabilityEndDate,
    this.jobPositionName,
    this.cboCode,
    this.departmentName,
    this.costCenterName,
    this.workshiftName,
    this.employmentRelationship,
    this.workstationName,
    this.employeeAddress,
    this.employer,
    this.salary,
  });

  @override
  List<Object?> get props {
    return [
      situation,
      employeeType,
      relationshipType,
      leaveReason,
      leaveEstimatedEndDate,
      hireDate,
      registerNumber,
      registrationNumber,
      companyNumber,
      stabilityReason,
      stabilityEndDate,
      jobPositionName,
      cboCode,
      departmentName,
      costCenterName,
      workshiftName,
      employmentRelationship,
      workstationName,
      employeeAddress,
      employer,
      salary,
    ];
  }
}
