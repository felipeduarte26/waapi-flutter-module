import '../../domain/repositories/face_recognition_register_company_repository.dart';
import '../datasources/face_recognition_register_company_datasource.dart';

class FaceRecognitionRegisterCompanyRepositoryImpl
    implements FaceRecognitionRegisterCompanyRepository {
  final FaceRecognitionRegisterCompanyDatasource
      _faceRecognitionRegisterCompanyDatasource;

  FaceRecognitionRegisterCompanyRepositoryImpl({
    required FaceRecognitionRegisterCompanyDatasource
        faceRecognitionRegisterCompanyDatasource,
  }) : _faceRecognitionRegisterCompanyDatasource =
            faceRecognitionRegisterCompanyDatasource;
  @override
  Future<bool> call({required String companyId}) {
    return _faceRecognitionRegisterCompanyDatasource.call(companyId: companyId);
  }
}
