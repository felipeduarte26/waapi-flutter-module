import 'dart:io';

import 'package:dio/dio.dart';

import '../types/attachment_domain_types.dart';

abstract class GetUploadedAttachmentsRepository {
  GetUploadedAttachmentsUsecaseCallback call({
    required File file,
    required String contentType,
    required FormData formData,
  });
}
