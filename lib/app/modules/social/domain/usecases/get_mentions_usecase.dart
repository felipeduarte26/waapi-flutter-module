import '../repositories/get_mentions_repository.dart';
import '../types/social_domain_types.dart';

abstract class GetMentionsUsecase {
  GetMentionsUsecaseCallback call({
    required String query,
  });
}

class GetMentionsUsecaseImpl implements GetMentionsUsecase {
  final GetMentionsRepository _getMentionsRepository;

  const GetMentionsUsecaseImpl({
    required GetMentionsRepository getMentionsRepository,
  }) : _getMentionsRepository = getMentionsRepository;

  @override
  GetMentionsUsecaseCallback call({
    required String query,
  }) async {
    return _getMentionsRepository.call(
      query: query,
    );
  }
}
