import 'dart:convert';


import '../../../../core/services/rest_client/rest_exception.dart';
import '../../../../core/types/either.dart';
import '../../domain/failures/happiness_index_failure.dart';
import '../../domain/repositories/get_mood_records_repository.dart';
import '../../domain/types/happiness_index_domain_types.dart';
import '../adapters/happiness_index_mood_entity_adapter.dart';
import '../datasources/get_mood_records_datasource.dart';

class GetMoodRecordsRepositoryImpl implements GetMoodRecordsRepository {
  final GetMoodRecordsDatasource _getMoodRecordsDatasource;
 
  final HappinessIndexMoodEntityAdapter _happinessIndexMoodEntityAdapter;

  const GetMoodRecordsRepositoryImpl({
    required GetMoodRecordsDatasource getMoodRecordsDatasource,
    
    required HappinessIndexMoodEntityAdapter happinessIndexMoodEntityAdapter,
  })  : _getMoodRecordsDatasource = getMoodRecordsDatasource,
        
        _happinessIndexMoodEntityAdapter = happinessIndexMoodEntityAdapter;

  @override
  GetMoodRecordsUsecaseCallback call({
    required String language,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      final happinessIndexMoodRecords = await _getMoodRecordsDatasource.call(
        language: language,
        startDate: startDate,
        endDate: endDate,
      );

      final happinessIndexMoodRecordsEntities = happinessIndexMoodRecords
          .map(
            (happinessIndexMoodRecord) => _happinessIndexMoodEntityAdapter.fromModel(
              moodModel: happinessIndexMoodRecord,
            ),
          )
          .toList();

      return right(happinessIndexMoodRecordsEntities);
    } catch (error) {


      String? messageError;

      if (error is RestException && error.response != null) {
        final messageResponse = jsonDecode(error.response!.data);
        messageError = messageResponse['message'] as String?;
      }

      return left(
        HappinessIndexDatasourceFailure(
          message: messageError,
        ),
      );
    }
  }
}
