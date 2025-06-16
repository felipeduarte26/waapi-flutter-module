import '../../domain/entities/education_degree_entity.dart';
import '../models/education_degree_model.dart';

class EducationDegreeEntityAdapter {
  EducationDegreeEntity fromModel({
    required EducationDegreeModel educationDegreeModel,
  }) {
    return EducationDegreeEntity(
      id: educationDegreeModel.id,
      name: educationDegreeModel.name,
      code: educationDegreeModel.code,
      type: educationDegreeModel.type,
    );
  }
}
