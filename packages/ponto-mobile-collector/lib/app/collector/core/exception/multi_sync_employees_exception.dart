class MultiSyncEmployeesException implements Exception {
  final String message;
  final int statusCode;

  MultiSyncEmployeesException({
    required this.message,
    required this.statusCode,
  });

  @override
  String toString() {
    return 'MultiSyncEmployeesException: $message (Status code: $statusCode)';
  }
}