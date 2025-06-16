import 'dart:async';

import '../../../../core/domain/input_model/synchronization_result.dart';


abstract class ISynchronizeClockingEventService {

  Future<SynchronizationResult> startSynchronize();

  bool get synchronizationIsRunning;

  static late StreamController<SynchronizationResult> controller;

  static late Stream<SynchronizationResult> stream;

}
