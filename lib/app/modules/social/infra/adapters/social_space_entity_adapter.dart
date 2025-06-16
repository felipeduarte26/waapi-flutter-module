import '../../domain/entities/social_space_entity.dart';
import '../models/social_space_model.dart';
import 'social_owner_space_entity_adapter.dart';

class SocialSpaceEntityAdapter {
  SocialSpaceEntity fromModel({
    required SocialSpaceModel spaceModel,
  }) {
    return SocialSpaceEntity(
      name: spaceModel.name,
      permaname: spaceModel.permaname,
      createdAt: spaceModel.createdAt,
      isAdmin: spaceModel.isAdmin,
      isMember: spaceModel.isMember,
      owner: spaceModel.owner != null
          ? SocialOwnerSpaceEntityAdapter().fromModel(
              ownerModel: spaceModel.owner!,
            )
          : null,
      privacy: spaceModel.privacy,
      spaceId: spaceModel.spaceId,
      memberCount: spaceModel.memberCount,
    );
  }
}
