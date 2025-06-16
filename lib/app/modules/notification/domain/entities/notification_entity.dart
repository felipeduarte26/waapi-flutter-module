import 'package:equatable/equatable.dart';

import '../../enums/notification_type_enum.dart';
import 'notification_parameters_entity.dart';

class NotificationEntity extends Equatable {
  final String id;
  final String title;
  final String content;
  final NotificationParametersEntity notificationParameters;
  final NotificationTypeEnum notificationType;
  final DateTime createdDate;
  final bool hasRead;

  const NotificationEntity({
    required this.id,
    required this.title,
    required this.content,
    required this.notificationParameters,
    required this.notificationType,
    required this.createdDate,
    required this.hasRead,
  });

  @override
  List<Object?> get props {
    return [
      id,
      title,
      content,
      notificationParameters,
      notificationType,
      createdDate,
      hasRead,
    ];
  }
}
