import '../../domain/input_models/edit_personal_contact_social_network_input_model.dart';

class EditPersonalContactSocialNetworkInputModelMapper {
  Map<String, dynamic> toMap({
    required EditPersonalContactSocialNetworkInputModel editPersonalContactSocialNetworkInputModel,
  }) {
    return {
      'id': editPersonalContactSocialNetworkInputModel.id,
      'personId': editPersonalContactSocialNetworkInputModel.personId,
      'socialNetwork': editPersonalContactSocialNetworkInputModel.socialNetwork,
      'socialNetworkName': editPersonalContactSocialNetworkInputModel.socialNetworkName,
      'profile': editPersonalContactSocialNetworkInputModel.profile,
      'personRequestUpdateType': editPersonalContactSocialNetworkInputModel.personRequestUpdateType,
    };
  }
}
