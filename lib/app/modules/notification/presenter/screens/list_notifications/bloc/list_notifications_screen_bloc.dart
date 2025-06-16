import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../moods/presenter/blocs/moods_bloc/moods_bloc.dart';
import '../../../blocs/list_notifications_bloc/list_notifications_bloc.dart';
import '../../../blocs/mark_notification_as_read_bloc/mark_notification_as_read_bloc.dart';
import 'list_notifications_screen_event.dart';
import 'list_notifications_screen_state.dart';

class ListNotificationsScreenBloc extends Bloc<ListNotificationsScreenEvent, ListNotificationsScreenState> {
  final ListNotificationsBloc listNotificationsBloc;
  final MarkNotificationAsReadBloc markNotificationAsReadBloc;
  final MoodsBloc moodsBloc;

  late StreamSubscription listNotificationsSubscription;
  late StreamSubscription moodsSubscription;

  ListNotificationsScreenBloc({
    required this.listNotificationsBloc,
    required this.markNotificationAsReadBloc,
    required this.moodsBloc,
  }) : super(
          CurrentListNotificationsScreenState(
            listNotificationsState: listNotificationsBloc.state,
          ),
        ) {
    on<ChangeListNotificationsScreenEvent>(
      _changeListNotificationsScreenEvent,
    );

    listNotificationsSubscription = listNotificationsBloc.stream.listen(
      (listNotificationsState) {
        add(
          ChangeListNotificationsScreenEvent(
            listNotificationsState: listNotificationsState,
          ),
        );
      },
    );
  }

  Future<void> _changeListNotificationsScreenEvent(
    ChangeListNotificationsScreenEvent event,
    Emitter<ListNotificationsScreenState> emit,
  ) async {
    emit(
      state.currentState(
        listNotificationsState: event.listNotificationsState,
      ),
    );
  }

  @override
  Future<void> close() async {
    await listNotificationsSubscription.cancel();
    return super.close();
  }
}
