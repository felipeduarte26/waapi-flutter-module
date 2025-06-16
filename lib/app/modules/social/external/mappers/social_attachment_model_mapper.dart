import '../../../../core/helper/enum_helper.dart';
import '../../enums/file_type_enum.dart';
import '../../infra/models/social_attachment_model.dart';

class SocialAttachmentModelMapper {
  SocialAttachmentModel fromMap({
    required Map<String, dynamic> socialAttachmentMap,
  }) {
    return SocialAttachmentModel(
      id: socialAttachmentMap['id'],
      contentType: socialAttachmentMap['contentType'],
      fileName: socialAttachmentMap['fileName'],
      fileSize: socialAttachmentMap['fileSize'],
      fileType: EnumHelper<FileTypeEnum>().stringToEnum(
            stringToParse: socialAttachmentMap['fileType'],
            values: FileTypeEnum.values,
          ) ??
          FileTypeEnum.unknown,
      fileUrl: socialAttachmentMap['fileUrl'] ?? '',
      title: socialAttachmentMap['title'] ?? '',
    );
  }
}
