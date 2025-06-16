import '../../domain/entities/historical_job_position_entity.dart';
import '../models/historical_job_position_model.dart';

class HistoricalJobPositionEntityAdapter {
  HistoricalJobPositionEntity fromModel({
    required HistoricalJobPositionModel historicalJobPositionModel,
  }) {
    return HistoricalJobPositionEntity(
      id: historicalJobPositionModel.id,
      name: historicalJobPositionModel.name,
      jobPositionStructureId: historicalJobPositionModel.jobPositionStructureId,
      jobStartDate: historicalJobPositionModel.jobStartDate,
    );
  }
}
