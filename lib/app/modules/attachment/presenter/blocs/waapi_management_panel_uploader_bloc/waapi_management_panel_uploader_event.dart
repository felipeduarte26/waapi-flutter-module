import 'dart:io';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/attachment_entity.dart';

abstract class WaapiManagementPanelUploaderEvent extends Equatable {}

class DeleteAttachmentPanelUploaderEvent extends WaapiManagementPanelUploaderEvent {
  final String idAttachment;
  final String nameAttachment;

  DeleteAttachmentPanelUploaderEvent({
    required this.idAttachment,
    required this.nameAttachment,
  });

  @override
  List<Object?> get props {
    return [
      idAttachment,
      nameAttachment,
    ];
  }
}

class UploadAttachmentPanelUploaderEvent extends WaapiManagementPanelUploaderEvent {
  final File file;
  final String contentType;
  final FormData formData;
  final String nameAttachment;

  UploadAttachmentPanelUploaderEvent({
    required this.file,
    required this.contentType,
    required this.formData,
    required this.nameAttachment,
  });

  @override
  List<Object> get props {
    return [
      file,
      contentType,
      formData,
      nameAttachment,
    ];
  }
}

class HasAttachmentToUploadPanelUploaderEvent extends WaapiManagementPanelUploaderEvent {
  final List<AttachmentEntity> attachments;

  HasAttachmentToUploadPanelUploaderEvent({
    required this.attachments,
  });

  @override
  List<Object?> get props {
    return [
      attachments,
    ];
  }
}
