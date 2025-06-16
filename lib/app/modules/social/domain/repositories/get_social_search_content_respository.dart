import '../types/social_domain_types.dart';

abstract class GetSocialSearchContentRepository {
  GetSocialSearchContentUsecaseCallback call({
    required String query,
    required int from,
  });
}
