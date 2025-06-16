import 'package:equatable/equatable.dart';

import 'social_post_model.dart';

class SocialFeedModel extends Equatable {
  final String nextCursor;
  final List<SocialPostModel> posts;
  final SocialPostModel? fixedPost;

  const SocialFeedModel({
    required this.nextCursor,
    required this.posts,
    required this.fixedPost,
  });

  @override
  List<Object?> get props {
    return [
      nextCursor,
      posts,
      fixedPost,
    ];
  }
}
