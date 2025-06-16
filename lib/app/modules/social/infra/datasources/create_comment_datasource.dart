import '../../domain/intput_models/social_create_comment_intput_model.dart';
import '../models/social_comments_model.dart';

abstract class CreateCommentDatasource {
  Future<SocialCommentsModel> call({
    required SocialCreateCommentIntputModel socialCreateCommentIntputModel,
  });
}
