import 'dart:convert';

import '../../../../core/helper/date_time_helper.dart';
import '../../../../core/services/rest_client/rest_service.dart';
import '../../infra/datasources/get_mood_records_datasource.dart';
import '../../infra/models/happiness_index_mood_model.dart';
import '../mappers/happiness_index_mood_model_mapper.dart';

class GetMoodRecordsDatasourceImpl implements GetMoodRecordsDatasource {
  final RestService _restService;
  final HappinessIndexMoodModelMapper _happinessIndexMoodModelMapper;

  const GetMoodRecordsDatasourceImpl({
    required RestService restService,
    required HappinessIndexMoodModelMapper happinessIndexMoodModelMapper,
  })  : _restService = restService,
        _happinessIndexMoodModelMapper = happinessIndexMoodModelMapper;

  @override
  Future<List<HappinessIndexMoodModel>> call({
    required String language,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final moodRecords = await _restService.happinessIndexService().get(
      '/queries/retrieveMyMoodRecords',
      queryParameters: {
        'language': language,
        'startDate': DateTimeHelper.formatToIso8601Date(
          dateTime: startDate,
        ),
        'endDate': DateTimeHelper.formatToIso8601Date(
          dateTime: endDate,
        ),
      },
    );

    final moodRecordsMapList = jsonDecode(moodRecords.data!)['myMoodRecords'] as List;

    return moodRecordsMapList
        .map(
          (moodRecordsMap) => _happinessIndexMoodModelMapper.fromMap(
            map: moodRecordsMap,
          ),
        )
        .toList();
  }
}
