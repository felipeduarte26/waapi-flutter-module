import '../repositories/get_url_post_repository.dart';
import '../types/social_domain_types.dart';

abstract class GetURLPostUsecase {
  GetURLPostUsecaseCallback call({required String postId});
}

class GetURLPostUsecaseImpl implements GetURLPostUsecase {
  final GetURLPostRepository _getURLPostRepository;

  GetURLPostUsecaseImpl({
    required GetURLPostRepository getURLPostRepository,
  }) : _getURLPostRepository = getURLPostRepository;

  @override
  GetURLPostUsecaseCallback call({required String postId}) {
    return _getURLPostRepository.call(
      postId: postId,
    );
  }
}
