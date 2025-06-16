import '../../domain/entities/social_attachment_entity.dart';
import '../models/social_attachment_model.dart';

class SocialAttachmentEntityAdapter {
  SocialAttachmentEntity fromModel({
    required SocialAttachmentModel socialAttachmentModel,
  }) {
    return SocialAttachmentEntity(
      contentType: socialAttachmentModel.contentType,
      fileName: socialAttachmentModel.fileName,
      fileSize: socialAttachmentModel.fileSize,
      fileType: socialAttachmentModel.fileType,
      fileUrl: socialAttachmentModel.fileUrl,
      id: socialAttachmentModel.id,
      title: socialAttachmentModel.title,
    );
  }
}
