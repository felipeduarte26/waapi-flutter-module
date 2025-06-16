import '../models/dependent_model.dart';

abstract class GetDependentsDatasource {
  Future<List<DependentModel>> call({
    required String employeeId,
  });
}
