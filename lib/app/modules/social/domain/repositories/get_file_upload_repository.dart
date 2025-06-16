import '../intput_models/social_request_file_upload_input_model.dart';
import '../types/social_domain_types.dart';

abstract class GetFileUploadRepository {
  GetFileUploadUsecaseCallback call({
    required List<SocialRequestFileUploadInputModel> socialRequestFileUploadInputModelList,
  });
}
