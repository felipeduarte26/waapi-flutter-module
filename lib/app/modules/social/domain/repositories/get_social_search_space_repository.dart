import '../types/social_domain_types.dart';

abstract class GetSocialSearchSpaceRepository {
  GetSocialSearchSpaceUsecaseCallback call({
    required String query,
  });
}
