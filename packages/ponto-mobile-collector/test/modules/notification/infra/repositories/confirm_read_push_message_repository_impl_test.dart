import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/modules/notification/domain/entities/confirm_read_push_message_entity.dart';
import 'package:ponto_mobile_collector/app/collector/modules/notification/domain/failures/notification_failure.dart';
import 'package:ponto_mobile_collector/app/collector/modules/notification/infra/datasources/confirm_read_push_message_datasource.dart';
import 'package:ponto_mobile_collector/app/collector/modules/notification/infra/repositories/confirm_read_push_message_repository_impl.dart';

class MockConfirmReadPushMessageDataSource extends Mock
    implements ConfirmReadPushMessageDataSource {}

void main() {
  late ConfirmReadPushMessageRepositoryImpl repository;
  late MockConfirmReadPushMessageDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockConfirmReadPushMessageDataSource();
    repository = ConfirmReadPushMessageRepositoryImpl(
      confirmReadPushMessageDataSource: mockDataSource,
    );
  });

  group('ConfirmReadPushMessageRepositoryImpl', () {
    const messageId = 'testMessageId';
    final confirmReadPushMessage = ConfirmReadPushMessageEntity(confirmed: true);

    test('should return right when data source call is successful', () async {
      when(() => mockDataSource.call(messageId: messageId,))
          .thenAnswer((_) async => confirmReadPushMessage);

      final result = await repository.call(messageId: messageId,);

      expect(result.isRight, true);
    });

    test('should return left when data source call throws an exception',
        () async {
      when(() => mockDataSource.call(messageId: messageId,))
          .thenThrow(Exception());

      final result = await repository.call(messageId: messageId,);

      expect(result.isLeft, true);
      result.fold(
        (failure) => expect(failure, isA<NotificationDatasourceFailure>()),
        (_) => fail('Expected a NotificationDatasourceFailure'),
      );
    });
  });
}
