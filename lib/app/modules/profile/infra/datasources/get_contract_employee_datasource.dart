import '../models/contract_employee_model.dart';

abstract class GetContractEmployeeDatasource {
  Future<ContractEmployeeModel> call({
    required String employeeId,
  });
}
