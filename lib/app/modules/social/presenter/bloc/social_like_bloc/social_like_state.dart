import 'package:equatable/equatable.dart';

import '../../../domain/entities/social_post_entity.dart';

abstract class SocialLikeState extends Equatable {
  final SocialPostEntity? likedPost;
  final List<SocialPostEntity> posts;

  const SocialLikeState({
    required this.likedPost,
    required this.posts,
  });

  @override
  List<Object?> get props => [
        likedPost,
        posts,
      ];
}

class InitialSocialLikeState extends SocialLikeState {
  const InitialSocialLikeState({required super.likedPost, required super.posts});
}

class ErrorSocialLikeState extends SocialLikeState {
  const ErrorSocialLikeState({required super.likedPost, required super.posts});
}

class LoadedSocialLikeState extends SocialLikeState {
  final bool likeIsBlocked;
  const LoadedSocialLikeState({required this.likeIsBlocked, required super.likedPost, required super.posts});
}

class LoadingSocialLikeState extends SocialLikeState {
  final bool likeIsBlocked;
  const LoadingSocialLikeState({this.likeIsBlocked = true, required super.likedPost, required super.posts});
}
