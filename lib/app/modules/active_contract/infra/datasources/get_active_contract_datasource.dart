import '../models/active_contract_model.dart';

abstract class GetActiveContractDatasource {
  Future<ActiveContractModel?> call();
}
