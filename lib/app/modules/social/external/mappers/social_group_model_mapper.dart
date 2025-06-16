import '../../infra/models/social_group_model.dart';
import 'social_profile_model_mapper.dart';

class SocialGroupModelMapper {
  SocialGroupModel fromMap({
    required Map<String, dynamic> map,
  }) {
    return SocialGroupModel(
      id: map['id'],
      profiles: map['profiles'] != null
          ? (map['profiles'] as List).map(
              (profile) {
                return SocialProfileModelMapper().fromMap(
                  authorMap: profile,
                );
              },
            ).toList()
          : null,
      name: map['name'],
      permaname: map['permaname'],
      isSpaceGroup: map['isSpaceGroup'] ?? false,
    );
  }
}
