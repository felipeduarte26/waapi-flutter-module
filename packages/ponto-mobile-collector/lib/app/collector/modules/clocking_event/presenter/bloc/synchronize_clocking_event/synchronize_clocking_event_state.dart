import '../../../../../core/domain/input_model/synchronization_result.dart';

abstract class SyncClockingEventState {}

class SyncClockingEventInitial extends SyncClockingEventState {}

class SyncClockingEventSyncInProgress extends SyncClockingEventState {}

class SyncClockingEventSyncSuccess extends SyncClockingEventState {
  final SynchronizationResult synchronizationResult;

  SyncClockingEventSyncSuccess({required this.synchronizationResult});
}

class SyncClockingEventSyncFailure extends SyncClockingEventState {
  final SynchronizationResult synchronizationResult;

  SyncClockingEventSyncFailure({required this.synchronizationResult});
}
