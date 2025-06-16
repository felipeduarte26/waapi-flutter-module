class PontoMobileCollectorException implements Exception {
  final String message;

  PontoMobileCollectorException(this.message);

  @override
  String toString() {
    return 'PontoMobileCollectorException: $message';
  }
}
