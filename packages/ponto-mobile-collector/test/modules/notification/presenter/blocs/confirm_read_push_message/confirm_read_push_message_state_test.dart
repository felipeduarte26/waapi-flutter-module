import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/modules/notification/domain/entities/confirm_read_push_message_entity.dart';
import 'package:ponto_mobile_collector/app/collector/modules/notification/presenter/blocs/confirm_read_push_message/confirm_read_push_message_state.dart';

void main() {
  group('ConfirmReadPushMessageState', () {
    test('InitialConfirmReadPushMessageState props are correct', () {
      final state = InitialConfirmReadPushMessageState();
      expect(state.props, []);
    });

    test('LoadingConfirmReadPushMessageState props are correct', () {
      final state = LoadingConfirmReadPushMessageState();
      expect(state.props, []);
    });

    test('SucceedConfirmReadPushMessageState props are correct', () {
      final confirmReadPushMessage =
          ConfirmReadPushMessageEntity(confirmed: true);
      final state = SucceedConfirmReadPushMessageState(
        confirmReadPushMessage: confirmReadPushMessage,
      );
      expect(state.props, [confirmReadPushMessage]);
    });

    test('ErrorConfirmReadPushMessageState props are correct', () {
      final state = ErrorConfirmReadPushMessageState();
      expect(state.props, []);
    });

    test(
        'SucceedConfirmReadPushMessageState is an instance of ConfirmReadPushMessageState',
        () {
      final confirmReadPushMessage =
          ConfirmReadPushMessageEntity(confirmed: true);
      final state = SucceedConfirmReadPushMessageState(
        confirmReadPushMessage: confirmReadPushMessage,
      );
      expect(state, isA<ConfirmReadPushMessageState>());
    });

    test(
        'ErrorConfirmReadPushMessageState is an instance of ConfirmReadPushMessageState',
        () {
      final state = ErrorConfirmReadPushMessageState();
      expect(state, isA<ConfirmReadPushMessageState>());
    });
  });
}
