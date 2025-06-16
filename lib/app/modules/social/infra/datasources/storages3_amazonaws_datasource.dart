import '../../domain/intput_models/social_request_file_upload_input_model.dart';
import '../../domain/intput_models/storages3_aws_upload_input_model.dart';

abstract class Storages3AmazonawsDatasource {
  Future<String> call({
    required Storages3AwsUploadInputModel storages3awsUploadInputModel,
    required SocialRequestFileUploadInputModel socialResponseRequestFileUpload,
  });
}
