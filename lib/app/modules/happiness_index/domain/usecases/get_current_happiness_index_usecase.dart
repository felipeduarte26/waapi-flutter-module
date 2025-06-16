import '../../../../core/types/either.dart';
import '../failures/happiness_index_failure.dart';
import '../types/happiness_index_domain_types.dart';
import 'get_mood_records_usecase.dart';

abstract class GetCurrentHappinessIndexUsecase {
  GetCurrentHappinessIndexUsecaseCallback call({
    required String language,
  });
}

class GetCurrentHappinessIndexUsecaseImpl implements GetCurrentHappinessIndexUsecase {
  final GetMoodRecordsUsecase _getMoodRecordsUsecase;

  const GetCurrentHappinessIndexUsecaseImpl({
    required GetMoodRecordsUsecase getMoodRecordsUsecase,
  }) : _getMoodRecordsUsecase = getMoodRecordsUsecase;

  @override
  GetCurrentHappinessIndexUsecaseCallback call({
    required String language,
  }) async {
    final result = await _getMoodRecordsUsecase.call(
      language: language,
      startDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
      endDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
    );

    return result.fold(
      (l) => left(l),
      (r) {
        if (r.isEmpty) {
          return left(const NoHappinessIndexSelectedFailure());
        }
        return right(r.first);
      },
    );
  }
}
