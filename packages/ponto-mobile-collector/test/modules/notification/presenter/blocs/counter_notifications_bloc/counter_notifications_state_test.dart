import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/modules/notification/domain/entities/has_unread_push_message_entity.dart';
import 'package:ponto_mobile_collector/app/collector/modules/notification/presenter/blocs/counter_notifications_bloc/counter_notifications_state.dart';

void main() {
  group('CounterNotificationsState', () {
    test('SucceedCounterNotificationsState props are correct', () {
      final hasUnreadPushMessage = HasUnreadPushMessageEntity(hasUnreadPushMessage: true, number: 5);
      final state = SucceedCounterNotificationsState(hasUnreadPushMessage: hasUnreadPushMessage);
      expect(state.props, [hasUnreadPushMessage]);
    });

    test('ErrorCounterNotificationsState props are correct', () {
      final state = ErrorCounterNotificationsState();
      expect(state.props, []);
    });

    test('SucceedCounterNotificationsState is an instance of CounterNotificationsState', () {
      final hasUnreadPushMessage = HasUnreadPushMessageEntity(hasUnreadPushMessage: true, number: 5);
      final state = SucceedCounterNotificationsState(hasUnreadPushMessage: hasUnreadPushMessage);
      expect(state, isA<CounterNotificationsState>());
    });

    test('ErrorCounterNotificationsState is an instance of CounterNotificationsState', () {
      final state = ErrorCounterNotificationsState();
      expect(state, isA<CounterNotificationsState>());
    });
  });
}
