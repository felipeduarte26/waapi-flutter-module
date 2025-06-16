import '../../domain/entities/social_search_content_entity.dart';
import '../models/social_search_content_model.dart';
import 'social_post_entity_adapter.dart';
import 'social_profile_entity_adapter.dart';

class SocialSearchContentEntityAdapter {
  final SocialPostEntityAdapter socialPostEntityAdapter;
  final SocialProfileEntityAdapter socialProfileEntityAdapter;

  SocialSearchContentEntityAdapter({
    required this.socialPostEntityAdapter,
    required this.socialProfileEntityAdapter,
  });

  SocialSearchContentEntity fromModel({
    required SocialSearchContentModel socialSearchContentModel,
  }) {
    return SocialSearchContentEntity(
      posts: socialSearchContentModel.posts.map(
        (post) {
          return socialPostEntityAdapter.fromModel(
            postModel: post,
          );
        },
      ).toList(),
      tags: socialSearchContentModel.tags,
      profiles: socialSearchContentModel.profiles.map(
        (profile) {
          return socialProfileEntityAdapter.fromModel(
            authorModel: profile,
          );
        },
      ).toList(),
    );
  }
}
