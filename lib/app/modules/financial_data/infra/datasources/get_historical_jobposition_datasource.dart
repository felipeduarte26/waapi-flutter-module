import '../models/historical_job_position_model.dart';

abstract class GetHistoricalJobpositionDataSource {
  Future<List<HistoricalJobPositionModel>> call({
    required String employeeId,
  });
}
