import '../types/moods_domain_types.dart';

abstract class GetMoodsPulseLinkRepository {
  GetMoodsPulseLinkUsecaseCallback call({
    required String userId,
  });
}
