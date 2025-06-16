class GetEmployeesFacialRegistrationException implements Exception {
  final Object? exception;
  final StackTrace stackTrace;

  GetEmployeesFacialRegistrationException({
    required this.exception,
    StackTrace? stackTrace,
  }) : stackTrace = stackTrace ?? StackTrace.current;
}
