import 'package:equatable/equatable.dart';

import '../../../blocs/notification_settings_bloc/notification_settings_state.dart';
import '../../../blocs/permission_notification_bloc/permission_notification_state.dart';

abstract class NotificationSettingsScreenState extends Equatable {
  final NotificationSettingsState notificationSettingsState;
  final PermissionNotificationState permissionNotificationState;

  const NotificationSettingsScreenState({
    required this.notificationSettingsState,
    required this.permissionNotificationState,
  });

  CurrentNotificationSettingsScreenState currentState({
    NotificationSettingsState? notificationSettingsState,
    PermissionNotificationState? permissionNotificationState,
  }) {
    return CurrentNotificationSettingsScreenState(
      notificationSettingsState: notificationSettingsState ?? this.notificationSettingsState,
      permissionNotificationState: permissionNotificationState ?? this.permissionNotificationState,
    );
  }

  @override
  List<Object?> get props {
    return [
      notificationSettingsState,
      permissionNotificationState,
    ];
  }
}

class CurrentNotificationSettingsScreenState extends NotificationSettingsScreenState {
  const CurrentNotificationSettingsScreenState({
    required NotificationSettingsState notificationSettingsState,
    required PermissionNotificationState permissionNotificationState,
  }) : super(
          notificationSettingsState: notificationSettingsState,
          permissionNotificationState: permissionNotificationState,
        );
}
