import '../../domain/input_models/edit_personal_diversity_input_model.dart';

class EditPersonalDiversityInputModelMapper {
  Map<String, dynamic> toMap({
    required EditPersonalDiversityInputModel editPersonalDiversityInputModel,
  }) {
    return {
      'domainEntityId': editPersonalDiversityInputModel.personId,
      if (editPersonalDiversityInputModel.id != null) 'id': editPersonalDiversityInputModel.id,
      'diversity': {
        if (editPersonalDiversityInputModel.diversityId != null &&
            editPersonalDiversityInputModel.diversityId!.isNotEmpty)
          'id': editPersonalDiversityInputModel.diversityId,
        if (editPersonalDiversityInputModel.genderIdentityId != null &&
            editPersonalDiversityInputModel.genderIdentityId!.isNotEmpty)
          'genderIdentity': {'id': editPersonalDiversityInputModel.genderIdentityId},
        if (editPersonalDiversityInputModel.genderIdentityDescription != null &&
            editPersonalDiversityInputModel.genderIdentityDescription!.isNotEmpty)
          'genderIdentityDescription': editPersonalDiversityInputModel.genderIdentityDescription,
        if (editPersonalDiversityInputModel.socialNameAnswer != null &&
            editPersonalDiversityInputModel.socialNameAnswer!.isNotEmpty)
          'socialNameAnswer': editPersonalDiversityInputModel.socialNameAnswer,
        if (editPersonalDiversityInputModel.socialNameDescription != null &&
            editPersonalDiversityInputModel.socialNameDescription!.isNotEmpty)
          'socialNameDescription': editPersonalDiversityInputModel.socialNameDescription,
        if (editPersonalDiversityInputModel.sexualOrientationId != null &&
            editPersonalDiversityInputModel.sexualOrientationId!.isNotEmpty)
          'sexualOrientation': {'id': editPersonalDiversityInputModel.sexualOrientationId},
        if (editPersonalDiversityInputModel.sexualOrientationDescription != null &&
            editPersonalDiversityInputModel.sexualOrientationDescription!.isNotEmpty)
          'sexualOrientationDescription': editPersonalDiversityInputModel.sexualOrientationDescription,
        if (editPersonalDiversityInputModel.refugee != null && editPersonalDiversityInputModel.refugee!.isNotEmpty)
          'refugee': editPersonalDiversityInputModel.refugee,
      },
    };
  }
}
