import '../repositories/retrieve_all_reasons_happiness_index_repository.dart';
import '../types/happiness_index_domain_types.dart';

abstract class RetrieveAllReasonsHappinessIndexUsecase {
  RetrieveAllReasonsHappinessIndexUsecaseCallback call({
    required String language,
  });
}

class RetrieveAllReasonsHappinessIndexUsecaseImpl implements RetrieveAllReasonsHappinessIndexUsecase {
  final RetrieveAllReasonsHappinessIndexRepository _retrieveAllReasonsHappinessIndexRepository;

  const RetrieveAllReasonsHappinessIndexUsecaseImpl({
    required RetrieveAllReasonsHappinessIndexRepository retrieveAllReasonsHappinessIndexRepository,
  }) : _retrieveAllReasonsHappinessIndexRepository = retrieveAllReasonsHappinessIndexRepository;

  @override
  RetrieveAllReasonsHappinessIndexUsecaseCallback call({
    required String language,
  }) {
    return _retrieveAllReasonsHappinessIndexRepository.call(
      language: language,
    );
  }
}
