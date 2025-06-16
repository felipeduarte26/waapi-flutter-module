import 'package:equatable/equatable.dart';

import '../../../domain/entities/social_profile_entity.dart';

abstract class SocialCurrentProfileState extends Equatable {
  const SocialCurrentProfileState();

  @override
  List<Object> get props => [];
}

class InitialSocialCurrentProfileState extends SocialCurrentProfileState {}

class LoadingSocialCurrentProfileState extends SocialCurrentProfileState {}

class LoadedSocialCurrentProfileState extends SocialCurrentProfileState {
  final SocialProfileEntity profile;

  const LoadedSocialCurrentProfileState({
    required this.profile,
  });

  @override
  List<Object> get props => [profile];
}

class ErrorSocialCurrentProfileState extends SocialCurrentProfileState {}
