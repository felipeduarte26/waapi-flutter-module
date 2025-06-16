import '../types/social_domain_types.dart';

abstract class GetCommentsRepository {
  GetCommentsUsecaseCallback call({
    required String postId,
  });
}
