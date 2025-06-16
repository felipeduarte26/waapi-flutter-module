
import '../repositories/personalization_mobile_repository.dart';
import '../types/personalization_domain_types.dart';

abstract class GetPersonalizationMobileUsecase {
  GetPersonalizationMobileUsecaseCallback call();
}

class GetPersonalizationMobileUsecaseImpl implements GetPersonalizationMobileUsecase {
  final PersonalizationMobileRepository _personalizationMobileRepository;

  const GetPersonalizationMobileUsecaseImpl({
    required PersonalizationMobileRepository personalizationMobileRepository,
  }) : _personalizationMobileRepository = personalizationMobileRepository;

  @override
  GetPersonalizationMobileUsecaseCallback call() {
    return _personalizationMobileRepository.call();
  }
}
