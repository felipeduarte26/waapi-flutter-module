import '../models/employee_model.dart';

abstract class SearchEmployeesDatasource {
  Future<List<EmployeeModel>> call({
    required String search,
  });
}
