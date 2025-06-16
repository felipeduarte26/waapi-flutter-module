import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../domain/services/lifecycle/ilifecycle_service.dart';

class LifecycleService
    with WidgetsBindingObserver
    implements ILifecycleService {
  // Validation so that observer is not added more than once
  static bool addObserver = true;
  late AppLifecycleState lastState;
  final StreamController<AppLifecycleState> _stateStreamController =
      StreamController<AppLifecycleState>.broadcast();

  LifecycleService() {
    lastState = AppLifecycleState.resumed;

    if (addObserver) {
      WidgetsBinding.instance.addObserver(this);
      addObserver = false;
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    log('AppLifecycleState: ${state.name}');
    lastState = state;
    _stateStreamController.add(lastState);
  }

  @override
  AppLifecycleState getState() {
    return lastState;
  }

  @override
  Stream<AppLifecycleState> getStream() {
    return _stateStreamController.stream;
  }

  @override
  Future<void> dispose() async {
    WidgetsBinding.instance.removeObserver(this);
    _stateStreamController.close();
  }
}
