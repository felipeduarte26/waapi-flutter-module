abstract class UpdatePhotoProfileDatasource {
  Future<String> call({
    required String userId,
    required String photoBase64,
    required String contentType,
  });
}
