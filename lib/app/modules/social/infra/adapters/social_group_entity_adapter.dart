import '../../domain/entities/social_group_entity.dart';
import '../models/social_group_model.dart';
import 'social_profile_entity_adapter.dart';

class SocialGroupEntityAdapter {
  SocialGroupEntity fromModel({
    required SocialGroupModel model,
  }) {
    return SocialGroupEntity(
      id: model.id,
      name: model.name,
      permaname: model.permaname,
      profiles: model.profiles?.map(
        (profile) {
          return SocialProfileEntityAdapter().fromModel(authorModel: profile);
        },
      ).toList(),
      isSpaceGroup: model.isSpaceGroup,
    );
  }
}
