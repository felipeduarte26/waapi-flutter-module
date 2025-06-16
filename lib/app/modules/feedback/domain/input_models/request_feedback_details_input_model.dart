import 'package:equatable/equatable.dart';

class RequestFeedbackDetailsInputModel extends Equatable {
  final String requestFeedbackId;
  final bool isRequestedByMe;

  const RequestFeedbackDetailsInputModel({
    required this.requestFeedbackId,
    required this.isRequestedByMe,
  });

  @override
  List<Object> get props {
    return [
      requestFeedbackId,
      isRequestedByMe,
    ];
  }
}
