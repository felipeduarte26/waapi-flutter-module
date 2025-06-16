import '../types/social_domain_types.dart';

abstract class SetPostLikeRepository {
  SetPostLikeUsecaseCallback call({
    required String postId,
    required bool isLiked,
  });
}
