import 'package:equatable/equatable.dart';

import '../../../../feedback/domain/entities/feedback_entity.dart';

abstract class PublicFeedbacksState extends Equatable {
  final List<FeedbackEntity>? publicFeedbacks;

  const PublicFeedbacksState({
    this.publicFeedbacks = const <FeedbackEntity>[],
  });

  EmptyPublicFeedbacksState emptyPublicFeedbacksState() {
    return EmptyPublicFeedbacksState();
  }

  ErrorPublicFeedbacksState errorPublicFeedbacksState() {
    return ErrorPublicFeedbacksState(
      publicFeedbacks: publicFeedbacks!,
    );
  }

  InitialPublicFeedbacksState initialPublicFeedbacksState() {
    return InitialPublicFeedbacksState();
  }

  LoadingPublicFeedbacksState loadingPublicFeedbacksState() {
    return LoadingPublicFeedbacksState();
  }

  LoadingMorePublicFeedbacksState loadingMorePublicFeedbacksState() {
    return LoadingMorePublicFeedbacksState(
      publicFeedbacks: publicFeedbacks!,
    );
  }

  LastPagePublicFeedbacksState lastPagePublicFeedbacksState({
    required List<FeedbackEntity> publicFeedbacks,
  }) {
    return LastPagePublicFeedbacksState(
      publicFeedbacks: publicFeedbacks,
    );
  }

  LoadedPublicFeedbacksState loadedPagePublicFeedbacksState({
    required List<FeedbackEntity> publicFeedbacks,
  }) {
    return LoadedPublicFeedbacksState(
      publicFeedbacks: publicFeedbacks,
    );
  }

  @override
  List<Object?> get props {
    return [
      publicFeedbacks,
    ];
  }
}

class EmptyPublicFeedbacksState extends PublicFeedbacksState {}

class ErrorPublicFeedbacksState extends PublicFeedbacksState {
  const ErrorPublicFeedbacksState({
    required List<FeedbackEntity> publicFeedbacks,
  }) : super(publicFeedbacks: publicFeedbacks);
}

class InitialPublicFeedbacksState extends PublicFeedbacksState {}

class LoadingPublicFeedbacksState extends PublicFeedbacksState {}

class LoadingMorePublicFeedbacksState extends PublicFeedbacksState {
  const LoadingMorePublicFeedbacksState({
    required List<FeedbackEntity> publicFeedbacks,
  }) : super(publicFeedbacks: publicFeedbacks);
}

class LastPagePublicFeedbacksState extends PublicFeedbacksState {
  const LastPagePublicFeedbacksState({
    required List<FeedbackEntity> publicFeedbacks,
  }) : super(publicFeedbacks: publicFeedbacks);
}

class LoadedPublicFeedbacksState extends PublicFeedbacksState {
  const LoadedPublicFeedbacksState({
    required List<FeedbackEntity> publicFeedbacks,
  }) : super(publicFeedbacks: publicFeedbacks);
}
