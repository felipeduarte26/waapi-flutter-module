import 'package:equatable/equatable.dart';

import '../../../domain/entities/social_post_entity.dart';

abstract class SocialLikeEvent extends Equatable {}

class SetSocialLikeEvent extends SocialLikeEvent {
  final List<SocialPostEntity> posts;
  final String postId;
  final bool isLiked;

  SetSocialLikeEvent({
    required this.posts,
    required this.postId,
    required this.isLiked,
  });

  @override
  List<Object?> get props {
    return [
      posts,
      postId,
      isLiked,
    ];
  }
}
