import '../repositories/get_disability_repository.dart';
import '../types/profile_domain_types.dart';

abstract class GetDisabilityUsecase {
  GetDisabilityUsecaseCallback call();
}

class GetDisabilityUsecaseImpl implements GetDisabilityUsecase {
  final GetDisabilityRepository _getDisabilityRepository;

  const GetDisabilityUsecaseImpl({
    required GetDisabilityRepository getDisabilityRepository,
  }) : _getDisabilityRepository = getDisabilityRepository;

  @override
  GetDisabilityUsecaseCallback call() {
    return _getDisabilityRepository.call();
  }
}
