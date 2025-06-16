import '../types/social_domain_types.dart';

abstract class SetLikeCommentRepository {
  SetLikeCommentUsecaseCallback call({
    required String commentId,
    required bool isLiked,
  });
}
