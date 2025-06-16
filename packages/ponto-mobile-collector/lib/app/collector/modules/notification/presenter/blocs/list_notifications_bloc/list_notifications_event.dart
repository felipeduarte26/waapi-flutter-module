import 'package:equatable/equatable.dart';


abstract class ListNotificationsEvent extends Equatable {
  @override
  List<Object?> get props {
    return [];
  }
}

class GetListRecentNotificationsEvent extends ListNotificationsEvent {

  GetListRecentNotificationsEvent();

  @override
  List<Object?> get props {
    return [
      ...super.props,
    ];
  }
}

class ChangeNotificationToReadScreenEvent extends ListNotificationsEvent {
  final int notificationIndex;

  ChangeNotificationToReadScreenEvent({
    required this.notificationIndex,
  });

  @override
  List<Object?> get props {
    return [
      notificationIndex,
    ];
  }
}

class ReloadListNotificationsEvent extends ListNotificationsEvent {}
