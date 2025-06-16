import 'package:equatable/equatable.dart';

import '../../../domain/entities/user_info_feedback_entity.dart';

abstract class UserInfoFeedbackState extends Equatable {
  final UserInfoFeedbackEntity? userInfoFeedback;

  const UserInfoFeedbackState({
    this.userInfoFeedback,
  });

  UserInfoFeedbackState initialUserInfoFeedbackState() {
    return const InitialUserInfoFeedbackState();
  }

  UserInfoFeedbackState loadingUserInfoFeedbackState() {
    return const LoadingUserInfoFeedbackState();
  }

  UserInfoFeedbackState emptyStateUserInfoFeedbacksState() {
    return const EmptyStateUserInfoFeedbacksState();
  }

  UserInfoFeedbackState loadedUserInfoFeedbackState({
    required UserInfoFeedbackEntity userInfoFeedback,
  }) {
    return LoadedUserInfoFeedbackState(
      userInfoFeedbackEntity: userInfoFeedback,
    );
  }

  UserInfoFeedbackState loadingSelectProficiencyState() {
    return LoadingSelectProficiencyState(
      userInfoFeedbackEntity: userInfoFeedback,
    );
  }

  UserInfoFeedbackState errorUserInfoFeedbackState({
    String? message,
  }) {
    return ErrorUserInfoFeedbackState(
      message: message,
    );
  }

  UserInfoFeedbackState errorSelectUserInfoState({
    String? message,
    required String userId,
  }) {
    return ErrorSelectUserInfoFeedbackState(
      message: message,
      userId: userId,
    );
  }

  @override
  List<Object?> get props {
    return [
      userInfoFeedback,
    ];
  }
}

class InitialUserInfoFeedbackState extends UserInfoFeedbackState {
  const InitialUserInfoFeedbackState({
    UserInfoFeedbackEntity? userInfoFeedbackEntity,
  }) : super(userInfoFeedback: userInfoFeedbackEntity);
}

class LoadingUserInfoFeedbackState extends UserInfoFeedbackState {
  const LoadingUserInfoFeedbackState({
    UserInfoFeedbackEntity? userInfoFeedbackEntity,
  }) : super(userInfoFeedback: userInfoFeedbackEntity);
}

class EmptyStateUserInfoFeedbacksState extends UserInfoFeedbackState {
  const EmptyStateUserInfoFeedbacksState({
    UserInfoFeedbackEntity? userInfoFeedbackEntity,
  }) : super(userInfoFeedback: userInfoFeedbackEntity);
}

class LoadedUserInfoFeedbackState extends UserInfoFeedbackState {
  const LoadedUserInfoFeedbackState({
    UserInfoFeedbackEntity? userInfoFeedbackEntity,
  }) : super(userInfoFeedback: userInfoFeedbackEntity);
}

class LoadingSelectProficiencyState extends UserInfoFeedbackState {
  const LoadingSelectProficiencyState({
    UserInfoFeedbackEntity? userInfoFeedbackEntity,
  }) : super(userInfoFeedback: userInfoFeedbackEntity);
}

class LoadedSelectProficiencyState extends UserInfoFeedbackState {
  const LoadedSelectProficiencyState({
    required UserInfoFeedbackEntity userInfoFeedbackEntity,
  }) : super(userInfoFeedback: userInfoFeedbackEntity);
}

class ErrorUserInfoFeedbackState extends UserInfoFeedbackState {
  final String? message;

  const ErrorUserInfoFeedbackState({
    this.message,
  }) : super();

  @override
  List<Object?> get props {
    return [
      ...super.props,
      message,
    ];
  }
}

class ErrorSelectUserInfoFeedbackState extends UserInfoFeedbackState {
  final String? message;
  final String userId;

  const ErrorSelectUserInfoFeedbackState({
    this.message,
    required this.userId,
    UserInfoFeedbackEntity? userInfoFeedbackEntity,
  }) : super(userInfoFeedback: userInfoFeedbackEntity);

  @override
  List<Object?> get props {
    return [
      ...super.props,
      message,
      userId,
    ];
  }
}
