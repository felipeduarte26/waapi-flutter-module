import '../../domain/entities/education_degree_entity.dart';
import '../../domain/entities/ethnicity_entity.dart';
import '../../domain/entities/profile_person_entity.dart';
import '../models/profile_person_model.dart';

class ProfilePersonEntityAdapter {
  ProfilePersonEntity fromModel({
    required ProfilePersonModel personModel,
  }) {
    return ProfilePersonEntity(
      birthDate: personModel.birthDate,
      ethnicity: personModel.ethnicity != null
          ? EthnicityEntity(
              id: personModel.ethnicity!.id,
              name: personModel.ethnicity!.name,
              code: personModel.ethnicity!.code,
            )
          : null,
      educationDegree: personModel.educationDegree != null
          ? EducationDegreeEntity(
              code: personModel.educationDegree!.code,
              name: personModel.educationDegree!.name,
              id: personModel.educationDegree!.id,
              type: personModel.educationDegree!.type,
            )
          : null,
    );
  }
}
