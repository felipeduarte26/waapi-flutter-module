abstract class SetLikeCommentDatasource {
  Future<void> call({
    required String commentId,
    required bool isLiked,
  });
}
