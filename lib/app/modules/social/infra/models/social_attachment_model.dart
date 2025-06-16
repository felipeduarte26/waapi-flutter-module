import 'package:equatable/equatable.dart';

import '../../enums/file_type_enum.dart';

class SocialAttachmentModel extends Equatable {
  final String id;
  final String contentType;
  final String title;
  final String fileName;
  final FileTypeEnum fileType;
  final int fileSize;
  final String fileUrl;

  const SocialAttachmentModel({
    required this.id,
    required this.contentType,
    required this.title,
    required this.fileName,
    required this.fileType,
    required this.fileSize,
    required this.fileUrl,
  });

  @override
  List<Object?> get props {
    return [
      id,
      contentType,
      title,
      fileName,
      fileType,
      fileSize,
      fileUrl,
    ];
  }
}
