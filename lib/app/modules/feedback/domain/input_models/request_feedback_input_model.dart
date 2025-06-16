import 'package:equatable/equatable.dart';

class RequestFeedbackInputModel extends Equatable {
  final String message;
  final String receiverId;

  const RequestFeedbackInputModel({
    required this.receiverId,
    required this.message,
  });

  @override
  List<Object> get props {
    return [
      receiverId,
      receiverId,
    ];
  }
}
