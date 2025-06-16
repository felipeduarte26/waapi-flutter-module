import '../repositories/set_like_comment_repository.dart';
import '../types/social_domain_types.dart';

abstract class SetLikeCommentUsecase {
  SetLikeCommentUsecaseCallback call({
    required String commentId,
    required bool isLiked,
  });
}

class SetLikeCommentUsecaseImpl implements SetLikeCommentUsecase {
  final SetLikeCommentRepository _setLikeCommentRepository;

  SetLikeCommentUsecaseImpl({
    required SetLikeCommentRepository setLikeCommentRepository,
  }) : _setLikeCommentRepository = setLikeCommentRepository;

  @override
  SetLikeCommentUsecaseCallback call({
    required String commentId,
    required bool isLiked,
  }) {
    return _setLikeCommentRepository.call(
      commentId: commentId,
      isLiked: isLiked,
    );
  }
}
