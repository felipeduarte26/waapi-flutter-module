import '../../../../core/types/either.dart';
import '../../domain/failures/profile_failure.dart';
import '../../domain/repositories/get_contract_employee_repository.dart';
import '../../domain/types/profile_domain_types.dart';
import '../adapters/contract_employee_entity_adapter.dart';
import '../datasources/get_contract_employee_datasource.dart';

class GetContractEmployeeRepositoryImpl implements GetContractEmployeeRepository {
  final GetContractEmployeeDatasource _getContractEmployeeDatasource;
  final ContractEmployeeEntityAdapter _contractEmployeeEntityAdapter;

  GetContractEmployeeRepositoryImpl({
    required GetContractEmployeeDatasource getContractEmployeeDatasource,
    required ContractEmployeeEntityAdapter contractEmployeeEntityAdapter,
  })  : _getContractEmployeeDatasource = getContractEmployeeDatasource,
        _contractEmployeeEntityAdapter = contractEmployeeEntityAdapter;

  @override
  GetContractEmployeeUsecaseCallback call({
    required String employeeId,
  }) async {
    try {
      final contractEmployeeModel = await _getContractEmployeeDatasource.call(
        employeeId: employeeId,
      );

      final contractEmployeeEntity = _contractEmployeeEntityAdapter.fromModel(
        contractEmployeeModel: contractEmployeeModel,
      );

      return right(contractEmployeeEntity);
    } catch (error) {
      return left(const ProfileDatasourceFailure());
    }
  }
}
