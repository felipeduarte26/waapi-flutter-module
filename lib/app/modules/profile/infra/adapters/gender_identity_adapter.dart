import '../../domain/entities/gender_identity_entity.dart';
import '../models/gender_identity_model.dart';

class GenderIdentityEntityAdapter {
  GenderIdentityEntity fromModel({
    required GenderIdentityModel genderIdentityModel,
  }) {
    return GenderIdentityEntity(
      id: genderIdentityModel.id,
      name: genderIdentityModel.name,
      sequence: genderIdentityModel.sequence,
    );
  }
}
