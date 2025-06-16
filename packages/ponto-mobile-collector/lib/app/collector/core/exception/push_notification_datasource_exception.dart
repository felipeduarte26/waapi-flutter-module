class PushNotificationException implements Exception {
  final Object? exception;
  final StackTrace stackTrace;

  PushNotificationException({
    required this.exception,
    StackTrace? stackTrace,
  }) : stackTrace = stackTrace ?? StackTrace.current;
}
