import '../repositories/set_post_like_repository.dart';
import '../types/social_domain_types.dart';

abstract class SetPostLikeUsecase {
  SetPostLikeUsecaseCallback call({
    required String postId,
    required bool isLiked,
  });
}

class SetPostLikeUsecaseImpl implements SetPostLikeUsecase {
  final SetPostLikeRepository _setPostLikeRepository;

  SetPostLikeUsecaseImpl({
    required SetPostLikeRepository setPostLikeRepository,
  }) : _setPostLikeRepository = setPostLikeRepository;

  @override
  SetPostLikeUsecaseCallback call({
    required String postId,
    required bool isLiked,
  }) {
    return _setPostLikeRepository.call(
      postId: postId,
      isLiked: isLiked,
    );
  }
}
