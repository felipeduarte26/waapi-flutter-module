import 'package:equatable/equatable.dart';

class SocialFileUploadAttachmentEntity extends Equatable {
  final int progress;
  final int width;
  final int height;
  final String objectId;
  final String objectVersion;
  final String fileName;
  final String title;
  final String excerpt;
  final String contentType;
  final String type;
  final bool success;
  final int size;

  const SocialFileUploadAttachmentEntity({
    required this.progress,
    required this.width,
    required this.height,
    required this.objectId,
    required this.objectVersion,
    required this.fileName,
    required this.title,
    required this.excerpt,
    required this.contentType,
    required this.type,
    required this.success,
    required this.size,
  });
  @override
  List<Object> get props => [
        progress,
        width,
        height,
        objectId,
        objectVersion,
        fileName,
        title,
        excerpt,
        contentType,
        type,
        success,
        size,
      ];
}
