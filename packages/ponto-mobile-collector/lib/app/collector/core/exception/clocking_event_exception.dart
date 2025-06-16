class ClockingEventException implements Exception {
  final String erro;
  ClockingEventException(this.erro);

  String get message => erro;
}
