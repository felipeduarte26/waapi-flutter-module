import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';

abstract class FileHelper {
  static Future<File> bytesToFile({
    required List<int> bytes,
    required String fileName,
  }) async {
    final uint8list = Uint8List.fromList(
      bytes,
    );

    final byteDate = ByteData.sublistView(uint8list);

    final buffer = byteDate.buffer;
    Directory temporaryDirectory = await getTemporaryDirectory();
    String tempPath = temporaryDirectory.path;
    var filePath = '$tempPath/$fileName';
    return File(
      filePath,
    ).writeAsBytes(
      buffer.asUint8List(
        byteDate.offsetInBytes,
        byteDate.lengthInBytes,
      ),
    );
  }

  static Future<File> createFileFromUint8List(
    Uint8List uint8List,
  ) async {
    final String millisecondsSinceEpoch = DateTime.now().millisecondsSinceEpoch.toString();

    final directory = await getTemporaryDirectory();
    final imagePath = await File('${directory.path}/$millisecondsSinceEpoch.png').create();
    final file = await imagePath.writeAsBytes(uint8List);

    return file;
  }

  static Future<String> fileToBase64({
    required File file,
  }) async {
    final filebytes = await file.readAsBytes();

    return base64.encode(filebytes);
  }
}
