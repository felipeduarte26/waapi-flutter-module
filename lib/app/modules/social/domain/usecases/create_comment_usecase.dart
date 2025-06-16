import '../intput_models/social_create_comment_intput_model.dart';
import '../repositories/create_comment_repository.dart';
import '../types/social_domain_types.dart';

abstract class CreateCommentUsecase {
  CreateCommentUsecaseCallback call({
    required SocialCreateCommentIntputModel socialCreateCommentIntputModel,
  });
}

class CreateCommentUsecaseImpl implements CreateCommentUsecase {
  final CreateCommentRepository _createCommentRepository;

  CreateCommentUsecaseImpl({
    required CreateCommentRepository createCommentRepository,
  }) : _createCommentRepository = createCommentRepository;

  @override
  CreateCommentUsecaseCallback call({
    required SocialCreateCommentIntputModel socialCreateCommentIntputModel,
  }) {
    return _createCommentRepository.call(
      socialCreateCommentIntputModel: socialCreateCommentIntputModel,
    );
  }
}
