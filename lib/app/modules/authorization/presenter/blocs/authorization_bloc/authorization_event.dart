import 'package:equatable/equatable.dart';

abstract class AuthorizationEvent extends Equatable {
  @override
  List<Object?> get props {
    return [];
  }
}

class GetAuthorizationsEvent extends AuthorizationEvent {}

class ReloadAuthorizationsEvent extends AuthorizationEvent {}
