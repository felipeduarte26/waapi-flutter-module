import 'package:equatable/equatable.dart';

import '../../../domain/entities/user_notification_setting_entity.dart';

abstract class NotificationSettingsEvent extends Equatable {
  @override
  List<Object?> get props {
    return [];
  }
}

class GetNotificationSettingsEvent extends NotificationSettingsEvent {}

class ToggleNotificationSettingsEvent extends NotificationSettingsEvent {
  final UserNotificationSettingEntity userNotificationSettingEntity;

  ToggleNotificationSettingsEvent({
    required this.userNotificationSettingEntity,
  });

  @override
  List<Object?> get props {
    return [
      ...super.props,
      userNotificationSettingEntity,
    ];
  }
}
