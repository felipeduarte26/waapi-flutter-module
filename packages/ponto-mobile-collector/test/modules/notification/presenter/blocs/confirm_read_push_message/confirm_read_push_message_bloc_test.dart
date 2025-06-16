import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/modules/notification/domain/entities/confirm_read_push_message_entity.dart';
import 'package:ponto_mobile_collector/app/collector/modules/notification/domain/usecases/confirm_read_push_message_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/modules/notification/presenter/blocs/confirm_read_push_message/confirm_read_push_message_bloc.dart';
import 'package:ponto_mobile_collector/app/collector/modules/notification/presenter/blocs/confirm_read_push_message/confirm_read_push_message_event.dart';
import 'package:ponto_mobile_collector/app/collector/modules/notification/presenter/blocs/confirm_read_push_message/confirm_read_push_message_state.dart';
import 'package:ponto_mobile_collector/app/collector/modules/notification/presenter/blocs/counter_notifications_bloc/counter_notifications_bloc.dart';

class MockConfirmReadPushMessageUseCase extends Mock
    implements ConfirmReadPushMessageUseCase {}

class MockCounterNotificationsBloc extends Mock
    implements CounterNotificationsBloc {}

void main() {
  late ConfirmReadPushMessageBloc confirmReadPushMessageBloc;
  late MockConfirmReadPushMessageUseCase mockConfirmReadPushMessageUseCase;
  late MockCounterNotificationsBloc mockCounterNotificationsBloc;
  late ConfirmReadPushMessageEntity confirmReadPushMessageEntity;

  setUp(() {
    mockConfirmReadPushMessageUseCase = MockConfirmReadPushMessageUseCase();
    mockCounterNotificationsBloc = MockCounterNotificationsBloc();
    confirmReadPushMessageBloc = ConfirmReadPushMessageBloc(
      confirmReadPushMessageUseCase: mockConfirmReadPushMessageUseCase,
      counterNotificationsBloc: mockCounterNotificationsBloc,
    );
    confirmReadPushMessageEntity =
        ConfirmReadPushMessageEntity(confirmed: true);
  });

  test('initial state is InitialConfirmReadPushMessageState', () {
    expect(
      confirmReadPushMessageBloc.state,
      equals(InitialConfirmReadPushMessageState()),
    );
  });

  blocTest<ConfirmReadPushMessageBloc, ConfirmReadPushMessageState>(
    'emits [LoadingConfirmReadPushMessageState, SucceedConfirmReadPushMessageState] when GetConfirmReadPushMessageEventEvent is added and use case succeeds',
    build: () {
      when(
        () => mockConfirmReadPushMessageUseCase.call(
          messageId: any(named: 'messageId'),
        ),
      ).thenAnswer((_) async => confirmReadPushMessageEntity);
      return confirmReadPushMessageBloc;
    },
    act: (bloc) => bloc.add(
        GetConfirmReadPushMessageEventEvent(messageId: '123', read: false),),
    expect: () => [
      LoadingConfirmReadPushMessageState(),
      SucceedConfirmReadPushMessageState(
          confirmReadPushMessage: confirmReadPushMessageEntity,),
    ],
  );

  blocTest<ConfirmReadPushMessageBloc, ConfirmReadPushMessageState>(
    'emits [LoadingConfirmReadPushMessageState, ErrorConfirmReadPushMessageState] when GetConfirmReadPushMessageEventEvent is added and use case fails',
    build: () {
      when(
        () => mockConfirmReadPushMessageUseCase.call(
          messageId: any(named: 'messageId'),
        ),
      ).thenAnswer((_) async => ConfirmReadPushMessageEntity(confirmed: false));
      return confirmReadPushMessageBloc;
    },
    act: (bloc) => bloc.add(
        GetConfirmReadPushMessageEventEvent(messageId: '123', read: false),),
    expect: () => [
      LoadingConfirmReadPushMessageState(),
      ErrorConfirmReadPushMessageState(),
    ],
  );
}
