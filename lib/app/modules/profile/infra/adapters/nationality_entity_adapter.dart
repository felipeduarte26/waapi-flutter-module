import '../../domain/entities/nationality_entity.dart';
import '../models/nationality_model.dart';

class NationalityEntityAdapter {
  NationalityEntity fromModel({
    required NationalityModel nationalityModel,
  }) {
    return NationalityEntity(
      id: nationalityModel.id,
      name: nationalityModel.name,
      code: nationalityModel.code,
    );
  }
}
