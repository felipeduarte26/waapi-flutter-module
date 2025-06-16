
import '../../../../core/domain/failures/failure.dart';

abstract class NotificationFailure extends Failure {
  const NotificationFailure({
    super.message,
    super.stackTrace,
  });
}

class NotificationDatasourceFailure extends NotificationFailure {
  const NotificationDatasourceFailure({
    super.message,
    super.stackTrace,
  });
}
