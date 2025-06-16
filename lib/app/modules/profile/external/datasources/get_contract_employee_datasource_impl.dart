import '../../../../core/services/rest_client/rest_service.dart';
import '../../infra/datasources/get_contract_employee_datasource.dart';
import '../../infra/models/contract_employee_model.dart';
import '../mappers/contract_employee_model_mapper.dart';

class GetContractEmployeeDatasourceImpl implements GetContractEmployeeDatasource {
  final RestService _restService;
  final ContractEmployeeModelMapper _contractEmployeeModelMapper;

  const GetContractEmployeeDatasourceImpl({
    required RestService restService,
    required ContractEmployeeModelMapper contractEmployeeModelMapper,
  })  : _restService = restService,
        _contractEmployeeModelMapper = contractEmployeeModelMapper;

  @override
  Future<ContractEmployeeModel> call({
    required String employeeId,
  }) async {
    final contractPath = '/employee/work-contract-situation/$employeeId';
    final contractEmployeeResponse = await _restService.legacyManagementPanelService().get(contractPath);

    return _contractEmployeeModelMapper.fromJson(
      contractEmployeeJson: contractEmployeeResponse.data!,
    );
  }
}
