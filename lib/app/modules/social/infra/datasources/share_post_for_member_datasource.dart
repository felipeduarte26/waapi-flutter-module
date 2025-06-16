abstract class SharePostForMemberDatasource {
  Future<void> call({
    required String postId,
    required String memberId,
  });
}
