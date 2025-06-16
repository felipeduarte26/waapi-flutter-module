import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/domain/input_model/synchronization_result.dart';
import '../../../../../core/infra/utils/enum/synchronization_enum.dart';
import '../../../domain/usecase/synchronize_clocking_event_usecase.dart';
import 'synchronize_clocking_event_event.dart';
import 'synchronize_clocking_event_state.dart';

class SynchronizeClockingEventBloc
    extends Bloc<SyncClockingEventEvent, SyncClockingEventState> {
  final ISynchronizeClockingEventUsecase _synchronizeClockingEventUsecase;

  SynchronizeClockingEventBloc(
    this._synchronizeClockingEventUsecase,
  ) : super(SyncClockingEventInitial()) {
    on<SyncClockingEventStarted>((event, emit) async {
      emit(SyncClockingEventSyncInProgress());

      SynchronizationResult synchronizationResult =
          await _synchronizeClockingEventUsecase.call();

      if (synchronizationResult.status == SynchronizationStatus.error || synchronizationResult.status == SynchronizationStatus.warning) {
        emit(SyncClockingEventSyncFailure(synchronizationResult: synchronizationResult));
      } else if (synchronizationResult.status == SynchronizationStatus.success) {
        emit(SyncClockingEventSyncSuccess(synchronizationResult: synchronizationResult));
      } else {
        throw Exception('Status ${synchronizationResult.status} não tratado.');
      }
    });
  }
}
