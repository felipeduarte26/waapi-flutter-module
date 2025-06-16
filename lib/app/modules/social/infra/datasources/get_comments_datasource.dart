import '../models/social_comments_model.dart';

abstract class GetCommentsDatasource {
  Future<List<SocialCommentsModel>> call({
    required String postId,
  });
}
