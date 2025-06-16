import '../../domain/entities/diversity_entity.dart';
import '../../domain/entities/diversity_person_entity.dart';
import '../models/diversity_model.dart';
import 'gender_identity_adapter.dart';
import 'sexual_orientation_adapter.dart';

class DiversityEntityAdapter {
  DiversityEntity fromModel({
    required DiversityModel diversityModel,
  }) {
    return DiversityEntity(
      id: diversityModel.id,
      personId: diversityModel.personId,
      diversity: diversityModel.diversity != null
          ? DiversityPersonEntity(
              id: diversityModel.diversity!.id,
              genderIdentityDescription: diversityModel.diversity!.genderIdentityDescription,
              genderIdentity: diversityModel.diversity!.genderIdentity != null
                  ? GenderIdentityEntityAdapter().fromModel(
                      genderIdentityModel: diversityModel.diversity!.genderIdentity!,
                    )
                  : null,
              sexualOrientationDescription: diversityModel.diversity?.sexualOrientationDescription,
              socialNameDescription: diversityModel.diversity?.socialNameDescription,
              refugee: diversityModel.diversity?.refugee,
              socialNameAnswer: diversityModel.diversity?.socialNameAnswer,
              sexualOrientation: diversityModel.diversity!.sexualOrientation != null
                  ? SexualOrientationEntityAdapter().fromModel(
                      sexualOrientationModel: diversityModel.diversity!.sexualOrientation!,
                    )
                  : null,
            )
          : null,
    );
  }
}
