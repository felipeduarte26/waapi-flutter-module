import '../models/education_degree_model.dart';

abstract class GetEducationDegreeDatasource {
  Future<List<EducationDegreeModel>> call();
}
