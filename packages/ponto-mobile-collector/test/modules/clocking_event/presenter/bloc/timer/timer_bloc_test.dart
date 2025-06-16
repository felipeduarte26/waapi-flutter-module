import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/domain/usecase/get_clock_observable_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/domain/usecase/get_clock_time_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/domain/usecase/get_lifecycle_stream_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/domain/usecase/init_clock_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/presenter/bloc/timer/timer_state.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';

class MockGetLifecycleStreamUsecase extends Mock
    implements GetLifecycleStreamUsecase {}

class MockGetClockDateTimeUsecase extends Mock
    implements IGetClockDateTimeUsecase {}

class MockGetClockObservableUsecase extends Mock
    implements IGetClockObservableUsecase {}

class MockInitClockUsecase extends Mock implements IInitClockUsecase {}

void main() {
  late IGetLifecycleStreamUsecase getLifecycleStreamUsecase;
  late IGetClockDateTimeUsecase getClockDateTimeUsecase;
  late IGetClockObservableUsecase getClockObservableUsecase;
  late IInitClockUsecase initClockUsecase;

  late StreamController<AppLifecycleState> stateStreamController;
  final DateTime time = DateTime.parse('2023-05-11 14:30:00');
  late Observable observable;

  setUp(
    () {
      stateStreamController = StreamController<AppLifecycleState>();
      getLifecycleStreamUsecase = MockGetLifecycleStreamUsecase();
      getClockDateTimeUsecase = MockGetClockDateTimeUsecase();
      getClockObservableUsecase = MockGetClockObservableUsecase();
      initClockUsecase = MockInitClockUsecase();
      observable = Observable();

      when(
        () => getClockObservableUsecase.call(),
      ).thenReturn(observable);

      when(
        () => getClockDateTimeUsecase.call(),
      ).thenReturn(
        time,
      );

      when(
        () => initClockUsecase.call(),
      ).thenAnswer(
        (invocation) => Future.value(),
      );

      when(
        () => getLifecycleStreamUsecase.call(),
      ).thenAnswer(
        (invocation) => stateStreamController.stream,
      );
    },
  );

  tearDown(
    () {
      stateStreamController.close();
    },
  );

  group(
    'TimerBloc',
    () {
      blocTest(
        'on TimerNewDateEvent test',
        build: () => TimerBloc.getInstance(
          getLifecycleStreamUsecase,
          getClockDateTimeUsecase,
          getClockObservableUsecase,
          initClockUsecase,
          newInstance: true,
        ),
        act: (bloc) => bloc.add(TimerNewDateEvent(dateTime: DateTime.now())),
        expect: () => [
          isA<TimerClockState>(),
          isA<TimerClockState>(),
        ],
        verify: (bloc) {
          verify(
            () => getClockDateTimeUsecase.call(),
          ).called(2);
          verify(
            () => getClockObservableUsecase.call(),
          ).called(2);
          verify(
            () => getLifecycleStreamUsecase.call(),
          ).called(1);
          verifyNoMoreInteractions(getClockDateTimeUsecase);
          verifyNoMoreInteractions(getClockObservableUsecase);
          verifyNoMoreInteractions(getLifecycleStreamUsecase);
          verifyZeroInteractions(initClockUsecase);
        },
      );

      blocTest(
        'on TimerUpdateEvent test',
        build: () => TimerBloc.getInstance(
          getLifecycleStreamUsecase,
          getClockDateTimeUsecase,
          getClockObservableUsecase,
          initClockUsecase,
          newInstance: true,
        ),
        act: (bloc) => bloc.add(TimerUpdateEvent()),
        expect: () => [
          isA<TimerClockState>(),
          isA<TimerUpdatingState>(),
          isA<TimerUpdatedState>(),
        ],
        verify: (bloc) {
          verify(
            () => getClockDateTimeUsecase.call(),
          ).called(3);
          verify(
            () => initClockUsecase.call(),
          ).called(1);
          verify(
            () => getClockObservableUsecase.call(),
          ).called(2);
          verify(
            () => getLifecycleStreamUsecase.call(),
          ).called(1);

          verifyNoMoreInteractions(getClockDateTimeUsecase);
          verifyNoMoreInteractions(initClockUsecase);
          verifyNoMoreInteractions(getClockObservableUsecase);
          verifyNoMoreInteractions(getLifecycleStreamUsecase);
        },
      );

      test(
        'getDateTimeFunction test',
        () async {
          TimerBloc timerBloc = TimerBloc.getInstance(
            getLifecycleStreamUsecase,
            getClockDateTimeUsecase,
            getClockObservableUsecase,
            initClockUsecase,
            newInstance: true,
          );

          observable.notifyListeners(value: time);
          await Future.delayed(const Duration(milliseconds: 100));

          expect(timerBloc.lastDateTime, time);
          expect(timerBloc.state, isA<TimerClockState>());
        },
      );

      test(
        'listener LifecycleStream test',
        () async {
          TimerBloc timerBloc = TimerBloc.getInstance(
            getLifecycleStreamUsecase,
            getClockDateTimeUsecase,
            getClockObservableUsecase,
            initClockUsecase,
            newInstance: false,
          );

          timerBloc = TimerBloc.getInstance(
            getLifecycleStreamUsecase,
            getClockDateTimeUsecase,
            getClockObservableUsecase,
            initClockUsecase,
            newInstance: true,
          );

          timerBloc.updateTimerOnResume = true;
          stateStreamController.add(AppLifecycleState.resumed);
          await Future.delayed(const Duration(milliseconds: 100));

          expect(timerBloc.lastDateTime, time);
          expect(timerBloc.state, isA<TimerUpdatedState>());
        },
      );
    },
  );
}
