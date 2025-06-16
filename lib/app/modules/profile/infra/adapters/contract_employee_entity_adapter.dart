import '../../domain/entities/contract_employee_entity.dart';
import '../models/contract_employee_model.dart';
import 'address_entity_adapter.dart';
import 'employer_entity_adapter.dart';
import 'salary_entity_adapter.dart';

class ContractEmployeeEntityAdapter {
  ContractEmployeeEntity fromModel({
    required ContractEmployeeModel contractEmployeeModel,
  }) {
    return ContractEmployeeEntity(
      situation: contractEmployeeModel.situation,
      employeeType: contractEmployeeModel.employeeType,
      relationshipType: contractEmployeeModel.relationshipType,
      leaveReason: contractEmployeeModel.leaveReason,
      leaveEstimatedEndDate: contractEmployeeModel.leaveEstimatedEndDate,
      hireDate: contractEmployeeModel.hireDate,
      registerNumber: contractEmployeeModel.registerNumber,
      registrationNumber: contractEmployeeModel.registrationNumber,
      companyNumber: contractEmployeeModel.companyNumber,
      stabilityReason: contractEmployeeModel.stabilityReason,
      stabilityEndDate: contractEmployeeModel.stabilityEndDate,
      jobPositionName: contractEmployeeModel.jobPositionName,
      cboCode: contractEmployeeModel.cboCode,
      departmentName: contractEmployeeModel.departmentName,
      costCenterName: contractEmployeeModel.costCenterName,
      workshiftName: contractEmployeeModel.workshiftName,
      employmentRelationship: contractEmployeeModel.employmentRelationship,
      workstationName: contractEmployeeModel.workstationName,
      employeeAddress: contractEmployeeModel.employeeAddress != null
          ? AddressEntityAdapter().fromModel(
              addressModel: contractEmployeeModel.employeeAddress!,
            )
          : null,
      employer: contractEmployeeModel.employer != null
          ? EmployerEntityAdapter().fromModel(
              employerModel: contractEmployeeModel.employer!,
            )
          : null,
      salary: contractEmployeeModel.salary != null
          ? SalaryEntityAdapter().fromModel(
              salaryModel: contractEmployeeModel.salary!,
            )
          : null,
    );
  }
}
