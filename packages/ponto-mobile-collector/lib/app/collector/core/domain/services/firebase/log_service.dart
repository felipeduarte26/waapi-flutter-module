import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart';

abstract class LogService {
  /// Send logs to firebase.
  void sendManualCrashlyticsLog({
    required String local,
    required String method,
    dynamic exception,
    StackTrace? stackTrace,
    String? screen,
    bool fatalError = false,
  });

  /// Send logs to local database.
  void saveLocalLog({
    required dynamic exception,
    String? stackTrace,
    bool fatalError = false,
    ImportClockingEventDto? importClockingEvent,
    DateTime? dateTimeOnDevice,
  });
}
