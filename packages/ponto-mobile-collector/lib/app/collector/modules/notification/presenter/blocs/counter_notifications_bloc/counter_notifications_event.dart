import 'package:equatable/equatable.dart';

abstract class CounterNotificationsEvent extends Equatable {
  @override
  List<Object?> get props {
    return [];
  }
}

class GetCounterNotificationsEvent extends CounterNotificationsEvent {}
