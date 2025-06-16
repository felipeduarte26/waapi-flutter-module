import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/repositories/face_recognition_token_repository.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/datasources/face_recognition_token_datasource.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/repositories/face_recognition_token_repository_impl.dart';

class MockFaceRecognitionTokenDatasource extends Mock
    implements FaceRecognitionTokenDatasource {}

void main() {
  String tToken = 'tToken';
  late FaceRecognitionTokenRepository faceRecognitionTokenRepository;
  late FaceRecognitionTokenDatasource faceRecognitionTokenDatasource;

  setUp(() {
    faceRecognitionTokenDatasource = MockFaceRecognitionTokenDatasource();

    faceRecognitionTokenRepository = FaceRecognitionTokenRepositoryImpl(
      getFaceRecognitionTokenDatasource: faceRecognitionTokenDatasource,
    );

    when(
      () => faceRecognitionTokenDatasource.call(),
    ).thenAnswer((_) async => tToken);
  });

  group('FaceRecognitionTokenRepository', () {
    test('call get token successfully test', () async {
      String? resultValue = await faceRecognitionTokenRepository.call();

      expect(resultValue, tToken);

      verify(
        () => faceRecognitionTokenDatasource.call(),
      ).called(1);

      verifyNoMoreInteractions(faceRecognitionTokenDatasource);
    });
  });
}
