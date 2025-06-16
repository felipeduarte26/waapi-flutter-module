import 'package:equatable/equatable.dart';

import '../../../../../core/pagination/pagination_requirements.dart';

abstract class ListNotificationsEvent extends Equatable {
  @override
  List<Object?> get props {
    return [];
  }
}

class GetListRecentNotificationsEvent extends ListNotificationsEvent {
  final PaginationRequirements paginationRequirements;

  GetListRecentNotificationsEvent({
    required this.paginationRequirements,
  });

  @override
  List<Object?> get props {
    return [
      ...super.props,
      paginationRequirements,
    ];
  }
}

class ReloadListNotificationsEvent extends ListNotificationsEvent {}

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

class ClearAllUserNotificationsEvent extends ListNotificationsEvent {}
