import 'dart:convert';

import '../../infra/models/social_post_model.dart';
import '../../infra/models/social_profile_model.dart';
import '../../infra/models/social_search_content_model.dart';
import 'social_post_model_mapper.dart';
import 'social_profile_model_mapper.dart';

class SocialSearchContentModelMapper {
  SocialSearchContentModel fromMap({
    required Map<String, dynamic> map,
  }) {
    return SocialSearchContentModel(
      posts: map['posts']
          .map<SocialPostModel>(
            (map) => SocialPostModelMapper().fromMap(postMap: map),
          )
          .toList(),
      tags: (map['tags'] != null && (map['tags'] as List<dynamic>).isNotEmpty)
          ? List<String>.from(
              map['tags'],
            )
          : [],
      profiles: map['profiles']
          .map<SocialProfileModel>(
            (profileMap) => SocialProfileModelMapper().fromMap(
              authorMap: profileMap,
            ),
          )
          ?.toList(),
    );
  }

  SocialSearchContentModel fromJson({
    required String searchContentjson,
  }) {
    return fromMap(
      map: jsonDecode(searchContentjson),
    );
  }
}
