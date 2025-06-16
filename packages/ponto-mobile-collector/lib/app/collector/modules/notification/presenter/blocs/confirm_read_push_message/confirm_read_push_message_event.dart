import 'package:equatable/equatable.dart';

abstract class ConfirmReadPushMessageEvent extends Equatable {
  @override
  List<Object?> get props {
    return [];
  }
}

class GetConfirmReadPushMessageEventEvent extends ConfirmReadPushMessageEvent {
  final String messageId;
  final bool read;

  GetConfirmReadPushMessageEventEvent({
    required this.messageId,
    required this.read,
  });

  @override
  List<Object?> get props {
    return [
      messageId,
      read,
    ];
  }
}
