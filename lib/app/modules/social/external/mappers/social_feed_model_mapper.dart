import '../../infra/models/social_feed_model.dart';
import 'social_post_model_mapper.dart';

class SocialFeedModelMapper {
  SocialFeedModel fromMap({
    required Map<String, dynamic> feedMap,
  }) {
    return SocialFeedModel(
      posts: (feedMap['posts'] as List<dynamic>?)?.map(
            (post) {
              return SocialPostModelMapper().fromMap(
                postMap: post,
              );
            },
          ).toList() ??
          const [],
      fixedPost: feedMap['postFixed'] != null
          ? SocialPostModelMapper().fromMap(
              postMap: feedMap['postFixed'],
            )
          : null,
      nextCursor: feedMap['nextCursor'] ?? '',
    );
  }
}
