import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../domain/usecase/get_clock_observable_usecase.dart';
import '../../../domain/usecase/get_clock_time_usecase.dart';
import '../../../domain/usecase/get_lifecycle_stream_usecase.dart';
import '../../../domain/usecase/init_clock_usecase.dart';
import 'timer_event.dart';
import 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  final IGetLifecycleStreamUsecase _getLifecycleStreamUsecase;
  final IGetClockDateTimeUsecase _getClockDateTimeUsecase;
  final IGetClockObservableUsecase _getClockObservableUsecase;
  final IInitClockUsecase _initClockUsecase;

  bool _sendTime = true;
  late DateTime lastDateTime;
  late Function getDateTimeFunction;
  bool updateTimerOnResume = false;

  static TimerBloc? _instance;

  static TimerBloc getInstance(
    final IGetLifecycleStreamUsecase getLifecycleStreamUsecase,
    final IGetClockDateTimeUsecase getClockDateTimeUsecase,
    final IGetClockObservableUsecase getClockObservableUsecase,
    final IInitClockUsecase initClockUsecase, {
    final bool newInstance = false,
  }) {
    if (newInstance) {
      _instance = TimerBloc._(
        getLifecycleStreamUsecase,
        getClockDateTimeUsecase,
        getClockObservableUsecase,
        initClockUsecase,
      );
    } else {
      _instance ??= TimerBloc._(
        getLifecycleStreamUsecase,
        getClockDateTimeUsecase,
        getClockObservableUsecase,
        initClockUsecase,
      );
    }

    return _instance!;
  }

  /// Initialize Timer to query date in lib
  TimerBloc._(
    this._getLifecycleStreamUsecase,
    this._getClockDateTimeUsecase,
    this._getClockObservableUsecase,
    this._initClockUsecase,
  ) : super(TimerInitializingState()) {
    lastDateTime = _getClockDateTimeUsecase.call();

    // Update function
    getDateTimeFunction = ((DateTime dateTime) {
      if (_sendTime) {
        add(TimerNewDateEvent(dateTime: dateTime));
      }
    });

    // Register time update function
    _getClockObservableUsecase.call().removeListener(getDateTimeFunction);
    _getClockObservableUsecase.call().addListener(getDateTimeFunction);

    // Listen for application state change to update time
    _getLifecycleStreamUsecase.call().listen(
      (event) {
        if (event == AppLifecycleState.paused) {
          updateTimerOnResume = true;
        }

        if (updateTimerOnResume && event == AppLifecycleState.resumed) {
          updateTimerOnResume = false;
          add(TimerUpdateEvent());
        }
      },
    );

    on<TimerNewDateEvent>(
      (event, emit) {
        lastDateTime = event.dateTime;
        emit(TimerClockState(dateTime: event.dateTime));
      },
    );

    on<TimerUpdateEvent>(
      (event, emit) async {
        if (state is! TimerUpdatingState) {
          _sendTime = false;
          emit(TimerUpdatingState());
          await _initClockUsecase.call();
          emit(TimerUpdatedState(dateTime: _getClockDateTimeUsecase.call()));
          _sendTime = true;
        }
      },
    );

    add(
      TimerNewDateEvent(dateTime: _getClockDateTimeUsecase.call()),
    );
  }
}
