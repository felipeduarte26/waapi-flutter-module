import 'package:equatable/equatable.dart';

import '../../../domain/entities/authorization_entity.dart';

abstract class AuthorizationState extends Equatable {
  @override
  List<Object?> get props {
    return [];
  }
}

class InitialAuthorizationState extends AuthorizationState {}

class LoadingAuthorizationState extends AuthorizationState {}

class LoadedAuthorizationState extends AuthorizationState {
  final AuthorizationEntity authorizationEntity;

  LoadedAuthorizationState({
    required this.authorizationEntity,
  });

  @override
  List<Object?> get props {
    return [
      authorizationEntity,
    ];
  }
}

class ErrorAuthorizationState extends AuthorizationState {
  final String? message;

  ErrorAuthorizationState({
    this.message,
  });

  @override
  List<Object?> get props {
    return [
      message,
    ];
  }
}
