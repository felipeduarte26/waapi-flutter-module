import '../types/social_domain_types.dart';

abstract class GetURLPostRepository {
  GetURLPostUsecaseCallback call({
    required String postId,
  });
}
