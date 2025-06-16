import 'dart:io';

import 'package:flutter/material.dart';

abstract class FileService {
  Future<File?> pickFile({
    VoidCallback? onPermissionDenied,
    Function(Object e)? onException,
    bool isFileSizeValidationEnabled = false,
  });
}
