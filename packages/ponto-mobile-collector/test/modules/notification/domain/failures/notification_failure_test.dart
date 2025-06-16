import 'package:ponto_mobile_collector/app/collector/modules/notification/domain/failures/notification_failure.dart';
import 'package:test/test.dart';

void main() {
  group('NotificationFailure', () {
    test('should create an instance of NotificationFailure', () {
      // Arrange
      const message = 'An error occurred';
      final stackTrace = StackTrace.current;

      // Act
      final failure = NotificationDatasourceFailure(
        message: message,
        stackTrace: stackTrace,
      );

      // Assert
      expect(failure, isA<NotificationFailure>());
      expect(failure.message, message);
      expect(failure.stackTrace, stackTrace);
    });

    test('should create an instance of NotificationDatasourceFailure', () {
      // Arrange
      const message = 'Datasource error';
      final stackTrace = StackTrace.current;

      // Act
      final failure = NotificationDatasourceFailure(
        message: message,
        stackTrace: stackTrace,
      );

      // Assert
      expect(failure, isA<NotificationDatasourceFailure>());
      expect(failure.message, message);
      expect(failure.stackTrace, stackTrace);
    });
  });
}