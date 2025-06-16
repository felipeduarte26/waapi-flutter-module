import 'package:equatable/equatable.dart';

import '../../../domain/entities/push_message_entity.dart';



abstract class ListNotificationsState extends Equatable {
  final List<PushMessageEntity> notifications;

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
    required List<PushMessageEntity> notifications,
  }) {
    return LoadingMoreListNotificationsState(
      notifications: notifications,
    );
  }

  ErrorMoreListNotificationsState errorMoreListNotificationsState({
    required List<PushMessageEntity> notifications,
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
    required List<PushMessageEntity> notifications,
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
    required List<PushMessageEntity> notifications,
  }) {
    return ClearingListNotificationsState(
      notifications: notifications,
    );
  }


  LastPageListNotificationsState lastPageListNotificationsState({
    required List<PushMessageEntity> notifications,
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
    required super.notifications,
  });
}

class ReloadListNotificationsState extends ListNotificationsState {
  ReloadListNotificationsState() : super(notifications: []);
}

class ErrorMoreListNotificationsState extends ListNotificationsState {
  final String? message;

  const ErrorMoreListNotificationsState({
    required super.notifications,
    this.message,
  });

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
    required super.notifications,
  });
}

class LoadedListNotificationsState extends ListNotificationsState {
  const LoadedListNotificationsState({
    required super.notifications,
  });
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
    required super.notifications,
  });

  @override
  List<Object?> get props {
    return [
      ...super.props,
    ];
  }
}

class ClearingListNotificationsState extends ListNotificationsState {
  const ClearingListNotificationsState({
    required super.notifications,
  });
}
