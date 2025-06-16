import 'dart:io';

import 'package:dio/dio.dart';

import '../../../../core/types/either.dart';
import '../../domain/failures/attachment_failure.dart';
import '../../domain/repositories/get_uploaded_attachments_repository.dart';
import '../../domain/types/attachment_domain_types.dart';
import '../adapters/attachment_entity_adapter.dart';
import '../datasources/get_uploaded_attachments_datasource.dart';

class GetUploadedAttachmentsRepositoryImpl implements GetUploadedAttachmentsRepository {
  final GetUploadedAttachmentsDatasource _getUploadedAttachmentsDatasource;
  final AttachmentEntityAdapter _attachmentEntityAdapter;

  const GetUploadedAttachmentsRepositoryImpl({
    required GetUploadedAttachmentsDatasource getUploadedAttachmentsDatasource,
    required AttachmentEntityAdapter attachmentEntityAdapter,
  })  : _getUploadedAttachmentsDatasource = getUploadedAttachmentsDatasource,
        _attachmentEntityAdapter = attachmentEntityAdapter;

  @override
  GetUploadedAttachmentsUsecaseCallback call({
    required File file,
    required String contentType,
    required FormData formData,
  }) async {
    try {
      final attachamentModel = await _getUploadedAttachmentsDatasource.call(
        file: file,
        contentType: contentType,
        formData: formData,
      );

      final attachmentEntity = _attachmentEntityAdapter.fromModel(
        model: attachamentModel,
      );

      return right(attachmentEntity);
    } catch (error, stackTrace) {
      return left(
        AttachmentUploadFailure(
          message: error.toString(),
          stackTrace: stackTrace,
        ),
      );
    }
  }
}
