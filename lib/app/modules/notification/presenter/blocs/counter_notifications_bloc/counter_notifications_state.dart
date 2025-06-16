import 'package:equatable/equatable.dart';

abstract class CounterNotificationsState extends Equatable {
  @override
  List<Object?> get props {
    return [];
  }
}

class InitialCounterNotificationsState extends CounterNotificationsState {}

class LoadingCounterNotificationsState extends CounterNotificationsState {}

class SucceedCounterNotificationsState extends CounterNotificationsState {
  final int numberUnreadNotifications;

  SucceedCounterNotificationsState({
    required this.numberUnreadNotifications,
  });

  @override
  List<Object?> get props {
    return [
      ...super.props,
      numberUnreadNotifications,
    ];
  }
}

class ErrorCounterNotificationsState extends CounterNotificationsState {}
