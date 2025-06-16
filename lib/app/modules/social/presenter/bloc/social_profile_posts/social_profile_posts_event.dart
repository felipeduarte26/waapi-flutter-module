import 'package:equatable/equatable.dart';

import '../../../domain/entities/social_post_entity.dart';
import '../../../domain/entities/social_profile_entity.dart';

abstract class SocialProfilePostsEvent extends Equatable {}

class GetSocialProfilePostsEvent extends SocialProfilePostsEvent {
  final String permaname;
  final String? lastSeenId;
  final List<SocialPostEntity> socialPostsEntity;
  final SocialProfileEntity? socialProfileEntity;

  GetSocialProfilePostsEvent({
    required this.permaname,
    this.lastSeenId,
    required this.socialPostsEntity,
    this.socialProfileEntity,
  });

  @override
  List<Object?> get props {
    return [
      permaname,
      lastSeenId,
      socialPostsEntity,
      socialProfileEntity,
    ];
  }
}
