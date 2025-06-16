import '../intput_models/social_create_comment_intput_model.dart';
import '../types/social_domain_types.dart';

abstract class CreateCommentRepository {
  CreateCommentUsecaseCallback call({
    required SocialCreateCommentIntputModel socialCreateCommentIntputModel,
  });
}
