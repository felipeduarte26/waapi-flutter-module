import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'file_service.dart';

const List<String> allowedExtensions = [
  'txt',
  'pdf',
  'doc',
  'docx',
  'xls',
  'xlsx',
  'ppt',
  'pptx',
  'jpge',
  'jpg',
  'png',
];

const int maxFileSize = 2 * 1024 * 1024;

enum FilePickerErroResult {
  permissionDenied,
  unsupportedFile,
  invalidSize,
  noSelectedFiles,
}

extension FilePickerErroResultExtension on FilePickerErroResult {
  String get name {
    switch (this) {
      case FilePickerErroResult.permissionDenied:
        return 'permission_denied';
      case FilePickerErroResult.unsupportedFile:
        return 'unsupported_file';
      case FilePickerErroResult.invalidSize:
        return 'invalid_size';
      case FilePickerErroResult.noSelectedFiles:
        return 'no_selected_files';
    }
  }
}

class FileServiceImpl implements FileService {
  final FilePicker filePicker;

  FileServiceImpl({required this.filePicker});

  @override
  Future<File?> pickFile({
    VoidCallback? onPermissionDenied,
    Function(Object e)? onException,
    bool isFileSizeValidationEnabled = false,
  }) async {
    try {
      FilePickerResult? result = await filePicker.pickFiles(
        allowedExtensions: allowedExtensions,
        type: FileType.custom,
      );

      if (result != null) {
        return _validateFile(result, isFileSizeValidationEnabled);
      }
    } on PlatformException catch (e) {
      if (e.code == FilePickerErroResult.permissionDenied.name) {
        onPermissionDenied?.call();
      }
    } catch (e) {
      onException?.call(e);
    }
    return null;
  }

  File _validateFile(FilePickerResult result, bool isFileSizeValidationEnabled) {
    String? fileExtension = result.files.single.extension?.toLowerCase();
    int fileSize = result.files.single.size;

    if (fileExtension != null && allowedExtensions.contains(fileExtension)) {
      if (isFileSizeValidationEnabled && fileSize > maxFileSize) {
        throw UnsupportedError(FilePickerErroResult.invalidSize.name);
      }
      return File(result.files.single.path!);
    }

    throw UnsupportedError(FilePickerErroResult.unsupportedFile.name);
  }
}
