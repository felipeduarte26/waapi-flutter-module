import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/modules/notification/domain/entities/push_message_entity.dart';
import 'package:ponto_mobile_collector/app/collector/modules/notification/presenter/blocs/list_notifications_bloc/list_notifications_state.dart';

void main() {
  group('ListNotificationsState', () {
    final List<PushMessageEntity> notifications = [
      PushMessageEntity(
        id: '1',
        title: 'Test',
        messageContent: 'Test',
        createdAt: DateTime.now(),
      ),
    ];

    test('InitialListNotificationsState should have empty notifications', () {
      final state = InitialListNotificationsState();
      expect(state.notifications, []);
    });

    test('LoadingListNotificationsState should have empty notifications', () {
      final state = LoadingListNotificationsState();
      expect(state.notifications, []);
    });

    test('LoadingMoreListNotificationsState should have provided notifications',
        () {
      final state =
          LoadingMoreListNotificationsState(notifications: notifications);
      expect(state.notifications, notifications);
    });

    test('ReloadListNotificationsState should have empty notifications', () {
      final state = ReloadListNotificationsState();
      expect(state.notifications, []);
    });

    test(
        'ErrorMoreListNotificationsState should have provided notifications and message',
        () {
      final state = ErrorMoreListNotificationsState(
        notifications: notifications,
        message: 'Error',
      );
      expect(state.notifications, notifications);
      expect(state.message, 'Error');
    });

    test('EmptyListNotificationsState should have empty notifications', () {
      const state = EmptyListNotificationsState(notifications: []);
      expect(state.notifications, []);
    });

    test('LoadedListNotificationsState should have provided notifications', () {
      final state = LoadedListNotificationsState(notifications: notifications);
      expect(state.notifications, notifications);
    });

    test(
        'ErrorListNotificationsState should have empty notifications and provided message',
        () {
      final state = ErrorListNotificationsState(message: 'Error');
      expect(state.notifications, []);
      expect(state.message, 'Error');
    });

    test('LastPageListNotificationsState should have provided notifications',
        () {
      final state =
          LastPageListNotificationsState(notifications: notifications);
      expect(state.notifications, notifications);
    });

    test('ClearingListNotificationsState should have provided notifications',
        () {
      final state =
          ClearingListNotificationsState(notifications: notifications);
      expect(state.notifications, notifications);
    });

    test(
        'initialListNotificationsState method should return InitialListNotificationsState',
        () {
      final state =
          InitialListNotificationsState().initialListNotificationsState();
      expect(state, isA<InitialListNotificationsState>());
    });

    test(
        'loadingListNotificationsState method should return LoadingListNotificationsState',
        () {
      final state =
          InitialListNotificationsState().loadingListNotificationsState();
      expect(state, isA<LoadingListNotificationsState>());
    });

    test(
        'loadingMoreListNotificationsState method should return LoadingMoreListNotificationsState',
        () {
      final state = InitialListNotificationsState()
          .loadingMoreListNotificationsState(notifications: notifications);
      expect(state, isA<LoadingMoreListNotificationsState>());
      expect(state.notifications, notifications);
    });

    test(
        'errorMoreListNotificationsState method should return ErrorMoreListNotificationsState',
        () {
      final state = InitialListNotificationsState()
          .errorMoreListNotificationsState(
              notifications: notifications, message: 'Error',);
      expect(state, isA<ErrorMoreListNotificationsState>());
      expect(state.notifications, notifications);
      expect(state.message, 'Error');
    });

    test(
        'emptyListNotificationsState method should return EmptyListNotificationsState',
        () {
      final state =
          InitialListNotificationsState().emptyListNotificationsState();
      expect(state, isA<EmptyListNotificationsState>());
      expect(state.notifications, []);
    });

    test(
        'loadedListNotificationsState method should return LoadedListNotificationsState',
        () {
      final state = InitialListNotificationsState()
          .loadedListNotificationsState(notifications: notifications);
      expect(state, isA<LoadedListNotificationsState>());
      expect(state.notifications, notifications);
    });

    test(
        'errorListNotificationsState method should return ErrorListNotificationsState',
        () {
      final state = InitialListNotificationsState()
          .errorListNotificationsState(message: 'Error');
      expect(state, isA<ErrorListNotificationsState>());
      expect(state.notifications, []);
      expect(state.message, 'Error');
    });

    test(
        'clearingListNotificationsState method should return ClearingListNotificationsState',
        () {
      final state = InitialListNotificationsState()
          .clearingListNotificationsState(notifications: notifications);
      expect(state, isA<ClearingListNotificationsState>());
      expect(state.notifications, notifications);
    });

    test(
        'lastPageListNotificationsState method should return LastPageListNotificationsState',
        () {
      final state = InitialListNotificationsState()
          .lastPageListNotificationsState(notifications: notifications);
      expect(state, isA<LastPageListNotificationsState>());
      expect(state.notifications, notifications);
    });
  });
}
