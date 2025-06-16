import '../repositories/get_moods_pulse_link_repository.dart';
import '../types/moods_domain_types.dart';

abstract class GetMoodsPulseLinkUsecase {
  GetMoodsPulseLinkUsecaseCallback call({
    required String userId,
  });
}

class GetMoodsPulseLinkUsecaseImpl implements GetMoodsPulseLinkUsecase {
  final GetMoodsPulseLinkRepository _getMoodsPulseLinkRepository;

  const GetMoodsPulseLinkUsecaseImpl({
    required GetMoodsPulseLinkRepository getMoodsPulseLinkRepository,
  }) : _getMoodsPulseLinkRepository = getMoodsPulseLinkRepository;

  @override
  GetMoodsPulseLinkUsecaseCallback call({
    required String userId,
  }) async {
    return _getMoodsPulseLinkRepository.call(
      userId: userId,
    );
  }
}
