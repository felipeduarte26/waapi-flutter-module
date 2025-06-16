import 'dart:convert';

import '../../../../core/helper/date_time_helper.dart';
import '../../../../core/helper/enum_helper.dart';
import '../../enums/employee_situation_enum.dart';
import '../../enums/employment_relationship_enum.dart';
import '../../enums/relationship_type_enum.dart';
import '../../enums/stability_type_enum.dart';
import '../../infra/models/contract_employee_model.dart';
import 'address_model_mapper.dart';
import 'employer_model_mapper.dart';
import 'salary_model_mapper.dart';

class ContractEmployeeModelMapper {
  final AddressModelMapper _addressModelMapper;
  final EmployerModelMapper _employerModelMapper;
  final SalaryModelMapper _salaryModelMapper;

  const ContractEmployeeModelMapper({
    required AddressModelMapper addressModelMapper,
    required EmployerModelMapper employerModelMapper,
    required SalaryModelMapper salaryModelMapper,
  })  : _addressModelMapper = addressModelMapper,
        _employerModelMapper = employerModelMapper,
        _salaryModelMapper = salaryModelMapper;

  ContractEmployeeModel fromMap({
    required Map<String, dynamic> map,
  }) {
    final Map<String, dynamic>? employeeMap = map['employee'];

    return ContractEmployeeModel(
      situation: employeeMap != null
          ? EnumHelper<EmployeeSituationEnum>().stringToEnum(
              stringToParse: employeeMap['situation'],
              values: EmployeeSituationEnum.values,
            )
          : null,
      employeeType: employeeMap != null ? employeeMap['employeeType'] : null,
      relationshipType: employeeMap != null
          ? EnumHelper<RelationshipTypeEnum>().stringToEnum(
              stringToParse: employeeMap['relationshipType'],
              values: RelationshipTypeEnum.values,
            )
          : null,
      leaveReason: employeeMap != null ? employeeMap['leaveReason'] : null,
      leaveEstimatedEndDate: employeeMap != null
          ? DateTimeHelper.convertStringAaaaMmDdToDateTime(
              stringToConvert: employeeMap['leaveEstimatedEndDate'],
            )
          : null,
      hireDate: employeeMap != null
          ? DateTimeHelper.convertStringAaaaMmDdToDateTime(
              stringToConvert: employeeMap['hireDate'],
            )
          : null,
      registerNumber: employeeMap != null ? employeeMap['registerNumber'] : null,
      registrationNumber: employeeMap != null ? int.tryParse(employeeMap['registrationNumber'].toString()) ?? 0 : null,
      companyNumber: employeeMap != null ? int.tryParse(employeeMap['companyNumber'].toString()) ?? 0 : null,
      stabilityReason: employeeMap != null
          ? EnumHelper<StabilityTypeEnum>().stringToEnum(
              stringToParse: employeeMap['stabilityReason'],
              values: StabilityTypeEnum.values,
            )
          : null,
      stabilityEndDate: employeeMap != null
          ? DateTimeHelper.convertStringAaaaMmDdToDateTime(
              stringToConvert: employeeMap['stabilityEndDate'],
            )
          : null,
      jobPositionName: employeeMap != null ? employeeMap['jobPositionName'] : null,
      cboCode: employeeMap != null ? employeeMap['CBOCode'] : null,
      departmentName: employeeMap != null ? employeeMap['departmentName'] : null,
      costCenterName: employeeMap != null ? employeeMap['costCenterName'] : null,
      workshiftName: employeeMap != null ? employeeMap['workshiftName'] : null,
      employmentRelationship: employeeMap != null
          ? EnumHelper<EmploymentRelationshipEnum>().stringToEnum(
              stringToParse: employeeMap['employmentRelationship'],
              values: EmploymentRelationshipEnum.values,
            )
          : null,
      workstationName: employeeMap != null ? employeeMap['workstationName'] : null,
      employeeAddress: employeeMap?['employeeAddress'] != null
          ? _addressModelMapper.fromMap(
              map: employeeMap?['employeeAddress'],
            )
          : null,
      employer: map['employer'] != null
          ? _employerModelMapper.fromMap(
              map: map['employer'],
            )
          : null,
      salary: map['salary'] != null
          ? _salaryModelMapper.fromMap(
              map: map['salary'],
            )
          : null,
    );
  }

  ContractEmployeeModel fromJson({
    required String contractEmployeeJson,
  }) {
    if (contractEmployeeJson.isEmpty) {
      return fromMap(
        map: {},
      );
    }

    return fromMap(
      map: jsonDecode(contractEmployeeJson),
    );
  }
}
