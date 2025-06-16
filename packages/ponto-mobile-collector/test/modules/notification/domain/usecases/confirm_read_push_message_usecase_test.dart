import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/types/either.dart';
import 'package:ponto_mobile_collector/app/collector/modules/notification/domain/entities/confirm_read_push_message_entity.dart';
import 'package:ponto_mobile_collector/app/collector/modules/notification/domain/failures/notification_failure.dart';
import 'package:ponto_mobile_collector/app/collector/modules/notification/domain/repositories/confirm_read_push_message_repository.dart';
import 'package:ponto_mobile_collector/app/collector/modules/notification/domain/usecases/confirm_read_push_message_usecase.dart';

class MockConfirmReadPushMessageRepository extends Mock
    implements ConfirmReadPushMessageRepository {}

void main() {
  late ConfirmReadPushMessageUseCaseImpl useCase;
  late MockConfirmReadPushMessageRepository mockRepository;

  setUp(() {
    mockRepository = MockConfirmReadPushMessageRepository();
    useCase = ConfirmReadPushMessageUseCaseImpl(
      confirmReadPushMessageRepository: mockRepository,
    );
  });

  const messageId = 'test_message_id';
  final confirmReadPushMessageEntity =
      ConfirmReadPushMessageEntity(confirmed: true);
  test('should return ConfirmReadPushMessageEntity when the call is successful',
      () async {
    when(
      () => mockRepository.call(
        messageId: any(named: 'messageId'),
      ),
    ).thenAnswer((_) async => right(confirmReadPushMessageEntity));

    final result = await useCase.call(messageId: messageId);

    expect(result, confirmReadPushMessageEntity);
    verify(
      () => mockRepository.call(
        messageId: any(named: 'messageId'),
      ),
    ).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test(
      'should return ConfirmReadPushMessageEntity with confirmed false when the repository call fails',
      () async {
    when(
      () => mockRepository.call(
        messageId: any(named: 'messageId'),
      ),
    ).thenAnswer((_) async => left(const NotificationDatasourceFailure()));

    final result = await useCase.call(messageId: messageId);

    expect(result.confirmed, false);
    verify(
      () => mockRepository.call(
        messageId: any(named: 'messageId'),
      ),
    ).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
