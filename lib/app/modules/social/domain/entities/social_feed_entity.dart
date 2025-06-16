import 'package:equatable/equatable.dart';

import 'social_post_entity.dart';

class SocialFeedEntity extends Equatable {
  final String nextCursor;
  final List<SocialPostEntity> posts;
  final SocialPostEntity? fixedPost;

  const SocialFeedEntity({
    required this.nextCursor,
    required this.posts,
    required this.fixedPost,
  });

  SocialFeedEntity copyWith({
    String? nextCursor,
    List<SocialPostEntity>? posts,
    SocialPostEntity? fixedPost,
  }) {
    return SocialFeedEntity(
      nextCursor: nextCursor ?? this.nextCursor,
      posts: posts ?? this.posts,
      fixedPost: fixedPost ?? this.fixedPost,
    );
  }

  @override
  List<Object?> get props {
    return [
      nextCursor,
      posts,
      fixedPost,
    ];
  }
}
