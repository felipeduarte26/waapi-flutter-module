import '../../../../core/helper/enum_helper.dart';
import '../../domain/input_models/emergencial_contact_input_model.dart';
import '../../enums/gender_type_enum.dart';
import '../../enums/personal_relationship_enum.dart';
import 'phone_contact_input_model_mapper.dart';

class EmergencialContactInputModelMapper {
  Map<String, dynamic> toMap({
    required EmergencialContactInputModel emergencialContactInputModel,
  }) {
    return {
      'name': emergencialContactInputModel.name,
      'genderType': emergencialContactInputModel.genderTypeEnum == null
          ? null
          : EnumHelper<GenderTypeEnum>().enumToString(
              enumToParse: emergencialContactInputModel.genderTypeEnum!,
            ),
      'relationship': emergencialContactInputModel.emergencialContactRelationshipEnum == null
          ? null
          : EnumHelper<PersonalRelationshipEnum>().enumToString(
              enumToParse: emergencialContactInputModel.emergencialContactRelationshipEnum!,
            ),
      'phone': PhoneContactInputModelMapper().toMap(
        phoneContactInputModel: emergencialContactInputModel.phoneContactInputModel!,
      ),
    };
  }
}
