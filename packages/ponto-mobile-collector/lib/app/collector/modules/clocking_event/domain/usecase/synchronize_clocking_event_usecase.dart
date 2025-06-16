import '../../../../core/domain/input_model/synchronization_result.dart';
import '../service/isynchronize_clocking_event_service.dart';

abstract class ISynchronizeClockingEventUsecase {
  Future<SynchronizationResult> call();
}

class SynchronizeClockingEventUsecase
    implements ISynchronizeClockingEventUsecase {
  final ISynchronizeClockingEventService _synchronizeClockingEventService;

  const SynchronizeClockingEventUsecase({
    required ISynchronizeClockingEventService synchronizeClockingEventService,
  }) : _synchronizeClockingEventService = synchronizeClockingEventService;

  @override
  Future<SynchronizationResult> call() {
    return _synchronizeClockingEventService.startSynchronize();
  }

}
