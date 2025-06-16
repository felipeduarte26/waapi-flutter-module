import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/repositories/face_recognition_register_company_repository.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/datasources/face_recognition_register_company_datasource.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/repositories/face_recognition_register_company_repository_impl.dart';

class MockFaceRecognitionRegisterCompanyDatasource extends Mock
    implements FaceRecognitionRegisterCompanyDatasource {}

void main() {
  String tCompanyId = 'comanyId';
  late FaceRecognitionRegisterCompanyRepository
      faceRecognitionRegisterCompanyRepository;
  late FaceRecognitionRegisterCompanyDatasource
      faceRecognitionRegisterCompanyDatasource;

  setUp(() {
    faceRecognitionRegisterCompanyDatasource =
        MockFaceRecognitionRegisterCompanyDatasource();
    faceRecognitionRegisterCompanyRepository =
        FaceRecognitionRegisterCompanyRepositoryImpl(
      faceRecognitionRegisterCompanyDatasource:
          faceRecognitionRegisterCompanyDatasource,
    );

    when(
      () => faceRecognitionRegisterCompanyDatasource.call(
        companyId: tCompanyId,
      ),
    ).thenAnswer((_) async => true);
  });

  group('FaceRecognitionRegisterCompanyRepositoryImpl', () {
    test('call register company successfully test', () async {
      await faceRecognitionRegisterCompanyRepository.call(
        companyId: tCompanyId,
      );

      verify(
        () => faceRecognitionRegisterCompanyDatasource.call(
          companyId: tCompanyId,
        ),
      ).called(1);

      verifyNoMoreInteractions(faceRecognitionRegisterCompanyDatasource);
    });
  });
}
