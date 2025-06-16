import 'dart:io';

import 'package:equatable/equatable.dart';

import '../../../domain/entities/social_attachment_entity.dart';
import '../../../domain/intput_models/social_attachment_input_model.dart';
import '../../../enums/file_origin_enum.dart';

abstract class SocialGetFileUploadState extends Equatable {
  const SocialGetFileUploadState();

  @override
  List<Object?> get props => [];
}

class LoadedSocialSendFileUploadState extends SocialGetFileUploadState {
  final List<SocialAttachmentInputModel> socialAttachmentInputModelList;

  const LoadedSocialSendFileUploadState({
    required this.socialAttachmentInputModelList,
  });

  @override
  List<Object?> get props => [
        socialAttachmentInputModelList,
      ];
}

class DeleteSocialFileUploadState extends SocialGetFileUploadState {
  final String id;

  const DeleteSocialFileUploadState({
    required this.id,
  });

  @override
  List<Object?> get props => [
        id,
      ];
}

class InitialSocialGetFileUploadState extends SocialGetFileUploadState {}

class LoadingSocialGetFileUploadState extends SocialGetFileUploadState {}

class LoadedSocialGetFileUploadState extends SocialGetFileUploadState {
  final File file;
  final FileOriginEnum fileOriginEnum;
  final SocialAttachmentEntity socialAttachmentEntity;

  const LoadedSocialGetFileUploadState({
    required this.file,
    required this.fileOriginEnum,
    required this.socialAttachmentEntity,
  });

  @override
  List<Object?> get props => [
        file,
        fileOriginEnum,
        socialAttachmentEntity,
      ];
}

class ErrorSocialFileUploadState extends SocialGetFileUploadState {}

class InitialSocialSendFileUploadState extends SocialGetFileUploadState {}

class LoadingSocialSendFileUploadState extends SocialGetFileUploadState {}

class ErrorSocialSendFileUploadState extends SocialGetFileUploadState {}
