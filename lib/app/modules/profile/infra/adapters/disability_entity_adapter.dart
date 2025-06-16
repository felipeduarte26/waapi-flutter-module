import '../../domain/entities/disability_entity.dart';
import '../models/disability_model.dart';

class DisabilityEntityAdapter {
  DisabilityEntity fromModel({
    required DisabilityModel disabilityModel,
  }) {
    return DisabilityEntity(
      id: disabilityModel.id,
      name: disabilityModel.name,
      code: disabilityModel.code,
      type: disabilityModel.type,
    );
  }
}
