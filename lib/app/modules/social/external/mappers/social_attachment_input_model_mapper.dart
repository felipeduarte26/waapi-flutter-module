import '../../domain/intput_models/social_attachment_input_model.dart';
import '../../enums/file_type_enum.dart';

class SocialtAttachmentInputModelMapper {
  Map<String, dynamic> toJson({
    required SocialAttachmentInputModel socialtAttachmentInputModelMapper,
  }) {
    return {
      'objectId': socialtAttachmentInputModelMapper.objectId,
      'objectVersion': socialtAttachmentInputModelMapper.objectVersion,
      'fileName': socialtAttachmentInputModelMapper.fileName,
      'contentType': socialtAttachmentInputModelMapper.contentType,
      'title': socialtAttachmentInputModelMapper.title,
      'excerpt': socialtAttachmentInputModelMapper.excerpt,
      'type': socialtAttachmentInputModelMapper.type?.description(),
      'size': socialtAttachmentInputModelMapper.size,
      'width': socialtAttachmentInputModelMapper.width,
      'height': socialtAttachmentInputModelMapper.height,
      'progress': socialtAttachmentInputModelMapper.progress,
      'success': socialtAttachmentInputModelMapper.success,
    };
  }
}
