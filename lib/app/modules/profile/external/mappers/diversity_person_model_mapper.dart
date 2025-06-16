import '../../../../core/helper/enum_helper.dart';
import '../../enums/refugee_answer_enum.dart';
import '../../enums/social_name_answer_enum.dart';
import '../../infra/models/diversity_person_model.dart';
import '../../infra/models/gender_identity_model.dart';
import '../../infra/models/sexual_orientation_model.dart';
import 'gender_identity_mapper.dart';
import 'sexual_orientation_mapper.dart';

class DiversityPersonModelMapper {
  DiversityPersonModel fromMap({
    required Map<String, dynamic> map,
  }) {
    return DiversityPersonModel(
      id: map['id'],
      genderIdentityDescription: map['genderIdentityDescription'],
      refugee: EnumHelper<RefugeeAnswerEnum>().stringToEnum(
        stringToParse: map['refugee'],
        values: RefugeeAnswerEnum.values,
      ),
      sexualOrientationDescription: map['sexualOrientationDescription'],
      socialNameDescription: map['socialNameDescription'],
      genderIdentity: map['genderIdentity'] != null
          ? genderIdentityModel(
              map: map['genderIdentity'],
            )
          : null,
      socialNameAnswer: EnumHelper<SocialNameAnswerEnum>().stringToEnum(
        stringToParse: map['socialNameAnswer'],
        values: SocialNameAnswerEnum.values,
      ),
      sexualOrientation: map['sexualOrientation'] != null
          ? sexualOrientationModel(
              map: map['sexualOrientation'],
            )
          : null,
    );
  }

  GenderIdentityModel? genderIdentityModel({
    required Map<String, dynamic>? map,
  }) {
    return map != null
        ? GenderIdentityModelMapper().fromMap(
            map: map,
          )
        : null;
  }

  SexualOrientationModel? sexualOrientationModel({
    required Map<String, dynamic>? map,
  }) {
    return map != null
        ? SexualOrientationModelMapper().fromMap(
            map: map,
          )
        : null;
  }
}
