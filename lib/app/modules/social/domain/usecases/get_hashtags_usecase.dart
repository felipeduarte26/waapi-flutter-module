import '../repositories/get_hashtags_repository.dart';
import '../types/social_domain_types.dart';

abstract class GetHashtagsUsecase {
  GetHashtagsUsecaseCallback call({
    required String query,
  });
}

class GetHashtagsUsecaseImpl implements GetHashtagsUsecase {
  final GetHashtagsRepository _getHashtagsRepository;

  const GetHashtagsUsecaseImpl({
    required GetHashtagsRepository getHashtagsRepository,
  }) : _getHashtagsRepository = getHashtagsRepository;

  @override
  GetHashtagsUsecaseCallback call({
    required String query,
  }) async {
    return _getHashtagsRepository.call(
      query: query,
    );
  }
}
