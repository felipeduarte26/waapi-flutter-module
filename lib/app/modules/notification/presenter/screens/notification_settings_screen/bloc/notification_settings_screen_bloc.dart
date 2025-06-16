import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/notification_settings_bloc/notification_settings_bloc.dart';
import '../../../blocs/permission_notification_bloc/permission_notification_bloc.dart';
import 'notification_settings_screen_event.dart';
import 'notification_settings_screen_state.dart';

class NotificationSettingsScreenBloc extends Bloc<NotificationSettingsScreenEvent, NotificationSettingsScreenState> {
  final NotificationSettingsBloc notificationSettingsBloc;
  final PermissionNotificationBloc permissionNotificationBloc;

  late StreamSubscription notificationSettingsSubscription;
  late StreamSubscription permissionNotificationSubscription;

  NotificationSettingsScreenBloc({
    required this.notificationSettingsBloc,
    required this.permissionNotificationBloc,
  }) : super(
          CurrentNotificationSettingsScreenState(
            notificationSettingsState: notificationSettingsBloc.state,
            permissionNotificationState: permissionNotificationBloc.state,
          ),
        ) {
    on<ChangeNotificationSettingsScreenEvent>(_changeNotificationSettingsScreenEvent);
    on<ChangePermissionNotificationState>(_changePermissionNotificationState);

    notificationSettingsSubscription = notificationSettingsBloc.stream.listen(
      (receivedFeedbacksBlocState) {
        add(
          ChangeNotificationSettingsScreenEvent(
            notificationSettingsState: receivedFeedbacksBlocState,
          ),
        );
      },
    );

    permissionNotificationSubscription = permissionNotificationBloc.stream.listen(
      (permissionNotificationBlocState) {
        add(
          ChangePermissionNotificationState(
            permissionNotificationState: permissionNotificationBlocState,
          ),
        );
      },
    );
  }

  Future<void> _changeNotificationSettingsScreenEvent(
    ChangeNotificationSettingsScreenEvent event,
    Emitter<NotificationSettingsScreenState> emit,
  ) async {
    emit(
      state.currentState(
        notificationSettingsState: event.notificationSettingsState,
      ),
    );
  }

  Future<void> _changePermissionNotificationState(
    ChangePermissionNotificationState event,
    Emitter<NotificationSettingsScreenState> emit,
  ) async {
    emit(
      state.currentState(
        permissionNotificationState: event.permissionNotificationState,
      ),
    );
  }

  @override
  Future<void> close() async {
    await notificationSettingsSubscription.cancel();
    await permissionNotificationSubscription.cancel();
    return super.close();
  }
}
