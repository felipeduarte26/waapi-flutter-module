import '../../infra/models/social_owner_space_model.dart';

class SocialOwnerSpaceModelMapper {
  SocialOwnerSpaceModel fromMap({
    required Map<String, dynamic> map,
  }) {
    return SocialOwnerSpaceModel(
      avatarUrl: map['avatarUrl'] ?? '',
      hasAvatar: map['hasAvatar'] ?? false,
      id: map['id'],
      name: map['name'],
      permaname: map['permaname'],
    );
  }
}
