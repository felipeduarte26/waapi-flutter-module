import '../intput_models/social_request_file_upload_input_model.dart';
import '../repositories/get_file_upload_repository.dart';
import '../types/social_domain_types.dart';

abstract class GetFileUploadUsecase {
  GetFileUploadUsecaseCallback call({
    required List<SocialRequestFileUploadInputModel> socialRequestFileUploadInputModelList,
  });
}

class GetFileUploadUsecaseImpl implements GetFileUploadUsecase {
  final GetFileUploadRepository _getFileUploadRepository;

  const GetFileUploadUsecaseImpl({
    required GetFileUploadRepository getFileUploadRepository,
  }) : _getFileUploadRepository = getFileUploadRepository;

  @override
  GetFileUploadUsecaseCallback call({
    required List<SocialRequestFileUploadInputModel> socialRequestFileUploadInputModelList,
  }) async {
    return _getFileUploadRepository.call(
      socialRequestFileUploadInputModelList: socialRequestFileUploadInputModelList,
    );
  }
}
