import 'dart:io';

import 'package:equatable/equatable.dart';

import '../../enums/file_type_enum.dart';

class SocialAttachmentEntity extends Equatable {
  final String id;
  final String contentType;
  final String title;
  final String fileName;
  final FileTypeEnum fileType;
  final int fileSize;
  final String fileUrl;
  final File? file;

  const SocialAttachmentEntity({
    required this.id,
    required this.contentType,
    required this.title,
    required this.fileName,
    required this.fileType,
    required this.fileSize,
    required this.fileUrl,
    this.file,
  });

  SocialAttachmentEntity copyWith({
    required String fileUrl,
  }) {
    return SocialAttachmentEntity(
      id: id,
      contentType: contentType,
      title: title,
      fileName: fileName,
      fileType: fileType,
      fileSize: fileSize,
      fileUrl: fileUrl,
      file: file,
    );
  }

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
      file,
    ];
  }
}
