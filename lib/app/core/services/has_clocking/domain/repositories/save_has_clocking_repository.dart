import '../types/has_clocking_domain_types.dart';

abstract class SaveHasClockingRepository {
  SaveHasClockingCallback call({required bool? hasClocking});
}
