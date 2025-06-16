import 'dart:convert';

import '../../infra/models/social_space_model.dart';
import 'social_space_model_mapper.dart';

class SocialSpaceModelListMapper {
  final SocialSpaceModelMapper _socialSpaceModelMapper;

  SocialSpaceModelListMapper({required SocialSpaceModelMapper socialSpaceModelMapper})
      : _socialSpaceModelMapper = socialSpaceModelMapper;

  List<SocialSpaceModel> _fromMap({
    required Map<String, dynamic> map,
  }) {
    return map['spaces'] == null
        ? List.empty()
        : (map['spaces'] as List).map(
            (feedbackMap) {
              return _socialSpaceModelMapper.fromMap(
                map: feedbackMap,
              );
            },
          ).toList();
  }

  List<SocialSpaceModel> fromJson({required String json}) {
    return json.isNotEmpty
        ? _fromMap(
            map: jsonDecode(json),
          )
        : [];
  }
}
