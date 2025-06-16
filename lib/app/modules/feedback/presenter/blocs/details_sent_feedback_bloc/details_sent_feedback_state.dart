import 'package:equatable/equatable.dart';

import '../../../domain/entities/feedback_entity.dart';

abstract class DetailsSentFeedbackState extends Equatable {
  @override
  List<Object?> get props {
    return [];
  }
}

class InitialDetailsSentFeedbackState extends DetailsSentFeedbackState {}

class LoadingDetailsSentFeedbackState extends DetailsSentFeedbackState {}

class LoadedDetailsSentFeedbackState extends DetailsSentFeedbackState {
  final FeedbackEntity feedbackEntity;

  LoadedDetailsSentFeedbackState({
    required this.feedbackEntity,
  });

  @override
  List<Object?> get props {
    return [
      ...super.props,
      feedbackEntity,
    ];
  }
}

class FeedbackDeletedDetailsSentFeedbackState extends DetailsSentFeedbackState {}

class ErrorDetailsSentFeedbackState extends DetailsSentFeedbackState {
  final String errorMessage;

  ErrorDetailsSentFeedbackState({
    required this.errorMessage,
  });

  @override
  List<Object?> get props {
    return [
      ...super.props,
      errorMessage,
    ];
  }
}

class ErrorDeleteSentFeedbackState extends DetailsSentFeedbackState {}
