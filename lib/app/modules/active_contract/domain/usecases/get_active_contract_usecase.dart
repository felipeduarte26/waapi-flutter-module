import '../repositories/get_active_contract_repository.dart';
import '../types/active_contract_domain_types.dart';

abstract class GetActiveContractUsecase {
  GetActiveContractUsecaseCallback call();
}

class GetActiveContractUsecaseImpl implements GetActiveContractUsecase {
  final GetActiveContractRepository _getActiveContractRepository;

  const GetActiveContractUsecaseImpl({
    required GetActiveContractRepository getActiveContractRepository,
  }) : _getActiveContractRepository = getActiveContractRepository;

  @override
  GetActiveContractUsecaseCallback call() {
    return _getActiveContractRepository.call();
  }
}
