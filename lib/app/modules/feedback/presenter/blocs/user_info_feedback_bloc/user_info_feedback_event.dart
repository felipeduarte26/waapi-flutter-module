import 'package:equatable/equatable.dart';

abstract class UserInfoFeedbackEvent extends Equatable {
  @override
  List<Object?> get props {
    return [];
  }
}

class UserInfoToWriteFeedbackEvent extends UserInfoFeedbackEvent {
  final String userId;

  UserInfoToWriteFeedbackEvent({
    required this.userId,
  });

  @override
  List<Object?> get props {
    return [
      ...super.props,
      userId,
    ];
  }
}

class SelectedUserToWriteFeedbackEvent extends UserInfoFeedbackEvent {
  final String userId;

  SelectedUserToWriteFeedbackEvent({
    required this.userId,
  });

  @override
  List<Object?> get props {
    return [
      ...super.props,
      userId,
    ];
  }
}

class UnSelectedUserFeedbackEvent extends UserInfoFeedbackEvent {}

class ClearUserInfoFeedbackEvent extends UserInfoFeedbackEvent {}
