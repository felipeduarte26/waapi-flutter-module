import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/modules/notification/domain/entities/push_notification_dto.dart';
import 'package:ponto_mobile_collector/app/collector/modules/notification/domain/failures/notification_failure.dart';
import 'package:ponto_mobile_collector/app/collector/modules/notification/infra/datasources/push_notifications_datasource.dart';
import 'package:ponto_mobile_collector/app/collector/modules/notification/infra/repositories/push_notifications_repository_impl.dart';

class MockGetPushNotificationsDatasource extends Mock implements GetPushNotificationsDatasource {}

void main() {
  late PushNotificationsRepositoryImpl repository;
  late MockGetPushNotificationsDatasource mockDataSource;

  setUp(() {
    mockDataSource = MockGetPushNotificationsDatasource();
    repository = PushNotificationsRepositoryImpl(
      getPushNotificationsDatasource: mockDataSource,
    );
  });

  group('PushNotificationsRepositoryImpl', () {
    const employeeId = 'testEmployeeId';
    final listPushNotifications = PushNotificationDto(messages: []);

    test('should return right when data source call is successful', () async {
      when(() => mockDataSource.call(employeeId: employeeId,))
          .thenAnswer((_) async => listPushNotifications);

      final result = await repository.call(employeeId: employeeId,);

      expect(result.isRight, true);
    });

    test('should return left when data source call throws an exception', () async {
      when(() => mockDataSource.call(employeeId: employeeId,))
          .thenThrow(Exception());

      final result = await repository.call(employeeId: employeeId,);

      expect(result.isLeft, true);
      result.fold(
        (failure) => expect(failure, isA<NotificationDatasourceFailure>()),
        (_) => fail('Expected a NotificationDatasourceFailure'),
      );
    });
  });
}
