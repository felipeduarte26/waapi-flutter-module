class ServiceException implements Exception {
  final String? errorCode;
  final String? message;
  final String? reason;

  ServiceException({
    this.errorCode,
    this.message,
    this.reason,
  });
}
