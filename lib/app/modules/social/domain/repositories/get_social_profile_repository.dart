import '../types/social_domain_types.dart';

abstract class GetSocialProfileRepository {
  GetSocialProfileUsecaseCallback call({
    required String permaname,
  });
}
