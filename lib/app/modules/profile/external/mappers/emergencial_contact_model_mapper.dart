import '../../../../core/helper/enum_helper.dart';
import '../../enums/gender_type_enum.dart';
import '../../enums/personal_relationship_enum.dart';
import '../../infra/models/emergencial_contact_model.dart';
import 'phone_contact_model_mapper.dart';

class EmergencialContactModelMapper {
  EmergencialContactModel fromMap({
    required Map<String, dynamic> map,
  }) {
    return EmergencialContactModel(
      id: map['id'],
      name: map['name'],
      genderType: EnumHelper<GenderTypeEnum>().stringToEnum(
        stringToParse: map['genderType'],
        values: GenderTypeEnum.values,
      ),
      relationship: EnumHelper<PersonalRelationshipEnum>().stringToEnum(
        stringToParse: map['relationship'],
        values: PersonalRelationshipEnum.values,
      ),
      phoneContact: map['phone'] != null
          ? PhoneContactModelMapper().fromMap(
              map: map['phone'],
            )
          : null,
    );
  }
}
