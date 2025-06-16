import 'package:equatable/equatable.dart';

import '../../../domain/entities/social_post_entity.dart';
import '../../../domain/entities/social_profile_entity.dart';

abstract class SocialProfilePostsState extends Equatable {
  final List<SocialPostEntity> socialPostsEntity;
  final SocialProfileEntity? socialProfileEntity;

  const SocialProfilePostsState({
    this.socialPostsEntity = const [],
    this.socialProfileEntity,
  });

  @override
  List<Object?> get props {
    return [
      socialPostsEntity,
    ];
  }
}

class InitialSocialProfilePostsState extends SocialProfilePostsState {}

class LoadingSocialProfilePostsState extends SocialProfilePostsState {
  const LoadingSocialProfilePostsState({required super.socialPostsEntity});
}

class LoadingMoreSocialProfilePostsState extends SocialProfilePostsState {
  const LoadingMoreSocialProfilePostsState({
    required super.socialPostsEntity,
    super.socialProfileEntity,
  });
}

class EmptySocialProfilePostsState extends SocialProfilePostsState {
  const EmptySocialProfilePostsState({required super.socialPostsEntity});
}

class EmptyLoadedMoreSocialProfilePostsState extends SocialProfilePostsState {
  const EmptyLoadedMoreSocialProfilePostsState({
    required super.socialPostsEntity,
    super.socialProfileEntity,
  });
}

class LoadedSocialProfilePostsState extends SocialProfilePostsState {
  const LoadedSocialProfilePostsState({
    required super.socialPostsEntity,
    super.socialProfileEntity,
  });
}

class LoadedMoreSocialProfilePostsState extends SocialProfilePostsState {
  const LoadedMoreSocialProfilePostsState({
    required super.socialPostsEntity,
    super.socialProfileEntity,
  });
}

class ErrorSocialProfilePostsState extends SocialProfilePostsState {
  const ErrorSocialProfilePostsState({required super.socialPostsEntity});
}

class ErrorLoadedMoreSocialProfilePostsState extends SocialProfilePostsState {
  const ErrorLoadedMoreSocialProfilePostsState({required super.socialPostsEntity});
}
