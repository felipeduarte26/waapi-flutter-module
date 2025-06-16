import '../../domain/repositories/face_recognition_token_repository.dart';
import '../datasources/face_recognition_token_datasource.dart';

class FaceRecognitionTokenRepositoryImpl
    implements FaceRecognitionTokenRepository {
  final FaceRecognitionTokenDatasource _getFaceRecognitionTokenDatasource;
  FaceRecognitionTokenRepositoryImpl({
    required FaceRecognitionTokenDatasource
        getFaceRecognitionTokenDatasource,
  }) : _getFaceRecognitionTokenDatasource = getFaceRecognitionTokenDatasource;

  @override
  Future<String?> call() {
    return _getFaceRecognitionTokenDatasource.call();
  }
}
