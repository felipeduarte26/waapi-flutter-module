import 'package:equatable/equatable.dart';

class MarkNotificationAsReadInputModel extends Equatable {
  final String notificationId;

  const MarkNotificationAsReadInputModel({
    required this.notificationId,
  });

  @override
  List<Object> get props {
    return [
      notificationId,
    ];
  }
}
