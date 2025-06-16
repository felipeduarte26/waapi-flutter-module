import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/modules/notification/presenter/blocs/list_notifications_bloc/list_notifications_state.dart';
import 'package:ponto_mobile_collector/app/collector/modules/notification/presenter/screens/list_notifications/bloc/list_notifications_screen_event.dart';

void main() {
  group(
    'ListNotificationsScreenEventTest',
    () {
      test(
        'Should event be ListNotificationsScreenEvent when call ChangeListNotificationsScreenEvent constructor',
        () {
          // Arrange
          final tListNotificationsState = InitialListNotificationsState();

          // Act
          final listNotificationsChanged = ChangeListNotificationsScreenEvent(
            listNotificationsState: tListNotificationsState,
          );

          // Asserts
          expect(listNotificationsChanged, isA<ListNotificationsScreenEvent>());

          expect(
            listNotificationsChanged,
            ChangeListNotificationsScreenEvent(
              listNotificationsState: InitialListNotificationsState(),
            ),
          );
        },
      );
    },
  );
}
