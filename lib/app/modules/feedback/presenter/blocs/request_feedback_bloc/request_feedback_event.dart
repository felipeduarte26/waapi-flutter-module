import 'package:equatable/equatable.dart';

abstract class RequestFeedbackEvent extends Equatable {
  const RequestFeedbackEvent();
}

class SendRequestFeedbackRequestEvent extends RequestFeedbackEvent {
  final String message;
  final String receiverId;

  const SendRequestFeedbackRequestEvent({
    required this.message,
    required this.receiverId,
  });

  @override
  List<Object?> get props {
    return [
      message,
      receiverId,
    ];
  }
}
