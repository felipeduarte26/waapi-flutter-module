import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../components/senior_image_cropper/senior_image_cropper_style.dart';

class SeniorImageService {
  final ImagePicker _picker = ImagePicker();

  Future<File?> pickImageFromGallery({
    required BuildContext context,
    required Function(File croppedImage) onCropImage,
    SeniorImageCropperStyle? style,
    int? maxSizeMb,
    VoidCallback? onPermissionGalleryDenied,
    Function(Object e)? onException,
  }) async {
    try {
      final pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
      );
      if (pickedFile != null) {
        return await _cropImage(
          imgFile: File(pickedFile.path),
          context: context,
          onCropImage: onCropImage,
          style: style,
          maxSizeMb: maxSizeMb,
        );
      }
    } on PlatformException catch (e) {
      if (e.code == 'gallery_access_denied') {
        onPermissionGalleryDenied?.call();
      }
    } catch (e) {
      onException?.call(e);
    }
    return null;
  }

  Future<File?> pickImageFromCamera({
    required BuildContext context,
    required Function(File croppedImage) onCropImage,
    SeniorImageCropperStyle? style,
    int? maxSizeMb,
    VoidCallback? onPermissionCameraDenied,
    Function(Object e)? onException,
  }) async {
    try {
      final pickedFile = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 50,
      );
      if (pickedFile != null) {
        return await _cropImage(
          imgFile: File(pickedFile.path),
          context: context,
          onCropImage: onCropImage,
          style: style,
          maxSizeMb: maxSizeMb,
        );
      }
    } on PlatformException catch (e) {
      if (e.code == 'camera_access_denied') {
        onPermissionCameraDenied?.call();
      }
    } catch (e) {
      onException?.call(e);
    }
    return null;
  }

  Future<File?> _cropImage({
    required File imgFile,
    required BuildContext context,
    required Function(File croppedImage) onCropImage,
    SeniorImageCropperStyle? style,
    int? maxSizeMb,
  }) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: imgFile.path,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Image Cropper',
          toolbarColor: style?.toolbarColor ?? Colors.black,
          toolbarWidgetColor: style?.toolbarContentColor ?? Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
          showCropGrid: true,
          activeControlsWidgetColor: style?.activeControlsColor ?? Colors.blue,
          hideBottomControls: true,
        ),
        IOSUiSettings(
          title: 'Image Cropper',
          doneButtonTitle: 'Done',
          cancelButtonTitle: 'Cancel',
          hidesNavigationBar: true,
          resetButtonHidden: true,
          rotateButtonsHidden: true,
          rotateClockwiseButtonHidden: true,
          aspectRatioPickerButtonHidden: true,
        ),
      ],
    );

    if (croppedFile != null) {
      imageCache.clear();
      final File croppedFileImage = File(croppedFile.path);
      await _compressImage(croppedFileImage, maxSizeMb);
      onCropImage(croppedFileImage);
      return croppedFileImage;
    }
    return null;
  }

  Future<void> _compressImage(File file, int? maxSizeMb) async {
    if (maxSizeMb != null) {
      final maxLength = maxSizeMb * 1024 * 1024;
      while (file.lengthSync() > maxLength) {
        final compressedImage = await FlutterImageCompress.compressWithList(
          file.readAsBytesSync(),
          quality: 50,
          format: CompressFormat.jpeg,
        );

        await file.writeAsBytes(
          compressedImage,
          flush: true,
          mode: FileMode.write,
        );
      }
    }
  }
}
