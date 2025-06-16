import '../../../../types/either.dart';

import '../../domain/failures/has_clocking_failure.dart';
import '../../domain/repositories/save_has_clocking_repository.dart';
import '../../domain/types/has_clocking_domain_types.dart';
import '../drivers/save_has_clocking_driver.dart';

class SaveHasClockingRepositoryImpl implements SaveHasClockingRepository {
  final SaveHasClockingDriver _saveHasClockingDriver;

  const SaveHasClockingRepositoryImpl({
    required SaveHasClockingDriver saveHasClockingDriver,
  }) : _saveHasClockingDriver = saveHasClockingDriver;

  @override
  SaveHasClockingCallback call({required bool? hasClocking}) async {
    try {
      await _saveHasClockingDriver.call(
        hasClocking: hasClocking,
      );
      return right(unit);
    } catch (error) {
      return left(const HasClockingDriverFailure());
    }
  }
}
