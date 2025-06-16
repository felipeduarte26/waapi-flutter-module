import 'package:equatable/equatable.dart';

import '../../../domain/entities/social_feed_entity.dart';

abstract class SocialTagFeedState extends Equatable {
  final SocialFeedEntity? socialFeedEntity;

  const SocialTagFeedState({this.socialFeedEntity});

  @override
  List<Object?> get props {
    return [
      socialFeedEntity,
    ];
  }
}

class InitialSocialTagFeedState extends SocialTagFeedState {}

class LoadingSocialTagFeedState extends SocialTagFeedState {}

class LoadingMoreSocialTagFeedState extends SocialTagFeedState {
  const LoadingMoreSocialTagFeedState({required super.socialFeedEntity});
}

class EmptySocialTagFeedState extends SocialTagFeedState {}

class EmptyLoadedMoreSocialTagFeedState extends SocialTagFeedState {
  const EmptyLoadedMoreSocialTagFeedState({required super.socialFeedEntity});
}

class LoadedSocialTagFeedState extends SocialTagFeedState {
  const LoadedSocialTagFeedState({required super.socialFeedEntity});
}

class LoadedMoreSocialTagFeedState extends SocialTagFeedState {
  const LoadedMoreSocialTagFeedState({required super.socialFeedEntity});
}

class ErrorSocialTagFeedState extends SocialTagFeedState {}

class ErrorLoadedMoreSocialTagFeedState extends SocialTagFeedState {}
