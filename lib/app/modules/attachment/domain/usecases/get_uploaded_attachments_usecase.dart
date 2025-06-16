import 'dart:io';

import 'package:dio/dio.dart';

import '../repositories/get_uploaded_attachments_repository.dart';
import '../types/attachment_domain_types.dart';

abstract class GetUploadedAttachmentsUsecase {
  GetUploadedAttachmentsUsecaseCallback call({
    required File file,
    required String contentType,
    required FormData formData,
  });
}

class GetUploadedAttachmentsUsecaseImpl implements GetUploadedAttachmentsUsecase {
  final GetUploadedAttachmentsRepository _getUploadedAttachmentsRepository;

  const GetUploadedAttachmentsUsecaseImpl({
    required GetUploadedAttachmentsRepository getUploadedAttachmentstRepository,
  }) : _getUploadedAttachmentsRepository = getUploadedAttachmentstRepository;

  @override
  GetUploadedAttachmentsUsecaseCallback call({
    required File file,
    required String contentType,
    required FormData formData,
  }) {
    return _getUploadedAttachmentsRepository.call(
      file: file,
      contentType: contentType,
      formData: formData,
    );
  }
}
