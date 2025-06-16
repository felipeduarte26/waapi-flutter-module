import '../../domain/entities/social_owner_space_entity.dart';
import '../models/social_owner_space_model.dart';

class SocialOwnerSpaceEntityAdapter {
  SocialOwnerSpaceEntity fromModel({
    required SocialOwnerSpaceModel ownerModel,
  }) {
    return SocialOwnerSpaceEntity(
      avatarUrl: ownerModel.avatarUrl,
      name: ownerModel.name,
      permaname: ownerModel.permaname,
      hasAvatar: ownerModel.hasAvatar,
      id: ownerModel.id,
    );
  }
}
