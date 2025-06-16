import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/modules/notification/presenter/blocs/list_notifications_bloc/list_notifications_event.dart';


void main() {
  group('ListNotificationsEvent', () {
    test('GetListRecentNotificationsEvent props are correct', () {
      final event = GetListRecentNotificationsEvent();
      expect(event.props, []);
    });

    test('ChangeNotificationToReadScreenEvent props are correct', () {
      final event = ChangeNotificationToReadScreenEvent(notificationIndex: 1);
      expect(event.props, [1]);
    });

    test('ReloadListNotificationsEvent props are correct', () {
      final event = ReloadListNotificationsEvent();
      expect(event.props, []);
    });
  });
}






















