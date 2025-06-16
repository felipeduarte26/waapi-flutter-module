import 'dart:convert';

import '../../infra/models/social_post_model.dart';
import 'social_post_model_mapper.dart';

class SocialPostModelListMapper {
  final SocialPostModelMapper _socialPostModelMapper;

  const SocialPostModelListMapper({
    required SocialPostModelMapper socialPostModelMapper,
  }) : _socialPostModelMapper = socialPostModelMapper;

  List<SocialPostModel> _fromMap({
    required Map<String, dynamic> map,
  }) {
    return map['posts'] == null
        ? List.empty()
        : (map['posts'] as List).map(
            (postMap) {
              return _socialPostModelMapper.fromMap(
                postMap: postMap,
              );
            },
          ).toList();
  }

  List<SocialPostModel> fromJson({
    required String json,
  }) {
    return json.isNotEmpty
        ? _fromMap(
            map: jsonDecode(json),
          )
        : [];
  }
}
