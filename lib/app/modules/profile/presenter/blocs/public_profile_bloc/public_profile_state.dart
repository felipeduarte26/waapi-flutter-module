import 'package:equatable/equatable.dart';

import '../../../domain/entities/public_profile_entity.dart';

abstract class PublicProfileState extends Equatable {
  const PublicProfileState();

  @override
  List<Object?> get props {
    return [];
  }
}

class InitialPublicProfileState extends PublicProfileState {}

class LoadingPublicProfileState extends PublicProfileState {}

class LoadedPublicProfileState extends PublicProfileState {
  final PublicProfileEntity publicProfileEntity;

  const LoadedPublicProfileState({
    required this.publicProfileEntity,
  });
}

class ErrorPublicProfileState extends PublicProfileState {
  final String userName;

  const ErrorPublicProfileState({
    required this.userName,
  });
}
