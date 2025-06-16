abstract class SetPostLikeDatasource {
  Future<void> call({
    required String postId,
    required bool isLiked,
  });
}
