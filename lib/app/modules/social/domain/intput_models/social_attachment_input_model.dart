import 'dart:io';

import 'package:equatable/equatable.dart';

import '../../enums/file_type_enum.dart';

class SocialAttachmentInputModel extends Equatable {
  final String objectId;
  final String objectVersion;
  final String fileName;
  final String? contentType;
  final String? title;
  final String? excerpt;
  final FileTypeEnum? type;
  final int? size;
  final int? width;
  final int? height;
  final int? progress;
  final bool? success;
  final File file;

  const SocialAttachmentInputModel({
    required this.objectId,
    required this.objectVersion,
    required this.fileName,
    this.contentType,
    this.title,
    this.excerpt,
    this.type,
    this.size,
    this.width,
    this.height,
    this.progress,
    this.success,
    required this.file,
  });

  SocialAttachmentInputModel copyWith({
    String? objectId,
    String? objectVersion,
    String? fileName,
    String? contentType,
    String? title,
    String? excerpt,
    FileTypeEnum? type,
    int? size,
    int? width,
    int? height,
    int? progress,
    bool? success,
    File? file,
  }) {
    return SocialAttachmentInputModel(
      objectId: objectId ?? this.objectId,
      objectVersion: objectVersion ?? this.objectVersion,
      fileName: fileName ?? this.fileName,
      contentType: contentType ?? this.contentType,
      title: title ?? this.title,
      excerpt: excerpt ?? this.excerpt,
      type: type ?? this.type,
      size: size ?? this.size,
      width: width ?? this.width,
      height: height ?? this.height,
      progress: progress ?? this.progress,
      success: success ?? this.success,
      file: file ?? this.file,
    );
  }

  @override
  List<Object?> get props => [
        objectId,
        objectVersion,
        fileName,
        contentType,
        title,
        excerpt,
        type,
        size,
        width,
        height,
        progress,
        success,
        file,
      ];
}
