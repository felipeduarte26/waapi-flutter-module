import '../../domain/input_models/edit_personal_contact_dto_input_model.dart';
import 'email_model_mapper.dart';
import 'phone_contact_model_mapper.dart';
import 'social_network_model_mapper.dart';

class EditPersonalContactDtoInputModelMapper {
  Map<String, dynamic> toMap({
    required EditPersonalContactDtoInputModel editPersonalContactDtoInputModel,
  }) {
    return {
      'employeeId': editPersonalContactDtoInputModel.employeeId,
      'isRealData': editPersonalContactDtoInputModel.isRealData,
      'commentary': editPersonalContactDtoInputModel.commentary,
      'socialNetworks':
          editPersonalContactDtoInputModel.socialNetworks.map((editPersonalContactSocialNetworkInputModel) {
        return SocialNetworkModelMapper().toMap(
          editPersonalContactSocialNetworkInputModel: editPersonalContactSocialNetworkInputModel,
        );
      }).toList(),
      'personPhone': editPersonalContactDtoInputModel.personPhone.map((editPersonalContactPhoneInputModel) {
        return PhoneContactModelMapper().toMap(
          editPersonalContactPhoneInputModel: editPersonalContactPhoneInputModel,
        );
      }).toList(),
      'employeePhone': editPersonalContactDtoInputModel.employeePhone.map((editPersonalContactPhoneInputModel) {
        return PhoneContactModelMapper().toMap(
          editPersonalContactPhoneInputModel: editPersonalContactPhoneInputModel,
        );
      }).toList(),
      'personEmail': editPersonalContactDtoInputModel.personEmail.map((editPersonalContactEmailInputModel) {
        return EmailModelMapper().toMap(
          editPersonalContactEmailInputModel: editPersonalContactEmailInputModel,
        );
      }).toList(),
      'employeeEmail': editPersonalContactDtoInputModel.employeeEmail.map((editPersonalContactEmailInputModel) {
        return EmailModelMapper().toMap(
          editPersonalContactEmailInputModel: editPersonalContactEmailInputModel,
        );
      }).toList(),
    };
  }
}
