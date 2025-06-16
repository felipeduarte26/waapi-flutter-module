import 'package:equatable/equatable.dart';

import '../../../../../core/pagination/pagination_requirements.dart';
import '../../../domain/entities/social_feed_entity.dart';

abstract class SocialFeedEvent extends Equatable {}

class GetSocialFeedEvent extends SocialFeedEvent {
  final String nextCursor;
  final PaginationRequirements paginationRequirements;
  final DateTime since;
  final String? space;
  final String? tag;
  final SocialFeedEntity? socialFeedEntity;

  GetSocialFeedEvent({
    required this.nextCursor,
    required this.paginationRequirements,
    required this.since,
    this.space,
    this.tag,
    this.socialFeedEntity,
  });

  @override
  List<Object?> get props {
    return [
      nextCursor,
      paginationRequirements,
      since,
      space,
      tag,
      socialFeedEntity,
    ];
  }
}

class SetSocialPostLikeEvent extends SocialFeedEvent {
  final String postId;
  final bool isLiked;

  SetSocialPostLikeEvent({
    required this.postId,
    required this.isLiked,
  });

  @override
  List<Object?> get props {
    return [
      postId,
      isLiked,
    ];
  }
}

class SharePostForMemberEvent extends SocialFeedEvent {
  final String postId;
  final List<String> membersId;

  SharePostForMemberEvent({
    required this.postId,
    required this.membersId,
  });

  @override
  List<Object?> get props {
    return [
      postId,
      membersId,
    ];
  }
}
