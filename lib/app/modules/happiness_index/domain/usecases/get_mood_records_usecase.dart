import '../repositories/get_mood_records_repository.dart';
import '../types/happiness_index_domain_types.dart';

abstract class GetMoodRecordsUsecase {
  GetMoodRecordsUsecaseCallback call({
    required String language,
    required DateTime startDate,
    required DateTime endDate,
  });
}

class GetMoodRecordsUsecaseImpl implements GetMoodRecordsUsecase {
  final GetMoodRecordsRepository _getMoodRecordsRepository;

  GetMoodRecordsUsecaseImpl({
    required GetMoodRecordsRepository getMoodRecordsRepository,
  }) : _getMoodRecordsRepository = getMoodRecordsRepository;

  @override
  GetMoodRecordsUsecaseCallback call({
    required String language,
    required DateTime startDate,
    required DateTime endDate,
  }) {
    return _getMoodRecordsRepository.call(
      language: language,
      endDate: endDate,
      startDate: startDate,
    );
  }
}
