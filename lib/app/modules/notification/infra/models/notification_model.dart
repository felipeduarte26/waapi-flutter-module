import 'package:equatable/equatable.dart';

import '../../enums/notification_type_enum.dart';
import 'notification_parameters_model.dart';

class NotificationModel extends Equatable {
  final String id;
  final String title;
  final String content;
  final NotificationParametersModel notificationParameters;
  final NotificationTypeEnum notificationType;
  final DateTime createdDate;
  final bool hasRead;

  const NotificationModel({
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
