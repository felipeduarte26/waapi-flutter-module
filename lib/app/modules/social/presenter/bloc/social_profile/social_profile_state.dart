import 'package:equatable/equatable.dart';

import '../../../domain/entities/social_profile_entity.dart';

abstract class SocialProfileState extends Equatable {
  final SocialProfileEntity socialProfileEntity;

  const SocialProfileState({
    this.socialProfileEntity = const SocialProfileEntity(
      id: '',
      name: '',
      permaname: '',
    ),
  });

  @override
  List<Object?> get props {
    return [
      socialProfileEntity,
    ];
  }
}

class InitialSocialProfileState extends SocialProfileState {}

class LoadingSocialProfileState extends SocialProfileState {}

class LoadedSocialProfileState extends SocialProfileState {
  const LoadedSocialProfileState({
    required SocialProfileEntity socialProfileEntity,
  }) : super(socialProfileEntity: socialProfileEntity);
}

class ErrorSocialProfileState extends SocialProfileState {}

class EmptySocialProfileState extends SocialProfileState {}
