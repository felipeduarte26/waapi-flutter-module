import '../../domain/entities/social_profile_entity.dart';
import '../models/social_profile_model.dart';
import 'social_space_entity_adapter.dart';

class SocialProfileEntityAdapter {
  SocialProfileEntity fromModel({
    required SocialProfileModel authorModel,
  }) {
    return SocialProfileEntity(
      avatarUrl: authorModel.avatarUrl,
      id: authorModel.id,
      name: authorModel.name,
      permaname: authorModel.permaname,
      hasAvatar: authorModel.hasAvatar,
      profileType: authorModel.profileType,
      spaces: authorModel.spaces?.map((e) => SocialSpaceEntityAdapter().fromModel(spaceModel: e)).toList(),
      tags: authorModel.tags,
    );
  }
}
