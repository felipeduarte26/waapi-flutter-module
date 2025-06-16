import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/modules/notification/presenter/blocs/counter_notifications_bloc/counter_notifications_event.dart';

void main() {
  group('CounterNotificationsEvent', () {
    test('GetCounterNotificationsEvent props are correct', () {
      final event = GetCounterNotificationsEvent();
      expect(event.props, []);
    });

    test('GetCounterNotificationsEvent is an instance of CounterNotificationsEvent', () {
      final event = GetCounterNotificationsEvent();
      expect(event, isA<CounterNotificationsEvent>());
    });
  });
}