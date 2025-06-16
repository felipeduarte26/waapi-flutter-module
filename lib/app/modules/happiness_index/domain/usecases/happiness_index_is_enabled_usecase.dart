import '../repositories/happiness_index_is_enabled_repository.dart';
import '../types/happiness_index_domain_types.dart';

abstract class HappinessIndexIsEnabledUsecase {
  HappinessIndexIsEnabledUsecaseCallback call();
}

class HappinessIndexIsEnabledUsecaseImpl implements HappinessIndexIsEnabledUsecase {
  final HappinessIndexIsEnabledRepository _happinessIndexIsEnabledRepository;

  const HappinessIndexIsEnabledUsecaseImpl({
    required HappinessIndexIsEnabledRepository happinessIndexIsEnabledRepository,
  }) : _happinessIndexIsEnabledRepository = happinessIndexIsEnabledRepository;

  @override
  HappinessIndexIsEnabledUsecaseCallback call() {
    return _happinessIndexIsEnabledRepository.call();
  }
}
