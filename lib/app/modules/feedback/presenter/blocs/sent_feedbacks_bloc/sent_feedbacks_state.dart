import 'package:equatable/equatable.dart';

import '../../../domain/entities/feedback_entity.dart';

abstract class SentFeedbacksState extends Equatable {
  final List<FeedbackEntity> sentFeedbacks;

  const SentFeedbacksState({
    this.sentFeedbacks = const <FeedbackEntity>[],
  });

  LoadingSentFeedbacksState loadingSentFeedbacksState() {
    return const LoadingSentFeedbacksState();
  }

  LoadingMoreSentFeedbacksState loadingMoreSentFeedbacksState() {
    return LoadingMoreSentFeedbacksState(
      sentFeedbacks: sentFeedbacks,
    );
  }

  EmptyListSentFeedbacksState emptyListSentFeedbacksState() {
    return EmptyListSentFeedbacksState();
  }

  LoadedSentFeedbacksState loadedSentFeedbacksState({
    required List<FeedbackEntity> sentFeedbacks,
  }) {
    return LoadedSentFeedbacksState(
      sentFeedbacks: sentFeedbacks,
    );
  }

  LastPageSentFeedbacksState lastPageSentFeedbacksState({
    required List<FeedbackEntity> sentFeedbacks,
  }) {
    return LastPageSentFeedbacksState(
      sentFeedbacks: sentFeedbacks,
    );
  }

  ErrorSentFeedbacksState errorSentFeedbacksState({
    String? errorMessage,
  }) {
    return ErrorSentFeedbacksState(
      errorMessage: errorMessage,
      sentFeedbacks: sentFeedbacks,
    );
  }

  @override
  List<Object?> get props {
    return [
      sentFeedbacks,
    ];
  }
}

class InitialSentFeedbacksState extends SentFeedbacksState {
  const InitialSentFeedbacksState() : super();
}

class LoadingSentFeedbacksState extends SentFeedbacksState {
  const LoadingSentFeedbacksState() : super();
}

class LoadingMoreSentFeedbacksState extends SentFeedbacksState {
  const LoadingMoreSentFeedbacksState({
    required List<FeedbackEntity> sentFeedbacks,
  }) : super(sentFeedbacks: sentFeedbacks);
}

class LoadedSentFeedbacksState extends SentFeedbacksState {
  const LoadedSentFeedbacksState({
    required List<FeedbackEntity> sentFeedbacks,
  }) : super(sentFeedbacks: sentFeedbacks);
}

class EmptyListSentFeedbacksState extends SentFeedbacksState {}

class ReloadListSentFeedbacksState extends SentFeedbacksState {}

class LastPageSentFeedbacksState extends SentFeedbacksState {
  const LastPageSentFeedbacksState({
    required List<FeedbackEntity> sentFeedbacks,
  }) : super(sentFeedbacks: sentFeedbacks);
}

class ErrorSentFeedbacksState extends SentFeedbacksState {
  final String? errorMessage;
  const ErrorSentFeedbacksState({
    this.errorMessage,
    required List<FeedbackEntity> sentFeedbacks,
  }) : super(sentFeedbacks: sentFeedbacks);

  @override
  List<Object?> get props {
    return [
      ...super.props,
      errorMessage,
    ];
  }
}
