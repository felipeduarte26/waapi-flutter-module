import '../repositories/personalization_repository.dart';
import '../types/personalization_domain_types.dart';

abstract class GetPersonalizationUsecase {
  GetPersonalizationUsecaseCallback call();
}

class GetPersonalizationUsecaseImpl implements GetPersonalizationUsecase {
  final PersonalizationRepository _personalizationRepository;

  const GetPersonalizationUsecaseImpl({
    required PersonalizationRepository personalizationRepository,
  }) : _personalizationRepository = personalizationRepository;

  @override
  GetPersonalizationUsecaseCallback call() {
    return _personalizationRepository.call();
  }
}
