import '../../enums/analytics/analytics_user_property_enum.dart';

/// This interface describe all the methods that are needed to generate error logging.
abstract class ErrorLoggingService<T> {
  /// Returns the instance of the error logging tool.
  T get instance;

  /// Register the necessary configuration need to the error logging.
  Future<void> registerCrashLogging();

  /// Include a log message. This message will be appended into the error when it is called.
  void appendLogMessage({
    required String message,
  });

  /// Include a detailed error to the log.
  void recordError({
    dynamic exception,
    StackTrace? stackTrace,
  });

  /// Set the user identifier to help in the error identification.
  void setUserIdentifier({
    required String identifier,
  });

  /// Set a custom key with a value to help in the error identification.
  void setCustomKey({
    required AnalyticsUserPropertyEnum key,
    required Object value,
  });
}
