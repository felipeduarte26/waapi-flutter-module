import 'package:equatable/equatable.dart';

import '../../../domain/entities/notification_entity.dart';

abstract class ListNotificationsState extends Equatable {
  final List<NotificationEntity> notifications;

  const ListNotificationsState({
    required this.notifications,
  });

  InitialListNotificationsState initialListNotificationsState() {
    return InitialListNotificationsState();
  }

  LoadingListNotificationsState loadingListNotificationsState() {
    return LoadingListNotificationsState();
  }

  LoadingMoreListNotificationsState loadingMoreListNotificationsState({
    required List<NotificationEntity> notifications,
  }) {
    return LoadingMoreListNotificationsState(
      notifications: notifications,
    );
  }

  ErrorMoreListNotificationsState errorMoreListNotificationsState({
    required List<NotificationEntity> notifications,
    String? message,
  }) {
    return ErrorMoreListNotificationsState(
      message: message,
      notifications: notifications,
    );
  }

  EmptyListNotificationsState emptyListNotificationsState() {
    return const EmptyListNotificationsState(
      notifications: [],
    );
  }

  LoadedListNotificationsState loadedListNotificationsState({
    required List<NotificationEntity> notifications,
  }) {
    return LoadedListNotificationsState(
      notifications: notifications,
    );
  }

  ErrorListNotificationsState errorListNotificationsState({
    String? message,
  }) {
    return ErrorListNotificationsState(
      message: message,
    );
  }

  ClearingListNotificationsState clearingListNotificationsState({
    required List<NotificationEntity> notifications,
  }) {
    return ClearingListNotificationsState(
      notifications: notifications,
    );
  }

  ErrorClearListNotificationsState errorClearListNotificationsState({
    String? message,
    required List<NotificationEntity> notifications,
  }) {
    return ErrorClearListNotificationsState(
      notifications: notifications,
    );
  }

  LastPageListNotificationsState lastPageListNotificationsState({
    required List<NotificationEntity> notifications,
  }) {
    return LastPageListNotificationsState(
      notifications: notifications,
    );
  }

  @override
  List<Object?> get props {
    return [
      notifications,
    ];
  }
}

class InitialListNotificationsState extends ListNotificationsState {
  InitialListNotificationsState()
      : super(
          notifications: [],
        );
}

class LoadingListNotificationsState extends ListNotificationsState {
  LoadingListNotificationsState()
      : super(
          notifications: [],
        );
}

class LoadingMoreListNotificationsState extends ListNotificationsState {
  const LoadingMoreListNotificationsState({
    required List<NotificationEntity> notifications,
  }) : super(
          notifications: notifications,
        );
}

class ReloadListNotificationsState extends ListNotificationsState {
  ReloadListNotificationsState() : super(notifications: []);
}

class ErrorMoreListNotificationsState extends ListNotificationsState {
  final String? message;

  const ErrorMoreListNotificationsState({
    required List<NotificationEntity> notifications,
    this.message,
  }) : super(
          notifications: notifications,
        );

  @override
  List<Object?> get props {
    return [
      ...super.props,
      message,
    ];
  }
}

class EmptyListNotificationsState extends ListNotificationsState {
  const EmptyListNotificationsState({
    required List<NotificationEntity> notifications,
  }) : super(
          notifications: notifications,
        );
}

class LoadedListNotificationsState extends ListNotificationsState {
  const LoadedListNotificationsState({
    required List<NotificationEntity> notifications,
  }) : super(
          notifications: notifications,
        );
}

class ErrorListNotificationsState extends ListNotificationsState {
  final String? message;

  ErrorListNotificationsState({
    this.message,
  }) : super(
          notifications: [],
        );

  @override
  List<Object?> get props {
    return [
      ...super.props,
      message,
    ];
  }
}

class LastPageListNotificationsState extends ListNotificationsState {
  const LastPageListNotificationsState({
    required List<NotificationEntity> notifications,
  }) : super(
          notifications: notifications,
        );

  @override
  List<Object?> get props {
    return [
      ...super.props,
    ];
  }
}

class ClearingListNotificationsState extends ListNotificationsState {
  const ClearingListNotificationsState({
    required List<NotificationEntity> notifications,
  }) : super(
          notifications: notifications,
        );
}

class ErrorClearListNotificationsState extends ListNotificationsState {
  const ErrorClearListNotificationsState({
    required List<NotificationEntity> notifications,
  }) : super(
          notifications: notifications,
        );

  @override
  List<Object?> get props {
    return [
      ...super.props,
    ];
  }
}
