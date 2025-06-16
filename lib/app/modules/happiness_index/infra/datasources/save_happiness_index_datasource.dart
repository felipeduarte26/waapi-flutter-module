import '../../enums/happiness_index_mood_enum.dart';

abstract class SaveHappinessIndexDatasource {
  Future<void> call({
    required HappinessIndexMoodEnum mood,
    required String language,
    required String notes,
    required List<String> reasons,
  });
}
