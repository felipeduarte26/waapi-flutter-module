import 'package:equatable/equatable.dart';

abstract class UserRoleState extends Equatable {
  const UserRoleState();

  @override
  List<Object> get props {
    return [];
  }
}

class InitialUserRoleState extends UserRoleState {}

class LoadingUserRoleState extends UserRoleState {}

class LoadedUserRoleState extends UserRoleState {
  final String? userRoleId;

  const LoadedUserRoleState({
    required this.userRoleId,
  });
}

class ErrorUserRoleState extends UserRoleState {}
