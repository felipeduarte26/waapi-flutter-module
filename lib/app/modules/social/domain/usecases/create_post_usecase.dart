import '../intput_models/social_create_post_input_model.dart';
import '../repositories/create_post_repository.dart';
import '../types/social_domain_types.dart';

abstract class CreatePostUsecase {
  CreatePostUsecaseCallback call({
    required SocialCreatePostInputModel socialCreatePostIntputModel,
  });
}

class CreatePostUsecaseImpl implements CreatePostUsecase {
  final CreatePostRepository _createPostRepository;

  CreatePostUsecaseImpl({
    required CreatePostRepository createPostRepository,
  }) : _createPostRepository = createPostRepository;

  @override
  CreatePostUsecaseCallback call({
    required SocialCreatePostInputModel socialCreatePostIntputModel,
  }) {
    return _createPostRepository.call(
      socialCreatePostIntputModel: socialCreatePostIntputModel,
    );
  }
}
