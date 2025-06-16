import '../repositories/get_has_clocking_repository.dart';
import '../types/has_clocking_domain_types.dart';

abstract class GetHasClockingUsecase {
  GetHasClockingCallback call();
}

class GetHasClockingUsecaseImpl implements GetHasClockingUsecase {
  final GetHasClockingRepository _getHasClockingRepository;

  const GetHasClockingUsecaseImpl({
    required GetHasClockingRepository getHasClockingRepository,
  }) : _getHasClockingRepository = getHasClockingRepository;

  @override
  GetHasClockingCallback call() {
    return _getHasClockingRepository.call();
  }
}
