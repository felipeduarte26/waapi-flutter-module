import 'package:equatable/equatable.dart';

import '../../../domain/entities/feedback_request_entity.dart';

abstract class FeedbackRequestsState extends Equatable {
  final List<FeedbackRequestEntity> feedbackRequests;

  const FeedbackRequestsState({
    this.feedbackRequests = const <FeedbackRequestEntity>[],
  });

  LoadingFeedbackRequestsState loadingFeedbackRequestsState() {
    return const LoadingFeedbackRequestsState();
  }

  EmptyListFeedbackRequestsState emptyListFeedbackRequestsState() {
    return EmptyListFeedbackRequestsState();
  }

  LoadedFeedbackRequestsState loadedFeedbackRequestsState({
    required List<FeedbackRequestEntity> feedbackRequests,
  }) {
    return LoadedFeedbackRequestsState(
      feedbackRequests: feedbackRequests,
    );
  }

  ErrorFeedbackRequestsState errorFeedbackRequestsState({
    String? errorMessage,
  }) {
    return ErrorFeedbackRequestsState(
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props {
    return [
      feedbackRequests,
    ];
  }
}

class InitialFeedbackRequestsState extends FeedbackRequestsState {
  const InitialFeedbackRequestsState() : super();
}

class LoadingFeedbackRequestsState extends FeedbackRequestsState {
  const LoadingFeedbackRequestsState() : super();
}

class LoadedFeedbackRequestsState extends FeedbackRequestsState {
  const LoadedFeedbackRequestsState({
    required List<FeedbackRequestEntity> feedbackRequests,
  }) : super(feedbackRequests: feedbackRequests);
}

class EmptyListFeedbackRequestsState extends FeedbackRequestsState {}

class ReloadListFeedbackRequestsState extends FeedbackRequestsState {}

class ErrorFeedbackRequestsState extends FeedbackRequestsState {
  final String? errorMessage;
  const ErrorFeedbackRequestsState({
    this.errorMessage,
  });

  @override
  List<Object?> get props {
    return [
      ...super.props,
      errorMessage,
    ];
  }
}
