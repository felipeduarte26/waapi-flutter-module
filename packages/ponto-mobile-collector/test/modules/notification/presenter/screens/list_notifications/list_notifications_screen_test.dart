import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/modules/notification/domain/entities/push_message_entity.dart';
import 'package:ponto_mobile_collector/app/collector/modules/notification/presenter/blocs/confirm_read_push_message/confirm_read_push_message_bloc.dart';
import 'package:ponto_mobile_collector/app/collector/modules/notification/presenter/blocs/confirm_read_push_message/confirm_read_push_message_event.dart';
import 'package:ponto_mobile_collector/app/collector/modules/notification/presenter/blocs/confirm_read_push_message/confirm_read_push_message_state.dart';
import 'package:ponto_mobile_collector/app/collector/modules/notification/presenter/blocs/list_notifications_bloc/list_notifications_bloc.dart';
import 'package:ponto_mobile_collector/app/collector/modules/notification/presenter/blocs/list_notifications_bloc/list_notifications_event.dart';
import 'package:ponto_mobile_collector/app/collector/modules/notification/presenter/blocs/list_notifications_bloc/list_notifications_state.dart';
import 'package:ponto_mobile_collector/app/collector/modules/notification/presenter/screens/list_notifications/bloc/list_notifications_screen_bloc.dart';
import 'package:ponto_mobile_collector/app/collector/modules/notification/presenter/screens/list_notifications/list_notifications_screen.dart';
import 'package:ponto_mobile_collector/generated/l10n/collector_localizations.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';

class MockListNotificationsScreenBloc extends Mock
    implements ListNotificationsScreenBloc {}

class MockListNotificationsBloc
    extends MockBloc<ListNotificationsEvent, ListNotificationsState>
    implements ListNotificationsBloc {}

class MockConfirmReadPushMessageBloc
    extends MockBloc<ConfirmReadPushMessageEvent, ConfirmReadPushMessageState>
    implements ConfirmReadPushMessageBloc {}

void main() {
  late MockListNotificationsScreenBloc mockListNotificationsScreenBloc;
  late MockListNotificationsBloc mockListNotificationsBloc;
  late MockConfirmReadPushMessageBloc mockConfirmReadPushMessageBloc;

  setUp(() {
    mockListNotificationsScreenBloc = MockListNotificationsScreenBloc();
    mockListNotificationsBloc = MockListNotificationsBloc();
    mockConfirmReadPushMessageBloc = MockConfirmReadPushMessageBloc();

    when(() => mockListNotificationsScreenBloc.listNotificationsBloc)
        .thenReturn(mockListNotificationsBloc);
    when(() => mockListNotificationsScreenBloc.confirmReadPushMessageBloc)
        .thenReturn(mockConfirmReadPushMessageBloc);
    when(() => mockConfirmReadPushMessageBloc.state)
        .thenReturn(InitialConfirmReadPushMessageState());
  });

  testWidgets(
      'renders ListNotificationsScreen with LoadedListNotificationsState',
      (WidgetTester tester) async {
    DateTime datetime = DateTime.now();
    final notifications = [
      PushMessageEntity(
        id: '1',
        title: 'Test Notification',
        messageContent: 'This is a test notification',
        createdAt: datetime,
        read: false,
      ),
    ];

    when(
      () => mockListNotificationsScreenBloc.formatNotificationDate(
        datetime,
        'en',
      ),
    ).thenReturn('01/01/2021 00:00');  

    when(() => mockListNotificationsBloc.state).thenReturn(
      LoadedListNotificationsState(notifications: notifications),
    );

    await tester.pumpWidget(
      ChangeNotifierProvider<ThemeRepository>(
        create: (_) => ThemeRepository(
          const SeniorThemeData(
            themeType: ThemeType.light,
          ),
        ),
        child: MaterialApp(
          localizationsDelegates: const [
            CollectorLocalizations.delegate,
          ],
          home: BlocProvider<ListNotificationsScreenBloc>(
            create: (_) => mockListNotificationsScreenBloc,
            child: ListNotificationsScreen(
              listNotificationsScreenBloc: mockListNotificationsScreenBloc,
            ),
          ),
        ),
      ),
    );
    expect(find.text('Test Notification'), findsOneWidget);
  });
}
