import '../../domain/entities/ethnicity_entity.dart';
import '../models/ethnicity_model.dart';

class EthnicityEntityAdapter {
  EthnicityEntity fromModel({
    required EthnicityModel ethnicityModel,
  }) {
    return EthnicityEntity(
      id: ethnicityModel.id,
      name: ethnicityModel.name,
      code: ethnicityModel.code,
    );
  }
}
