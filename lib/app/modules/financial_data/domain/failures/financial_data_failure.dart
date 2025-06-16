import '../../../../core/failures/failure.dart';

abstract class FinancialDataFailure extends Failure {
  const FinancialDataFailure({
    String? message,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          stackTrace: stackTrace,
        );
}

class FinancialDataDatasourceFailure extends FinancialDataFailure {
  const FinancialDataDatasourceFailure({
    String? message,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          stackTrace: stackTrace,
        );
}
