import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/modules/notification/presenter/blocs/list_notifications_bloc/list_notifications_state.dart';
import 'package:ponto_mobile_collector/app/collector/modules/notification/presenter/screens/list_notifications/bloc/list_notifications_screen_state.dart';

void main() {
  group(
    'ListNotificationsScreenStateTest',
    () {
      test(
        'Should state be ListNotificationsScreenState when call CurrentListNotificationsScreenState constructor',
        () {
          // Act
          final currentNotificationList = CurrentListNotificationsScreenState(
            listNotificationsState: InitialListNotificationsState(),
          );

          // Asserts
          expect(currentNotificationList, isA<ListNotificationsScreenState>());
          expect(currentNotificationList.listNotificationsState, isA<InitialListNotificationsState>());
        },
      );

      test(
        'Should state be LoadingListNotificationsState when call CurrentListNotificationsScreenState constructor',
        () {
          // Act
          var currentNotificationList = CurrentListNotificationsScreenState(
            listNotificationsState: InitialListNotificationsState(),
          );

          currentNotificationList = currentNotificationList.currentState(
            listNotificationsState: LoadingListNotificationsState(),
          );

          // Asserts
          expect(currentNotificationList, isA<ListNotificationsScreenState>());
          expect(currentNotificationList.listNotificationsState, isA<LoadingListNotificationsState>());
        },
      );
    },
  );
}
