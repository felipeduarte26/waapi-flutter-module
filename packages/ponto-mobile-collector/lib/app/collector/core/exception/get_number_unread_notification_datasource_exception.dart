class GetNumberUnreadNotificationsException implements Exception {
  final Object? exception;
  final StackTrace stackTrace;

  GetNumberUnreadNotificationsException({
    required this.exception,
    StackTrace? stackTrace,
  }) : stackTrace = stackTrace ?? StackTrace.current;
}
