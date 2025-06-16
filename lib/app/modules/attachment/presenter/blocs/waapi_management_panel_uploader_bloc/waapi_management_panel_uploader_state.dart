import 'dart:io';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/attachment_entity.dart';

abstract class WaapiManagementPanelUploaderState extends Equatable {
  final List<AttachmentEntity> attachments;

  const WaapiManagementPanelUploaderState({
    this.attachments = const <AttachmentEntity>[],
  });

  @override
  List<Object?> get props {
    return [
      attachments,
    ];
  }

  InitialPanelUploaderState initialPanelUploaderState({
    required List<AttachmentEntity> attachments,
  }) {
    return InitialPanelUploaderState(
      attachments: attachments,
    );
  }

  DeletingPanelUploaderState deletingPanelUploaderState({
    required String attachmentName,
    required List<AttachmentEntity> attachments,
  }) {
    return DeletingPanelUploaderState(
      attachments: attachments,
      attachmentName: attachmentName,
    );
  }

  UploadingPanelUploaderState uploadingPanelUploaderState({
    required File file,
    required String contentType,
    required FormData formData,
    required String attachmentName,
  }) {
    return UploadingPanelUploaderState(
      attachments: attachments,
      contentType: contentType,
      file: file,
      formData: formData,
      attachmentName: attachmentName,
    );
  }
}

class InitialPanelUploaderState extends WaapiManagementPanelUploaderState {
  const InitialPanelUploaderState({
    required List<AttachmentEntity> attachments,
  }) : super(
          attachments: attachments,
        );
}

class DeletingPanelUploaderState extends WaapiManagementPanelUploaderState {
  final String attachmentName;
  const DeletingPanelUploaderState({
    required List<AttachmentEntity> attachments,
    required this.attachmentName,
  }) : super(
          attachments: attachments,
        );
}

class DeletedPanelUploaderState extends WaapiManagementPanelUploaderState {
  const DeletedPanelUploaderState({
    required List<AttachmentEntity> attachments,
  }) : super(
          attachments: attachments,
        );
}

class ErrorUploadPanelUploaderState extends WaapiManagementPanelUploaderState {
  final File file;
  final String contentType;
  const ErrorUploadPanelUploaderState({
    required List<AttachmentEntity> attachments,
    required this.file,
    required this.contentType,
  }) : super(
          attachments: attachments,
        );
}

class ErrorDeletePanelUploaderState extends WaapiManagementPanelUploaderState {}

class UploadingPanelUploaderState extends WaapiManagementPanelUploaderState {
  final File file;
  final String contentType;
  final FormData formData;
  final String attachmentName;
  const UploadingPanelUploaderState({
    required this.file,
    required this.contentType,
    required this.formData,
    required this.attachmentName,
    required List<AttachmentEntity> attachments,
  }) : super(attachments: attachments);
}
