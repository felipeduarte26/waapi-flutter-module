import '../types/happiness_index_domain_types.dart';

abstract class RetrieveAllReasonsHappinessIndexRepository {
  RetrieveAllReasonsHappinessIndexUsecaseCallback call({
    required String language,
  });
}
