import '../../../../core/helper/enum_helper.dart';
import '../../domain/input_models/edit_personal_contact_social_network_input_model.dart';
import '../../enums/social_network_provider_enum.dart';
import '../../infra/models/social_network_model.dart';

class SocialNetworkModelMapper {
  SocialNetworkModel fromMap({
    required Map<String, dynamic> map,
  }) {
    return SocialNetworkModel(
      id: map['id'],
      profile: map['profile'],
      socialNetwork: EnumHelper<SocialNetworkProviderEnum>().stringToEnum(
        stringToParse: map['socialNetwork'],
        values: SocialNetworkProviderEnum.values,
      ),
    );
  }

  Map<String, dynamic> toMap({
    required EditPersonalContactSocialNetworkInputModel editPersonalContactSocialNetworkInputModel,
  }) {
    final map = {
      'id': editPersonalContactSocialNetworkInputModel.id,
      'profile': editPersonalContactSocialNetworkInputModel.profile,
      'socialNetwork': editPersonalContactSocialNetworkInputModel.socialNetwork,
      'socialNetworkName': editPersonalContactSocialNetworkInputModel.socialNetworkName,
      'personId': editPersonalContactSocialNetworkInputModel.personId,
    };

    if (editPersonalContactSocialNetworkInputModel.personRequestUpdateType != null) {
      map.addAll(
        {'personRequestUpdateType': editPersonalContactSocialNetworkInputModel.personRequestUpdateType!},
      );
    }

    return map;
  }
}
