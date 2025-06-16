import '../repositories/get_comments_repository.dart';
import '../types/social_domain_types.dart';

abstract class GetCommentsUsecase {
  GetCommentsUsecaseCallback call({
    required String postId,
  });
}

class GetCommentsUsecaseImpl implements GetCommentsUsecase {
  final GetCommentsRepository _getCommentsRepository;

  const GetCommentsUsecaseImpl({
    required GetCommentsRepository getCommentsRepository,
  }) : _getCommentsRepository = getCommentsRepository;

  @override
  GetCommentsUsecaseCallback call({
    required String postId,
  }) async {
    return _getCommentsRepository.call(
      postId: postId,
    );
  }
}
