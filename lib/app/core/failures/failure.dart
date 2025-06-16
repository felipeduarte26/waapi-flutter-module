import 'package:equatable/equatable.dart';

class Failure extends Equatable implements Exception {
  final String? message;
  final StackTrace? stackTrace;

  const Failure({
    this.message,
    this.stackTrace,
  });

  @override
  List<Object?> get props {
    return [
      message,
      stackTrace,
    ];
  }
}
