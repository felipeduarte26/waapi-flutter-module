import '../../enums/happiness_index_mood_enum.dart';
import '../repositories/save_happiness_index_repository.dart';
import '../types/happiness_index_domain_types.dart';

abstract class SaveHappinessIndexUsecase {
  SaveHappinessIndexUsecaseCallback call({
    required HappinessIndexMoodEnum mood,
    required String language,
    required String notes,
    required List<String> reasons,
  });
}

class SaveHappinessIndexUsecaseImpl implements SaveHappinessIndexUsecase {
  final SaveHappinessIndexRepository _saveHappinessIndexRepository;

  const SaveHappinessIndexUsecaseImpl({
    required SaveHappinessIndexRepository saveHappinessIndexRepository,
  }) : _saveHappinessIndexRepository = saveHappinessIndexRepository;

  @override
  SaveHappinessIndexUsecaseCallback call({
    required HappinessIndexMoodEnum mood,
    required String language,
    required String notes,
    required List<String> reasons,
  }) {
    return _saveHappinessIndexRepository.call(
      mood: mood,
      language: language,
      notes: notes,
      reasons: reasons,
    );
  }
}
