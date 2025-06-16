import '../intput_models/social_create_post_input_model.dart';
import '../types/social_domain_types.dart';

abstract class CreatePostRepository {
  CreatePostUsecaseCallback call({
    required SocialCreatePostInputModel socialCreatePostIntputModel,
  });
}
