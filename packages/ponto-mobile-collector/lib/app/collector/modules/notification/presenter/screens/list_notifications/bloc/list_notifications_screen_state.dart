import 'package:equatable/equatable.dart';

import '../../../blocs/list_notifications_bloc/list_notifications_state.dart';

abstract class ListNotificationsScreenState extends Equatable {
  final ListNotificationsState listNotificationsState;

  const ListNotificationsScreenState({
    required this.listNotificationsState,
  });

  CurrentListNotificationsScreenState currentState({
    required ListNotificationsState listNotificationsState,
  }) {
    return CurrentListNotificationsScreenState(
      listNotificationsState: listNotificationsState,
    );
  }

  @override
  List<Object?> get props {
    return [
      listNotificationsState,
    ];
  }
}

class CurrentListNotificationsScreenState extends ListNotificationsScreenState {
  const CurrentListNotificationsScreenState({
    required ListNotificationsState listNotificationsState,
  }) : super(
          listNotificationsState: listNotificationsState,
        );
}
