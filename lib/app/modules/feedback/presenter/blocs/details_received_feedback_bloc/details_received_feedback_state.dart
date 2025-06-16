import 'package:equatable/equatable.dart';

import '../../../domain/entities/feedback_entity.dart';

abstract class DetailsReceivedFeedbackState extends Equatable {
  const DetailsReceivedFeedbackState();

  @override
  List<Object?> get props {
    return [];
  }
}

class InitialDetailsReceivedFeedbacksState extends DetailsReceivedFeedbackState {}

class LoadingDetailsReceivedFeedbacksState extends DetailsReceivedFeedbackState {}

class LoadedDetailsReceivedFeedbacksVisibilityState extends DetailsReceivedFeedbackState {}

class LoadedDetailsReceivedFeedbackState extends DetailsReceivedFeedbackState {
  final FeedbackEntity receivedFeedbackEntity;

  const LoadedDetailsReceivedFeedbackState({
    required this.receivedFeedbackEntity,
  });
}

class ErrorDetailsReceivedFeedbacksState extends DetailsReceivedFeedbackState {
  final String? errorMessage;

  const ErrorDetailsReceivedFeedbacksState({
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

class ReceivedFeedbacksNotFoundState extends DetailsReceivedFeedbackState {}
