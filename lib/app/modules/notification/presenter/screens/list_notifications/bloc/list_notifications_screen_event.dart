import 'package:equatable/equatable.dart';

import '../../../blocs/list_notifications_bloc/list_notifications_state.dart';

abstract class ListNotificationsScreenEvent extends Equatable {}

class ChangeListNotificationsScreenEvent extends ListNotificationsScreenEvent {
  final ListNotificationsState listNotificationsState;

  ChangeListNotificationsScreenEvent({
    required this.listNotificationsState,
  });

  @override
  List<Object?> get props {
    return [
      listNotificationsState,
    ];
  }
}
