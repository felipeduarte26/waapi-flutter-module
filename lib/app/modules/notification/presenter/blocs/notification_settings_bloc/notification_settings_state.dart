import 'package:equatable/equatable.dart';

import '../../../domain/entities/user_notification_setting_entity.dart';

abstract class NotificationSettingsState extends Equatable {
  final List<UserNotificationSettingEntity> userNotificationSettings;

  const NotificationSettingsState({
    this.userNotificationSettings = const <UserNotificationSettingEntity>[],
  });

  TogglingNotificationSettingsState togglingNotificationSettingsState({
    required List<UserNotificationSettingEntity> userNotificationSettings,
    required UserNotificationSettingEntity userNotificationSetting,
  }) {
    return TogglingNotificationSettingsState(
      userNotificationSettings: userNotificationSettings,
      userNotificationSettingEntity: userNotificationSetting,
    );
  }

  @override
  List<Object?> get props {
    return [
      userNotificationSettings,
    ];
  }
}

class InitialNotificationSettingsState extends NotificationSettingsState {}

class LoadingNotificationSettingsState extends NotificationSettingsState {}

class LoadedNotificationSettingsState extends NotificationSettingsState {
  const LoadedNotificationSettingsState({
    required List<UserNotificationSettingEntity> userNotificationSettings,
  }) : super(userNotificationSettings: userNotificationSettings);
}

class ErrorNotificationSettingsState extends NotificationSettingsState {}

class ErrorOnTogglingNotificationSettingsState extends NotificationSettingsState {
  final UserNotificationSettingEntity userNotificationSettingEntity;

  const ErrorOnTogglingNotificationSettingsState({
    required List<UserNotificationSettingEntity> userNotificationSettings,
    required this.userNotificationSettingEntity,
  }) : super(userNotificationSettings: userNotificationSettings);
}

class TogglingNotificationSettingsState extends NotificationSettingsState {
  final UserNotificationSettingEntity userNotificationSettingEntity;

  const TogglingNotificationSettingsState({
    required List<UserNotificationSettingEntity> userNotificationSettings,
    required this.userNotificationSettingEntity,
  }) : super(userNotificationSettings: userNotificationSettings);

  @override
  List<Object?> get props {
    return [
      ...super.props,
      userNotificationSettingEntity,
    ];
  }
}

class ToggledNotificationSettingsState extends NotificationSettingsState {
  final UserNotificationSettingEntity userNotificationSettingEntity;

  const ToggledNotificationSettingsState({
    required List<UserNotificationSettingEntity> userNotificationSettings,
    required this.userNotificationSettingEntity,
  }) : super(userNotificationSettings: userNotificationSettings);

  @override
  List<Object?> get props {
    return [
      ...super.props,
      userNotificationSettingEntity,
    ];
  }
}
