import 'package:equatable/equatable.dart';

abstract class DetailsRequestFeedbackScreenEvent extends Equatable {}

class GetDetailsRequestFeedbackStateEvent extends DetailsRequestFeedbackScreenEvent {
  final String feedbackRequestId;
  final bool isRequestedByMe;

  GetDetailsRequestFeedbackStateEvent({
    required this.feedbackRequestId,
    required this.isRequestedByMe,
  });

  @override
  List<Object?> get props {
    return [
      feedbackRequestId,
      isRequestedByMe,
    ];
  }
}
