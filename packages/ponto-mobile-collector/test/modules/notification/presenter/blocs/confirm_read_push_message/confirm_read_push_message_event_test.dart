import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/modules/notification/presenter/blocs/confirm_read_push_message/confirm_read_push_message_event.dart';

class TestConfirmReadPushMessageEvent extends ConfirmReadPushMessageEvent {}

void main() {


  group('ConfirmReadPushMessageEvent', () {
    test('GetConfirmReadPushMessageEventEvent props are correct', () {
      final event = GetConfirmReadPushMessageEventEvent(
        messageId: '123',
        read: true,
      );
      expect(event.props, ['123', true]);
    });

    test(
        'GetConfirmReadPushMessageEventEvent is an instance of ConfirmReadPushMessageEvent',
        () {
      final event = GetConfirmReadPushMessageEventEvent(
        messageId: '123',
        read: true,
      );
      expect(event, isA<ConfirmReadPushMessageEvent>());
    });
    test('ConfirmReadPushMessageEvent props are empty', () {
      final event = TestConfirmReadPushMessageEvent();
      expect(event.props, []);
    });
  });
}
