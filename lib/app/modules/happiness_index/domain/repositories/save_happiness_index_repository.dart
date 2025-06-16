import '../../enums/happiness_index_mood_enum.dart';
import '../types/happiness_index_domain_types.dart';

abstract class SaveHappinessIndexRepository {
  SaveHappinessIndexUsecaseCallback call({
    required HappinessIndexMoodEnum mood,
    required String language,
    required String notes,
    required List<String> reasons,
  });
}
