import '../models/vacations_model.dart';

abstract class GetVacationsDatasource {
  Future<List<VacationsModel>> call({
    required String employeeId,
  });
}
