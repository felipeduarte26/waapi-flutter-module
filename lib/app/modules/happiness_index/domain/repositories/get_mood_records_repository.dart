import '../types/happiness_index_domain_types.dart';

abstract class GetMoodRecordsRepository {
  GetMoodRecordsUsecaseCallback call({
    required String language,
    required DateTime startDate,
    required DateTime endDate,
  });
}
