import 'package:equatable/equatable.dart';

import '../../../domain/entities/feedback_entity.dart';

abstract class ReceivedFeedbacksState extends Equatable {
  final List<FeedbackEntity> receivedFeedbacks;

  const ReceivedFeedbacksState({
    this.receivedFeedbacks = const <FeedbackEntity>[],
  });

  LoadingReceivedFeedbacksState loadingReceivedFeedbacksState() {
    return const LoadingReceivedFeedbacksState();
  }

  LoadingMoreReceivedFeedbacksState loadingMoreReceivedFeedbacksState() {
    return LoadingMoreReceivedFeedbacksState(
      receivedFeedbacks: receivedFeedbacks,
    );
  }

  EmptyListReceivedFeedbacksState emptyListReceivedFeedbacksState() {
    return EmptyListReceivedFeedbacksState();
  }

  LoadedReceivedFeedbacksState loadedReceivedFeedbacksState({
    required List<FeedbackEntity> receivedFeedbacks,
  }) {
    return LoadedReceivedFeedbacksState(
      receivedFeedbacks: receivedFeedbacks,
    );
  }

  LastPageReceivedFeedbacksState lastPageReceivedFeedbacksState({
    required List<FeedbackEntity> receivedFeedbacks,
  }) {
    return LastPageReceivedFeedbacksState(
      receivedFeedbacks: receivedFeedbacks,
    );
  }

  ErrorReceivedFeedbacksState errorReceivedFeedbacksState({
    String? errorMessage,
  }) {
    return ErrorReceivedFeedbacksState(
      errorMessage: errorMessage,
      receivedFeedbacks: receivedFeedbacks,
    );
  }

  @override
  List<Object?> get props {
    return [
      receivedFeedbacks,
    ];
  }
}

class InitialReceivedFeedbacksState extends ReceivedFeedbacksState {
  const InitialReceivedFeedbacksState() : super();
}

class LoadingReceivedFeedbacksState extends ReceivedFeedbacksState {
  const LoadingReceivedFeedbacksState() : super();
}

class LoadingMoreReceivedFeedbacksState extends ReceivedFeedbacksState {
  const LoadingMoreReceivedFeedbacksState({
    required List<FeedbackEntity> receivedFeedbacks,
  }) : super(receivedFeedbacks: receivedFeedbacks);
}

class LoadedReceivedFeedbacksState extends ReceivedFeedbacksState {
  const LoadedReceivedFeedbacksState({
    required List<FeedbackEntity> receivedFeedbacks,
  }) : super(receivedFeedbacks: receivedFeedbacks);
}

class EmptyListReceivedFeedbacksState extends ReceivedFeedbacksState {}

class LastPageReceivedFeedbacksState extends ReceivedFeedbacksState {
  const LastPageReceivedFeedbacksState({
    required List<FeedbackEntity> receivedFeedbacks,
  }) : super(receivedFeedbacks: receivedFeedbacks);
}

class ReloadListReceivedFeedbacksState extends ReceivedFeedbacksState {}

class ErrorReceivedFeedbacksState extends ReceivedFeedbacksState {
  final String? errorMessage;
  const ErrorReceivedFeedbacksState({
    this.errorMessage,
    required List<FeedbackEntity> receivedFeedbacks,
  }) : super(receivedFeedbacks: receivedFeedbacks);

  @override
  List<Object?> get props {
    return [
      ...super.props,
      errorMessage,
    ];
  }
}
