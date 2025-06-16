import '../../domain/entities/social_feed_entity.dart';
import '../models/social_feed_model.dart';
import 'social_post_entity_adapter.dart';
import 'social_profile_entity_adapter.dart';

class SocialFeedEntityAdapter {
  final SocialProfileEntityAdapter authorEntityAdapter;
  final SocialPostEntityAdapter postEntityAdapter;

  SocialFeedEntityAdapter({
    required this.postEntityAdapter,
    required this.authorEntityAdapter,
  });

  SocialFeedEntity fromModel({
    required SocialFeedModel feedModel,
  }) {
    return SocialFeedEntity(
      nextCursor: feedModel.nextCursor,
      fixedPost: feedModel.fixedPost != null
          ? postEntityAdapter.fromModel(
              postModel: feedModel.fixedPost!,
            )
          : null,
      posts: feedModel.posts.map(
        (post) {
          return postEntityAdapter.fromModel(
            postModel: post,
          );
        },
      ).toList(),
    );
  }
}
