import 'package:equatable/equatable.dart';

import '../../../domain/entities/social_feed_entity.dart';

abstract class SocialTagFeedEvent extends Equatable {}

class GetSocialTagFeedEvent extends SocialTagFeedEvent {
  final String tag;
  final DateTime since;
  final SocialFeedEntity? socialFeedEntity;

  GetSocialTagFeedEvent({
    required this.tag,
    required this.since,
    this.socialFeedEntity,
  });

  @override
  List<Object?> get props {
    return [
      tag,
      since,
      socialFeedEntity,
    ];
  }
}
