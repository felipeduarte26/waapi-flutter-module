import '../types/social_domain_types.dart';

abstract class GetShortUrlRepository {
  GetShortUrlUsecaseCallback call({
    required List<String> listUrl,
  });
}
