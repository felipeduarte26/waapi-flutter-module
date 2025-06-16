import '../../domain/entities/sexual_orientation_entity.dart';
import '../models/sexual_orientation_model.dart';

class SexualOrientationEntityAdapter {
  SexualOrientationEntity fromModel({
    required SexualOrientationModel sexualOrientationModel,
  }) {
    return SexualOrientationEntity(
      id: sexualOrientationModel.id,
      name: sexualOrientationModel.name,
      sequence: sexualOrientationModel.sequence,
    );
  }
}
