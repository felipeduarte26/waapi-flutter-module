import 'package:equatable/equatable.dart';

import '../../../domain/entities/social_feed_entity.dart';

abstract class SocialFeedState extends Equatable {
  final SocialFeedEntity socialFeedEntity;

  const SocialFeedState({
    this.socialFeedEntity = const SocialFeedEntity(
      nextCursor: '',
      posts: [],
      fixedPost: null,
    ),
  });

  @override
  List<Object?> get props {
    return [
      socialFeedEntity,
    ];
  }
}

class InitialSocialFeedState extends SocialFeedState {}

class LoadingSocialFeedState extends SocialFeedState {
  const LoadingSocialFeedState({required super.socialFeedEntity});
}

class LoadingMoreSocialFeedState extends SocialFeedState {
  const LoadingMoreSocialFeedState({required super.socialFeedEntity});
}

class EmptySocialFeedState extends SocialFeedState {
  const EmptySocialFeedState({required super.socialFeedEntity});
}

class EmptyLoadedMoreSocialFeedState extends SocialFeedState {
  const EmptyLoadedMoreSocialFeedState({required super.socialFeedEntity});
}

class LoadedSocialFeedState extends SocialFeedState {
  const LoadedSocialFeedState({
    required SocialFeedEntity socialFeedEntity,
  }) : super(socialFeedEntity: socialFeedEntity);
}

class LoadedMoreSocialFeedState extends SocialFeedState {
  const LoadedMoreSocialFeedState({
    required SocialFeedEntity socialFeedEntity,
  }) : super(socialFeedEntity: socialFeedEntity);
}

class ErrorSocialFeedState extends SocialFeedState {
  const ErrorSocialFeedState({required super.socialFeedEntity});
}

class ErrorLoadedMoreSocialFeedState extends SocialFeedState {
  const ErrorLoadedMoreSocialFeedState({required super.socialFeedEntity});
}

class ErrorSocialSharedPostState extends SocialFeedState {
  final String postId;
  final List<String> membersId;

  const ErrorSocialSharedPostState({
    required this.postId,
    required this.membersId,
    required SocialFeedEntity socialFeedEntity,
  }) : super(socialFeedEntity: socialFeedEntity);

  @override
  List<Object> get props => [
        postId,
        membersId,
      ];
}

class LoadingSocialSharedPostState extends SocialFeedState {
  const LoadingSocialSharedPostState({required super.socialFeedEntity});
}

class LoadedSocialSharedPostState extends SocialFeedState {
  const LoadedSocialSharedPostState({
    required SocialFeedEntity socialFeedEntity,
  }) : super(socialFeedEntity: socialFeedEntity);
}
