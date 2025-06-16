import 'package:equatable/equatable.dart';

import '../../../domain/entities/social_space_entity.dart';

abstract class SocialSpacesState extends Equatable {
  const SocialSpacesState();

  @override
  List<Object> get props => [];
}

class InitialSocialSpacesState extends SocialSpacesState {}

class LoadingSocialSpacesState extends SocialSpacesState {}

class LoadedSocialSpacesState extends SocialSpacesState {
  final List<SocialSpaceEntity> socialSpaces;

  const LoadedSocialSpacesState({
    required this.socialSpaces,
  });

  @override
  List<Object> get props => [
        socialSpaces,
      ];
}

class ErrorSocialSpacesState extends SocialSpacesState {}

class LoadedMoreSocialSpacesState extends SocialSpacesState {
  final List<SocialSpaceEntity> socialSpaces;

  const LoadedMoreSocialSpacesState({
    required this.socialSpaces,
  });

  @override
  List<Object> get props => [
        socialSpaces,
      ];
}
