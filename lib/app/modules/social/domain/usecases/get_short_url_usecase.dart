import '../repositories/get_short_url_repository.dart';
import '../types/social_domain_types.dart';

abstract class GetShortUrlUsecase {
  GetShortUrlUsecaseCallback call({
    required List<String> listUrl,
  });
}

class GetShortUrlUsecaseImpl implements GetShortUrlUsecase {
  final GetShortUrlRepository _getShortUrlRepository;

  GetShortUrlUsecaseImpl({
    required GetShortUrlRepository getShortUrlRepository,
  }) : _getShortUrlRepository = getShortUrlRepository;

  @override
  GetShortUrlUsecaseCallback call({required List<String> listUrl}) {
    return _getShortUrlRepository.call(
      listUrl: listUrl,
    );
  }
}
