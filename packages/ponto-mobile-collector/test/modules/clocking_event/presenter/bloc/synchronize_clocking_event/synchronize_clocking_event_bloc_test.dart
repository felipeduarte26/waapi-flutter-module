import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/synchronization_result.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/synchronization_enum.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/domain/usecase/synchronize_clocking_event_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/presenter/bloc/synchronize_clocking_event/synchronize_clocking_event_bloc.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/presenter/bloc/synchronize_clocking_event/synchronize_clocking_event_event.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/presenter/bloc/synchronize_clocking_event/synchronize_clocking_event_state.dart';

class MockSynchronizeClockingEventUsecase extends Mock
    implements ISynchronizeClockingEventUsecase {}

void main() {
  late ISynchronizeClockingEventUsecase synchronizeClockingEventUsecase;

  setUp(
    () {
      synchronizeClockingEventUsecase = MockSynchronizeClockingEventUsecase();
    },
  );

  group('SynchronizeClockingEventBloc', () {
    blocTest(
      'on SyncClockingEventStarted returning error',
      setUp: () {
        when(
          () => synchronizeClockingEventUsecase.call(),
        ).thenAnswer(
          (invocation) => Future.value(
            SynchronizationResult(
              SynchronizationStatus.error,
              SynchronizationMessage.syncClockingEventSyncFailure,
            ),
          ),
        );
      },
      build: () =>
          SynchronizeClockingEventBloc(synchronizeClockingEventUsecase),
      act: (bloc) => bloc.add(SyncClockingEventStarted()),
      expect: () => [
        isA<SyncClockingEventSyncInProgress>(),
        isA<SyncClockingEventSyncFailure>(),
      ],
    );
  });

  group('SynchronizeClockingEventBloc', () {
    blocTest(
      'on SyncClockingEventStarted returning success',
      setUp: () {
        when(
          () => synchronizeClockingEventUsecase.call(),
        ).thenAnswer(
          (invocation) => Future.value(
            SynchronizationResult(
              SynchronizationStatus.success,
              SynchronizationMessage.syncClockingEventSyncSuccess,
            ),
          ),
        );
      },
      build: () =>
          SynchronizeClockingEventBloc(synchronizeClockingEventUsecase),
      act: (bloc) => bloc.add(SyncClockingEventStarted()),
      expect: () => [
        isA<SyncClockingEventSyncInProgress>(),
        isA<SyncClockingEventSyncSuccess>(),
      ],
    );
  });
}
