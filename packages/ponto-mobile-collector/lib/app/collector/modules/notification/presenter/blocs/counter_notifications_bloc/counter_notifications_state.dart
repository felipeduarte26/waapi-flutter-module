import 'package:equatable/equatable.dart';

import '../../../domain/entities/has_unread_push_message_entity.dart';

abstract class CounterNotificationsState extends Equatable {
  @override
  List<Object?> get props {
    return [];
  }
}

class InitialCounterNotificationsState extends CounterNotificationsState {}

class LoadingCounterNotificationsState extends CounterNotificationsState {}

class SucceedCounterNotificationsState extends CounterNotificationsState {
  final HasUnreadPushMessageEntity hasUnreadPushMessage;

  SucceedCounterNotificationsState({
    required this.hasUnreadPushMessage,
  });

  @override
  List<Object?> get props {
    return [
      ...super.props,
      hasUnreadPushMessage,
    ];
  }
}

class ErrorCounterNotificationsState extends CounterNotificationsState {}
