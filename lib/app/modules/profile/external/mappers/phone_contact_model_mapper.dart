import '../../../../core/helper/enum_helper.dart';
import '../../domain/input_models/edit_personal_contact_phone_input_model.dart';
import '../../enums/phone_contact_type_enum.dart';
import '../../infra/models/phone_contact_model.dart';

class PhoneContactModelMapper {
  PhoneContactModel fromMap({
    required Map<String, dynamic> map,
  }) {
    return PhoneContactModel(
      id: map['id'],
      branch: map['branch'],
      countryCode: map['countryCode'] is num ? map['countryCode'] : null,
      localCode: map['localCode'] is num ? map['localCode'] : null,
      number: map['number'],
      provider: map['provider'],
      type: EnumHelper<PhoneContactTypeEnum>().stringToEnum(
        stringToParse: map['type'],
        values: PhoneContactTypeEnum.values,
      ),
      personRequestUpdateType: map['personRequestUpdateType'],
    );
  }

  Map<String, dynamic> toMap({
    required EditPersonalContactPhoneInputModel editPersonalContactPhoneInputModel,
  }) {
    final phoneContact = {
      'id': editPersonalContactPhoneInputModel.phoneContact.id,
      'branch': editPersonalContactPhoneInputModel.phoneContact.branch,
      'countryCode': editPersonalContactPhoneInputModel.phoneContact.countryCode,
      'localCode': editPersonalContactPhoneInputModel.phoneContact.localCode,
      'number': editPersonalContactPhoneInputModel.phoneContact.number,
      'provider': editPersonalContactPhoneInputModel.phoneContact.provider,
      'type': EnumHelper()
          .enumToString(
            enumToParse: editPersonalContactPhoneInputModel.phoneContact.type,
          )
          .toUpperCase(),
    };

    if (editPersonalContactPhoneInputModel.phoneContact.personRequestUpdateType != null) {
      phoneContact.addAll(
        {'personRequestUpdateType': editPersonalContactPhoneInputModel.phoneContact.personRequestUpdateType!},
      );
    }

    final map = {
      'id': editPersonalContactPhoneInputModel.id,
      'employeeId': editPersonalContactPhoneInputModel.employeeId,
      'type': editPersonalContactPhoneInputModel.type,
      'phoneContact': phoneContact,
      'originalType': editPersonalContactPhoneInputModel.originalType,
    };

    return map;
  }
}
