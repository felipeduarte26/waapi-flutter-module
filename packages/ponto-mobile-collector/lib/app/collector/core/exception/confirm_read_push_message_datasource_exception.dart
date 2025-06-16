class ConfirmReadPushMessageDataSourceException implements Exception {
  final Object? exception;
  final StackTrace stackTrace;

  ConfirmReadPushMessageDataSourceException({
    required this.exception,
    StackTrace? stackTrace,
  }) : stackTrace = stackTrace ?? StackTrace.current;
}
