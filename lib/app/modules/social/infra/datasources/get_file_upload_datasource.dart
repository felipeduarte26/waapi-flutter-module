import '../../domain/intput_models/social_request_file_upload_input_model.dart';
import '../../domain/intput_models/storages3_aws_upload_input_model.dart';

abstract class GetFileUploadDatasource {
  Future<Storages3AwsUploadInputModel> call({
    required SocialRequestFileUploadInputModel socialResponseRequestFileUpload,
  });
}
