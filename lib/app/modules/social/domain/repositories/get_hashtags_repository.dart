import '../types/social_domain_types.dart';

abstract class GetHashtagsRepository {
  GetHashtagsUsecaseCallback call({
    required String query,
  });
}
