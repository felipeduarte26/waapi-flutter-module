import 'package:equatable/equatable.dart';

import '../../../domain/entities/social_profile_entity.dart';

abstract class SocialPostLikesState extends Equatable {
  final List<SocialProfileEntity>? profilesThatLiked;

  const SocialPostLikesState({
    this.profilesThatLiked = const <SocialProfileEntity>[],
  });

  ErrorSocialPostLikesState errorSocialPostLikesState() {
    return ErrorSocialPostLikesState(
      profilesThatLiked: profilesThatLiked!,
    );
  }

  InitialSocialPostLikesState initialSocialPostLikesState() {
    return InitialSocialPostLikesState();
  }

  ErrorLoadingMoreSocialPostLikesState errorLoadingMoreSocialPostLikesState() {
    return ErrorLoadingMoreSocialPostLikesState(profilesThatLiked: profilesThatLiked!);
  }

  LoadingSocialPostLikesState loadingSocialPostLikesState() {
    return LoadingSocialPostLikesState();
  }

  LoadingMoreSocialPostLikesState loadingMoreSocialPostLikesState() {
    return LoadingMoreSocialPostLikesState(
      profilesThatLiked: profilesThatLiked!,
    );
  }

  LastPageSocialPostLikesState lastPageSocialPostLikesState({
    required List<SocialProfileEntity> profilesThatLiked,
  }) {
    return LastPageSocialPostLikesState(
      profilesThatLiked: profilesThatLiked,
    );
  }

  LoadedSocialPostLikesState loadedPageSocialPostLikesState({
    required List<SocialProfileEntity> profilesThatLiked,
  }) {
    return LoadedSocialPostLikesState(
      profilesThatLiked: profilesThatLiked,
    );
  }

  @override
  List<Object?> get props {
    return [
      profilesThatLiked,
    ];
  }
}

class InitialSocialPostLikesState extends SocialPostLikesState {}

class LoadingSocialPostLikesState extends SocialPostLikesState {}

class ErrorSocialPostLikesState extends SocialPostLikesState {
  const ErrorSocialPostLikesState({
    required List<SocialProfileEntity> profilesThatLiked,
  }) : super(profilesThatLiked: profilesThatLiked);
}

class ErrorLoadingMoreSocialPostLikesState extends SocialPostLikesState {
  const ErrorLoadingMoreSocialPostLikesState({
    required List<SocialProfileEntity> profilesThatLiked,
  }) : super(profilesThatLiked: profilesThatLiked);
}

class LoadingMoreSocialPostLikesState extends SocialPostLikesState {
  const LoadingMoreSocialPostLikesState({
    required List<SocialProfileEntity> profilesThatLiked,
  }) : super(profilesThatLiked: profilesThatLiked);
}

class LastPageSocialPostLikesState extends SocialPostLikesState {
  const LastPageSocialPostLikesState({
    required List<SocialProfileEntity> profilesThatLiked,
  }) : super(profilesThatLiked: profilesThatLiked);
}

class LoadedSocialPostLikesState extends SocialPostLikesState {
  const LoadedSocialPostLikesState({
    required List<SocialProfileEntity> profilesThatLiked,
  }) : super(profilesThatLiked: profilesThatLiked);
}
