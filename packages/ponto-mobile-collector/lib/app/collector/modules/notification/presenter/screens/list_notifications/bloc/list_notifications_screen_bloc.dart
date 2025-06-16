import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../../../core/domain/services/session/isession_service.dart';
import '../../../../../../core/infra/utils/utils.dart';
import '../../../blocs/confirm_read_push_message/confirm_read_push_message_bloc.dart';
import '../../../blocs/list_notifications_bloc/list_notifications_bloc.dart';
import 'list_notifications_screen_event.dart';
import 'list_notifications_screen_state.dart';

class ListNotificationsScreenBloc
    extends Bloc<ListNotificationsScreenEvent, ListNotificationsScreenState> {
  final ListNotificationsBloc listNotificationsBloc;
  final ConfirmReadPushMessageBloc confirmReadPushMessageBloc;
  final ISessionService sessionService;

  late StreamSubscription listNotificationsSubscription;

  ListNotificationsScreenBloc({
    required this.listNotificationsBloc,
    required this.confirmReadPushMessageBloc,
    required this.sessionService,
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

  String formatNotificationDate(DateTime? createdAt, String localeName) {
    DateTime dateTime = createdAt ?? DateTime.now();
    DateTime dateTimeUtc = dateTime.toUtc().add(
          getTimeZoneOffset() ?? Duration.zero,
        );

    return DateFormat(
      Utils().getDateTimePattern(localeName: localeName),
    ).format(dateTimeUtc);
  }

  Duration? getTimeZoneOffset() {
    return sessionService.getTimeZoneOffset();
  }

  @override
  Future<void> close() async {
    await listNotificationsSubscription.cancel();
    return super.close();
  }
}
