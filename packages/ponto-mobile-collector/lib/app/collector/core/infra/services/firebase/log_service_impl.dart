import 'dart:developer';

import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart';
import 'package:drift/isolate.dart';

import '../../../domain/services/firebase/log_service.dart';
import '../../../domain/services/shared_preferences/ishared_preferences_service.dart';
import '../../../domain/usecases/send_logs_usecase.dart';

class LogServiceImpl implements LogService {
  final SendLogsUsecase sendLogsUsecase;
  final ISharedPreferencesService sharedPreferencesService;
  LogServiceImpl({

    required this.sharedPreferencesService,
    required this.sendLogsUsecase,
  });

  @override
  void sendManualCrashlyticsLog({
    required String local,
    required String method,
    dynamic exception,
    StackTrace? stackTrace,
    String? screen,
    bool fatalError = false,
  }) {
    log(stackTrace.toString());
  }

  @override
  Future<void> saveLocalLog({
    required exception,
    String? stackTrace,
    bool fatalError = false,
    ImportClockingEventDto? importClockingEvent,
    DateTime? dateTimeOnDevice,
  }) async {
    try {
      bool send = await sharedPreferencesService.getSendCrashLog();

      if (send && exception is! DriftRemoteException) {
        sendLogsUsecase.call(
          exception: exception.toString(),
          stackTrace: stackTrace,
          importClockingEvent: importClockingEvent,
          dateTimeOnDevice: dateTimeOnDevice,
        );
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
