import 'package:equatable/equatable.dart';

import '../../../enums/notification_permission_status_enum.dart';

abstract class PermissionNotificationEvent extends Equatable {
  @override
  List<Object?> get props {
    return [];
  }
}

class RequestPermissionNotificationEvent extends PermissionNotificationEvent {}

class SaveNativePermissionNotificationEvent extends PermissionNotificationEvent {
  final NotificationPermissionStatusEnum notificationPermissionStatus;

  SaveNativePermissionNotificationEvent({
    required this.notificationPermissionStatus,
  });

  @override
  List<Object?> get props {
    return [
      ...super.props,
      notificationPermissionStatus,
    ];
  }
}

class ClearTokenPermissionNotificationEvent extends PermissionNotificationEvent {}

class RegisterTokenPermissionNotificationEvent extends PermissionNotificationEvent {}

class OpenNativeSettingsPermissionNotificationEvent extends PermissionNotificationEvent {}

class ClearAndSaveAndSignOutPermissionNotificationEvent extends PermissionNotificationEvent {}
