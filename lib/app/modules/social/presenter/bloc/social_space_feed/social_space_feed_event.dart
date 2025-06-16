import 'package:equatable/equatable.dart';

import '../../../domain/entities/social_feed_entity.dart';
import '../../../domain/entities/social_space_entity.dart';

abstract class SocialSpaceFeedEvent extends Equatable {}

class GetSocialSpaceFeedEvent extends SocialSpaceFeedEvent {
  final String spacePermaname;
  final DateTime since;
  final SocialFeedEntity? socialFeedEntity;
  final SocialSpaceEntity? space;

  GetSocialSpaceFeedEvent({
    required this.spacePermaname,
    required this.since,
    this.socialFeedEntity,
    this.space,
  });

  @override
  List<Object?> get props {
    return [
      spacePermaname,
      socialFeedEntity,
      space,
    ];
  }
}
