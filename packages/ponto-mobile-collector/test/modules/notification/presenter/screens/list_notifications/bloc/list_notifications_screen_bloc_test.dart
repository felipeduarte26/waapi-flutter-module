import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/session/isession_service.dart';
import 'package:ponto_mobile_collector/app/collector/modules/notification/presenter/blocs/confirm_read_push_message/confirm_read_push_message_bloc.dart';
import 'package:ponto_mobile_collector/app/collector/modules/notification/presenter/blocs/list_notifications_bloc/list_notifications_bloc.dart';
import 'package:ponto_mobile_collector/app/collector/modules/notification/presenter/blocs/list_notifications_bloc/list_notifications_state.dart';
import 'package:ponto_mobile_collector/app/collector/modules/notification/presenter/screens/list_notifications/bloc/list_notifications_screen_bloc.dart';
import 'package:ponto_mobile_collector/app/collector/modules/notification/presenter/screens/list_notifications/bloc/list_notifications_screen_state.dart';

class ListNotificationsBlocMock extends Mock implements ListNotificationsBloc {}

class ConfirmReadPushMessageBlocMock extends Mock implements ConfirmReadPushMessageBloc {}

class MockSessionService extends Mock implements ISessionService {}


void main() {
  late ListNotificationsBloc listNotificationsBlocMock;
  late ConfirmReadPushMessageBloc confirmReadPushMessageBlocMock;
  late ISessionService sessionServiceMock;

  setUp(
    () {
      listNotificationsBlocMock = ListNotificationsBlocMock();
      confirmReadPushMessageBlocMock = ConfirmReadPushMessageBlocMock();
      sessionServiceMock = MockSessionService();
    },
  );

  group(
    'ListNotificationsScreenBlocTest',
    () {
      blocTest<ListNotificationsScreenBloc, ListNotificationsScreenState>(
        'Should change state when ListNotificationsBloc emit new state',
        setUp: () {
          when(
            () => listNotificationsBlocMock.state,
          ).thenReturn(
            InitialListNotificationsState(),
          );

          when(
            () => listNotificationsBlocMock.stream,
          ).thenAnswer(
            (_) async* {
              yield InitialListNotificationsState();
              yield LoadingListNotificationsState();
            },
          );
        },
        build: () {
          return ListNotificationsScreenBloc(
            listNotificationsBloc: listNotificationsBlocMock,
            confirmReadPushMessageBloc: confirmReadPushMessageBlocMock,
            sessionService: sessionServiceMock,
          );
        },
        expect: () {
          return [
            CurrentListNotificationsScreenState(
              listNotificationsState: InitialListNotificationsState(),
            ),
            CurrentListNotificationsScreenState(
              listNotificationsState: LoadingListNotificationsState(),
            ),
          ];
        },
      );
    },
  );
}
