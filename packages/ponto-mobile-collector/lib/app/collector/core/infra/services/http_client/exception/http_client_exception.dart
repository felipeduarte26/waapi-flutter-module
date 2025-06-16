class HttpClientException implements Exception {
  final Object exception;
  final StackTrace stackTrace;

  HttpClientException({required this.exception, StackTrace? stackTrace})
      : stackTrace = stackTrace ?? StackTrace.current;
}
