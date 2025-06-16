import 'package:equatable/equatable.dart';

abstract class MarkNotificationAsReadEvent extends Equatable {}

class SendMarkNotificationAsReadEvent extends MarkNotificationAsReadEvent {
  final String notificationId;
  final bool isAlreadyRead;

  SendMarkNotificationAsReadEvent({
    required this.notificationId,
    required this.isAlreadyRead,
  });

  @override
  List<Object?> get props {
    return [
      notificationId,
      isAlreadyRead,
    ];
  }
}
