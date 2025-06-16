import '../repositories/save_has_clocking_repository.dart';
import '../types/has_clocking_domain_types.dart';

abstract class SaveHasClockingUsecase {
  SaveHasClockingCallback call({required bool? hasClocking});
}

class SaveHasClockingUsecaseImpl implements SaveHasClockingUsecase {
  final SaveHasClockingRepository _saveHasClockingRepository;

  const SaveHasClockingUsecaseImpl({
    required SaveHasClockingRepository saveHasClockingRepository,
  }) : _saveHasClockingRepository = saveHasClockingRepository;

  @override
  SaveHasClockingCallback call({required bool? hasClocking}) {
    return _saveHasClockingRepository.call(
      hasClocking: hasClocking,
    );
  }
}
