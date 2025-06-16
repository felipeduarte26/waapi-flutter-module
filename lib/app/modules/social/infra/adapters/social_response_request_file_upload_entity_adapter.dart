import '../../domain/entities/social_response_request_file_upload_entity.dart';
import '../../domain/intput_models/storages3_aws_upload_input_model.dart';

class SocialResponseRequestFileUploadEntityAdapter {
  SocialResponseRequestFileUploadEntity fromModel({
    required Storages3AwsUploadInputModel model,
  }) {
    return SocialResponseRequestFileUploadEntity(
      url: model.url,
      fileName: model.fileName,
      version: model.version,
      id: model.id,
    );
  }
}
