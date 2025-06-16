import '../models/happiness_index_mood_model.dart';

abstract class GetMoodRecordsDatasource {
  Future<List<HappinessIndexMoodModel>> call({
    required String language,
    required DateTime startDate,
    required DateTime endDate,
  });
}
