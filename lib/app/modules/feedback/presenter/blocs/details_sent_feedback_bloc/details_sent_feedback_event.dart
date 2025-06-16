import 'package:equatable/equatable.dart';

import '../../../enums/feedback_type_enum.dart';

abstract class DetailsSentFeedbackEvent extends Equatable {}

class DeleteFeedbackDetailsSentFeedbackEvent extends DetailsSentFeedbackEvent {
  final String idFeedback;

  DeleteFeedbackDetailsSentFeedbackEvent({
    required this.idFeedback,
  });

  @override
  List<Object?> get props {
    return [
      idFeedback,
    ];
  }
}

class GetSentFeedbackEvent extends DetailsSentFeedbackEvent {
  final String sentFeedbackId;
  final FeedbackTypeEnum feedbackType;

  GetSentFeedbackEvent({
    required this.sentFeedbackId,
    required this.feedbackType,
  });

  @override
  List<Object?> get props {
    return [
      sentFeedbackId,
    ];
  }
}
