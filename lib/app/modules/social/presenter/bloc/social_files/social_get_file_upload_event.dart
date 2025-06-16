import 'dart:io';

import 'package:equatable/equatable.dart';

import '../../../domain/entities/social_attachment_entity.dart';
import '../../../enums/file_origin_enum.dart';

abstract class SocialGetFileUploadEvent extends Equatable {}

class SendFileUploadEvent extends SocialGetFileUploadEvent {
  final FileOriginEnum fileOriginEnum;
  final File fileUpload;
  final List<SocialAttachmentEntity> socialAttachmentEntityList;

  SendFileUploadEvent({
    required this.fileOriginEnum,
    required this.fileUpload,
    required this.socialAttachmentEntityList,
  });

  @override
  List<Object> get props {
    return [
      fileOriginEnum,
      fileUpload,
      socialAttachmentEntityList,
    ];
  }
}

class GetFileUploadEvent extends SocialGetFileUploadEvent {
  final FileOriginEnum fileOriginEnum;
  final File fileUpload;

  GetFileUploadEvent({
    required this.fileOriginEnum,
    required this.fileUpload,
  });

  @override
  List<Object> get props {
    return [
      fileOriginEnum,
      fileUpload,
    ];
  }
}

class DeleteFileUploadEvent extends SocialGetFileUploadEvent {
  final FileOriginEnum fileOriginEnum;
  final File? fileUpload;
  final String id;

  DeleteFileUploadEvent({
    required this.fileOriginEnum,
    this.fileUpload,
    required this.id,
  });

  @override
  List<Object?> get props {
    return [
      fileOriginEnum,
      fileUpload,
      id,
    ];
  }
}
