import '../types/social_domain_types.dart';

abstract class GetMentionsRepository {
  GetMentionsUsecaseCallback call({
    required String query,
  });
}
