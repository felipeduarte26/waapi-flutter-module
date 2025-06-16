import '../../domain/entities/social_network_entity.dart';
import '../models/social_network_model.dart';

class SocialNetworkEntityAdapter {
  SocialNetworkEntity fromModel({
    required SocialNetworkModel socialNetworkModel,
  }) {
    return SocialNetworkEntity(
      id: socialNetworkModel.id,
      profile: socialNetworkModel.profile,
      socialNetwork: socialNetworkModel.socialNetwork,
    );
  }
}
