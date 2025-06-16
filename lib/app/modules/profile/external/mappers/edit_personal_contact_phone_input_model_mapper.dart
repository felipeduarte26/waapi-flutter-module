import '../../../../core/helper/enum_helper.dart';
import '../../domain/input_models/edit_personal_contact_phone_input_model.dart';

class EditPersonalContactPhoneInputModelMapper {
  Map<String, dynamic> toMap({
    required EditPersonalContactPhoneInputModel editPersonalContactPhoneInputModel,
  }) {
    return {
      'id': editPersonalContactPhoneInputModel.id,
      'employeeId': editPersonalContactPhoneInputModel.employeeId,
      'phoneContact': {
        'id': editPersonalContactPhoneInputModel.phoneContact.id,
        'type': EnumHelper()
            .enumToString(
              enumToParse: editPersonalContactPhoneInputModel.phoneContact.type!,
            )
            .toUpperCase(),
        'countryCode': editPersonalContactPhoneInputModel.phoneContact.countryCode,
        'localCode': editPersonalContactPhoneInputModel.phoneContact.localCode,
        'number': editPersonalContactPhoneInputModel.phoneContact.number,
        'provider': editPersonalContactPhoneInputModel.phoneContact.provider,
        'branch': editPersonalContactPhoneInputModel.phoneContact.branch,
        'personRequestUpdateType': editPersonalContactPhoneInputModel.phoneContact.personRequestUpdateType,
      },
      'type': editPersonalContactPhoneInputModel.type,
      'originalType': editPersonalContactPhoneInputModel.originalType,
    };
  }
}
