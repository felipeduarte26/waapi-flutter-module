import 'package:equatable/equatable.dart';

abstract class FeedbackPersonState extends Equatable {
  const FeedbackPersonState();

  @override
  List<Object> get props {
    return [];
  }
}

class InitialFeedbackPersonState extends FeedbackPersonState {}

class LoadingFeedbackPersonState extends FeedbackPersonState {}

class LoadedFeedbackPersonState extends FeedbackPersonState {
  final String personId;

  const LoadedFeedbackPersonState({
    required this.personId,
  });
}

class ErrorFeedbackPersonState extends FeedbackPersonState {}
