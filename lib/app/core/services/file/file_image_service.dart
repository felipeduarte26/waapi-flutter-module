import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;

class FileImageService {
  final ImageDecoder imageDecoder;

  FileImageService({
    required this.imageDecoder,
  });

  bool isValidImage(Uint8List bytes) {
    final image = imageDecoder.decodeImage(bytes);
    return image != null;
  }

  Future<ImageDimensions> getImageDimensions(File file) async {
    final bytes = await file.readAsBytes();
    final image = imageDecoder.decodeImage(bytes);
    if (image != null) {
      return ImageDimensions(width: image.width, height: image.height);
    } else {
      return const ImageDimensions(width: null, height: null);
    }
  }
}

class ImageDecoder {
  img.Image? decodeImage(Uint8List bytes) {
    return img.decodeImage(bytes);
  }
}

class ImageDimensions extends Equatable {
  final int? width;
  final int? height;

  const ImageDimensions({
    required this.width,
    required this.height,
  });

  @override
  List<Object?> get props => [width, height];
}
