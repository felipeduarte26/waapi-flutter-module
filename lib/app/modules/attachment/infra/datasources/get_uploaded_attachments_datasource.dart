import 'dart:io';

import 'package:dio/dio.dart';

import '../models/attachment_model.dart';

abstract class GetUploadedAttachmentsDatasource {
  Future<AttachmentModel> call({
    required File file,
    required String contentType,
    required FormData formData,
  });
}
