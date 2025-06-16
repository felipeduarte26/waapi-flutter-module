import 'package:equatable/equatable.dart';

import '../../../../domain/entities/feedback_request_entity.dart';

abstract class DetailsRequestFeedbackScreenState extends Equatable {
  const DetailsRequestFeedbackScreenState();

  LoadedDetailsRequestFeedbackState loadedDetailsRequestFeedbackState({
    required FeedbackRequestEntity requestEntity,
  }) {
    return LoadedDetailsRequestFeedbackState(
      requestEntity: requestEntity,
    );
  }

  InitialDetailsRequestFeedbackState initialDetailsRequestFeedbackState() {
    return InitialDetailsRequestFeedbackState();
  }

  LoadingDetailsRequestFeedbackState loadingDetailsRequestFeedbackState() {
    return LoadingDetailsRequestFeedbackState();
  }

  ErrorDetailsRequestFeedbackState errorDetailsRequestFeedbackState({
    String? errorMessage,
  }) {
    return ErrorDetailsRequestFeedbackState(
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props {
    return [];
  }
}

class InitialDetailsRequestFeedbackState extends DetailsRequestFeedbackScreenState {}

class LoadingDetailsRequestFeedbackState extends DetailsRequestFeedbackScreenState {}

class LoadedDetailsRequestFeedbackState extends DetailsRequestFeedbackScreenState {
  final FeedbackRequestEntity requestEntity;

  const LoadedDetailsRequestFeedbackState({
    required this.requestEntity,
  });

  @override
  List<Object?> get props {
    return [
      ...super.props,
      requestEntity,
    ];
  }
}

class ErrorDetailsRequestFeedbackState extends DetailsRequestFeedbackScreenState {
  final String? errorMessage;

  const ErrorDetailsRequestFeedbackState({
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
