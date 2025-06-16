import 'package:equatable/equatable.dart';

import '../../enums/notification_type_enum.dart';

class ToggleNotificationSettingInputModel extends Equatable {
  final NotificationTypeEnum notificationType;
  final bool notificationEnabled;

  const ToggleNotificationSettingInputModel({
    required this.notificationType,
    required this.notificationEnabled,
  });

  @override
  List<Object> get props {
    return [
      notificationType,
      notificationEnabled,
    ];
  }
}
