import '../../../../core/failures/failure.dart';

abstract class VacationsFailure extends Failure {
  const VacationsFailure({
    String? message,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          stackTrace: stackTrace,
        );
}

class VacationsDatasourceFailure extends VacationsFailure {
  const VacationsDatasourceFailure({
    String? message,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          stackTrace: stackTrace,
        );
}

class VacationRequestFailure extends VacationsFailure {
  final List<String>? messagesError;

  const VacationRequestFailure({
    String? message,
    StackTrace? stackTrace,
    this.messagesError,
  }) : super(
          message: message,
          stackTrace: stackTrace,
        );

  @override
  List<Object?> get props {
    return [
      ...super.props,
      messagesError,
    ];
  }
}

class CancelVacationRequestFailure extends VacationsFailure {
  final List<String>? messagesError;

  const CancelVacationRequestFailure({
    String? message,
    StackTrace? stackTrace,
    this.messagesError,
  }) : super(
          message: message,
          stackTrace: stackTrace,
        );

  @override
  List<Object?> get props {
    return [
      ...super.props,
      messagesError,
    ];
  }
}
