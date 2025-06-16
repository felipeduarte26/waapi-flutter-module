import 'package:equatable/equatable.dart';

abstract class FeedbackRequestsEvent extends Equatable {
  @override
  List<Object?> get props {
    return [];
  }
}

class GetFeedbackRequestsEvent extends FeedbackRequestsEvent {}

class ReloadListFeedbackRequestsEvent extends FeedbackRequestsEvent {}
