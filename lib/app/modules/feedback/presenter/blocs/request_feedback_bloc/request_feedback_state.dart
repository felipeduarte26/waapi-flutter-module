import 'package:equatable/equatable.dart';

abstract class RequestFeedbackState extends Equatable {
  @override
  List<Object?> get props {
    return [];
  }
}

class InitialRequestFeedbackState extends RequestFeedbackState {}

class LoadingRequestFeedbackState extends RequestFeedbackState {}

class SentRequestFeedbackState extends RequestFeedbackState {}

class ErrorRequestFeedbackState extends RequestFeedbackState {
  final String? errorMessage;

  ErrorRequestFeedbackState({
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
