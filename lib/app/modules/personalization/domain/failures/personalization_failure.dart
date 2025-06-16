import '../../../../core/failures/failure.dart';
import '../entities/personalization_mobile_entity.dart';

abstract class PersonalizationFailure extends Failure {
  const PersonalizationFailure({
    String? message,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          stackTrace: stackTrace,
        );
}

class PersonalizationDatasourceFailure extends PersonalizationFailure {
  const PersonalizationDatasourceFailure({
    String? message,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          stackTrace: stackTrace,
        );
}

class PersonalizationMobileDatasourceFailure extends PersonalizationFailure {
  final PersonalizationMobileEntity? defaultPersonalizationMobileEntity;
  const PersonalizationMobileDatasourceFailure({
    String? message,
    StackTrace? stackTrace,
    this.defaultPersonalizationMobileEntity,
  }) : super(
          message: message,
          stackTrace: stackTrace,
        );
}
