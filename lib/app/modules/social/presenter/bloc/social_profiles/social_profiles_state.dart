import 'package:equatable/equatable.dart';

import '../../../domain/entities/social_profile_entity.dart';

abstract class SocialProfilesState extends Equatable {
  const SocialProfilesState();

  @override
  List<Object> get props => [];
}

class InitialSocialProfilesState extends SocialProfilesState {}

class LoadingSocialMyProfilesState extends SocialProfilesState {}

class LoadedSocialMyProfilesState extends SocialProfilesState {
  final List<SocialProfileEntity> profiles;

  const LoadedSocialMyProfilesState({
    required this.profiles,
  });

  @override
  List<Object> get props => [profiles];
}

class ErrorSocialMyProfilesState extends SocialProfilesState {}
