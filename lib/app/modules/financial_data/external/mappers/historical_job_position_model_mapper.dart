import '../../../../core/helper/date_time_helper.dart';
import '../../infra/models/historical_job_position_model.dart';

class HistoricalJobPositionModelMapper {
  List<HistoricalJobPositionModel> fromMap({
    required List<dynamic> listMap,
  }) {
    final historicalJobPositionModelList = <HistoricalJobPositionModel>[];

    for (final historicalJobPositionModel in listMap) {
      historicalJobPositionModelList.add(
        HistoricalJobPositionModel(
          id: historicalJobPositionModel['id'],
          name: historicalJobPositionModel['name'],
          jobPositionStructureId: historicalJobPositionModel['jobPositionStructureId'],
          jobStartDate: DateTimeHelper.convertStringIso8601toDateTime(
            stringIso8601: historicalJobPositionModel['jobStartDate'],
          ),
        ),
      );
    }

    return historicalJobPositionModelList;
  }
}
