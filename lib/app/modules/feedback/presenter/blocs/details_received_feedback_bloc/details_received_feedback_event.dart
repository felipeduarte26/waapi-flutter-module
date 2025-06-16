import 'package:equatable/equatable.dart';

import '../../../domain/entities/feedback_entity.dart';
import '../../../enums/feedback_type_enum.dart';

abstract class DetailsReceivedFeedbackEvent extends Equatable {}

class SetFeedbackPrivateEvent extends DetailsReceivedFeedbackEvent {
  final FeedbackEntity feedbackEntity;

  SetFeedbackPrivateEvent({
    required this.feedbackEntity,
  });

  @override
  List<Object?> get props {
    return [
      feedbackEntity,
    ];
  }
}

class GetReceivedFeedbackEvent extends DetailsReceivedFeedbackEvent {
  final String receivedFeedbackId;
  final FeedbackTypeEnum feedbackType;

  GetReceivedFeedbackEvent({
    required this.receivedFeedbackId,
    required this.feedbackType,
  });

  @override
  List<Object?> get props {
    return [
      receivedFeedbackId,
    ];
  }
}

class SetFeedbackPublicEvent extends DetailsReceivedFeedbackEvent {
  final FeedbackEntity feedbackEntity;

  SetFeedbackPublicEvent({
    required this.feedbackEntity,
  });

  @override
  List<Object?> get props {
    return [
      feedbackEntity,
    ];
  }
}
