import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/modules/notification/domain/entities/has_unread_push_message_entity.dart';
import 'package:ponto_mobile_collector/app/collector/modules/notification/infra/datasources/get_number_unread_notifications_datasource.dart';
import 'package:ponto_mobile_collector/app/collector/modules/notification/infra/repositories/get_number_unread_notifications_repository_impl.dart';

class MockGetNumberUnreadNotificationsDatasource extends Mock
    implements GetNumberUnreadNotificationsDatasource {}

void main() {
  late GetNumberUnreadNotificationsRepositoryImpl repository;
  late MockGetNumberUnreadNotificationsDatasource mockDatasource;

  setUp(() {
    mockDatasource = MockGetNumberUnreadNotificationsDatasource();
    repository = GetNumberUnreadNotificationsRepositoryImpl(
      getNumberUnreadNotificationsDatasource: mockDatasource,
    );
  });

  group('GetNumberUnreadNotificationsRepositoryImpl', () {
    const employeeId = 'test_employee_id';
    final hasUnreadPushMessage = HasUnreadPushMessageEntity(
      hasUnreadPushMessage: true,
      number: 5,
    );

    test(
        'should return number of unread notifications when datasource call is successful',
        () async {
      when(() => mockDatasource.call(employeeId: employeeId,))
          .thenAnswer((_) async => hasUnreadPushMessage);

      final result =
          await repository.call(employeeId: employeeId,);

      expect(result.isRight, true);
      verify(() => mockDatasource.call(employeeId: employeeId,))
          .called(1);
      verifyNoMoreInteractions(mockDatasource);
    });

    test(
        'should return NotificationDatasourceFailure when datasource call throws an exception',
        () async {
      when(() => mockDatasource.call(employeeId: employeeId,))
          .thenThrow(Exception());

      final result =
          await repository.call(employeeId: employeeId,);

      expect(result.isLeft, true);
      verify(() => mockDatasource.call(employeeId: employeeId,))
          .called(1);
      verifyNoMoreInteractions(mockDatasource);
    });
  });
}
