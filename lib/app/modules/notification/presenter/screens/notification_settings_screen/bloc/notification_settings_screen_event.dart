import 'package:equatable/equatable.dart';

import '../../../blocs/notification_settings_bloc/notification_settings_state.dart';
import '../../../blocs/permission_notification_bloc/permission_notification_state.dart';

abstract class NotificationSettingsScreenEvent extends Equatable {}

class ChangeNotificationSettingsScreenEvent extends NotificationSettingsScreenEvent {
  final NotificationSettingsState notificationSettingsState;

  ChangeNotificationSettingsScreenEvent({
    required this.notificationSettingsState,
  });

  @override
  List<Object?> get props {
    return [
      notificationSettingsState,
    ];
  }
}

class ChangePermissionNotificationState extends NotificationSettingsScreenEvent {
  final PermissionNotificationState permissionNotificationState;

  ChangePermissionNotificationState({
    required this.permissionNotificationState,
  });

  @override
  List<Object?> get props {
    return [
      permissionNotificationState,
    ];
  }
}
