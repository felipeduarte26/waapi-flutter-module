import 'package:equatable/equatable.dart';

import '../../enums/notification_type_enum.dart';

class UserNotificationSettingEntity extends Equatable {
  final String id;
  final NotificationTypeEnum notificationType;
  final bool notificationEnabled;

  const UserNotificationSettingEntity({
    required this.id,
    required this.notificationType,
    required this.notificationEnabled,
  });

  @override
  List<Object> get props {
    return [
      id,
      notificationType,
      notificationEnabled,
    ];
  }
}
