import '../../domain/intput_models/storages3_aws_upload_input_model.dart';

class Storages3AwsUploadModelMapper {
  Storages3AwsUploadInputModel fromMap({
    required Map<String, dynamic> fileMap,
    required String id,
  }) {
    return Storages3AwsUploadInputModel(
      url: fileMap['url'],
      fileName: fileMap['fileName'],
      version: fileMap['version'],
      id: id,
    );
  }
}
