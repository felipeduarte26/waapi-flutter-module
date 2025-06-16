import 'package:equatable/equatable.dart';

import '../../../domain/entities/social_feed_entity.dart';
import '../../../domain/entities/social_space_entity.dart';

abstract class SocialSpaceFeedState extends Equatable {
  final SocialFeedEntity socialFeedEntity;
  final SocialSpaceEntity? space;

  const SocialSpaceFeedState({
    this.socialFeedEntity = const SocialFeedEntity(
      nextCursor: '',
      posts: [],
      fixedPost: null,
    ),
    this.space,
  });

  @override
  List<Object?> get props {
    return [
      socialFeedEntity,
      space,
    ];
  }
}

class InitialSocialSpaceFeedState extends SocialSpaceFeedState {}

class LoadingSocialSpaceFeedState extends SocialSpaceFeedState {
  const LoadingSocialSpaceFeedState({
    super.socialFeedEntity,
    super.space,
  });
}

class LoadingMoreSocialSpaceFeedState extends SocialSpaceFeedState {
  const LoadingMoreSocialSpaceFeedState({
    required super.socialFeedEntity,
    super.space,
  });
}

class EmptySocialSpaceFeedState extends SocialSpaceFeedState {
  const EmptySocialSpaceFeedState({
    super.socialFeedEntity,
    super.space,
  });
}

class EmptyLoadedMoreSocialSpaceFeedState extends SocialSpaceFeedState {
  const EmptyLoadedMoreSocialSpaceFeedState({
    required super.socialFeedEntity,
    super.space,
  });
}

class LoadedSocialSpaceFeedState extends SocialSpaceFeedState {
  const LoadedSocialSpaceFeedState({
    required super.socialFeedEntity,
    super.space,
  });
}

class LoadedMoreSocialSpaceFeedState extends SocialSpaceFeedState {
  const LoadedMoreSocialSpaceFeedState({
    required super.socialFeedEntity,
    super.space,
  });
}

class ErrorSocialSpaceFeedState extends SocialSpaceFeedState {
  const ErrorSocialSpaceFeedState({
    super.socialFeedEntity,
    super.space,
  });
}

class ErrorLoadedMoreSocialSpaceFeedState extends SocialSpaceFeedState {
  const ErrorLoadedMoreSocialSpaceFeedState({
    required super.socialFeedEntity,
    super.space,
  });
}
