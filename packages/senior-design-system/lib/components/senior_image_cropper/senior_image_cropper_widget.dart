import 'dart:io';

import 'package:flutter/material.dart';
import 'package:senior_design_tokens/tokens/senior_spacing.dart';

import '../../service/senior_image_service.dart';
import '../senior_bottom_sheet/senior_bottom_sheet.dart';
import '../senior_button/senior_button.dart';
import './senior_image_cropper_style.dart';

class SeniorImageCropper {
  /// Creates the SDS Image Cropper component.
  /// The parameters [cropperTitle], [takePhotoLabel], [pickImageLabel],
  /// [onCropImage], [onPermissionCameraDenied] and [onPermissionGalleryDenied]
  /// are required.
  SeniorImageCropper({
    required this.cropperTitle,
    required this.takePhotoLabel,
    required this.pickImageLabel,
    this.doneButtonLabel,
    this.cancelButtonLabel,
    required this.onCropImage,
    this.maxSizeMb,
    this.onPermissionCameraDenied,
    this.onPermissionGalleryDenied,
    this.onException,
    this.style,
    this.pickFileLabel,
    this.onPickFile,
    this.pickFileIcon,
    this.takePhotoIcon,
    this.pickImageIcon,
  });

  /// Title for the image cropper.
  final String cropperTitle;

  /// The label for the option to take a photo with your smartphone camera.
  final String takePhotoLabel;

  /// Take photo button icon.
  final IconData? takePhotoIcon;

  /// The label for the option to choose a saved image.
  final String pickImageLabel;

  /// Pick image button icon.
  final IconData? pickImageIcon;  

  /// The label for tue done button on iOS.
  final String? doneButtonLabel;

  /// The label for the cancel button on iOS.
  final String? cancelButtonLabel;

  /// Callback function executed when the image is cropped.
  /// Receive the cropped image.
  final Function(File croppedImage) onCropImage;

  /// Maximum image size.
  final int? maxSizeMb;

  /// Callback function executed when there is no permission to access the camera.
  final VoidCallback? onPermissionCameraDenied;

  /// Callback function executed when there is no permission to access the gallery.
  final VoidCallback? onPermissionGalleryDenied;

  /// Function executed when an unexpected exception happens.
  final Function(Object e)? onException;

  /// The label for the pick file button;
  final String? pickFileLabel;

  /// Callback function executed when the user wants to pick a file.
  final VoidCallback? onPickFile;

  /// The icon for the pick file button.
  final IconData? pickFileIcon;

  /// The component's style definitions.
  /// Allows you to configure?
  /// [SeniorImageCropperStyle.toolbarColor] the toolbar color of the crop view.
  /// [SeniorImageCropperStyle.toolbarContentColor] the toolbar content color of the crop view.
  /// [SeniorImageCropperStyle.activeControlsColor] the color of the active controls of the crop view.
  final SeniorImageCropperStyle? style;

  /// Instance of the SeniorImageService class.
  final SeniorImageService _imageService = SeniorImageService();

  void pickImage(BuildContext context) {
    const double BUTTON_MAX_WIDTH = 600;

    SeniorBottomSheet.showDynamicBottomSheet(
      context: context,
      isDismissible: true,
      hasCloseButton: false,
      content: [
        Container(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: SeniorSpacing.normal + MediaQuery.of(context).padding.bottom,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: SeniorSpacing.medium,
                ),
                SeniorButton.primary(
                  label: takePhotoLabel,
                  icon: takePhotoIcon,
                  fullWidth: MediaQuery.of(context).size.width < BUTTON_MAX_WIDTH,
                  onPressed: () {
                    _imageService.pickImageFromCamera(
                      context: context,
                      onCropImage: onCropImage,
                      style: style,
                      maxSizeMb: maxSizeMb,
                      onPermissionCameraDenied: onPermissionCameraDenied,
                      onException: onException,
                    );
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(
                  height: SeniorSpacing.medium,
                ),
                SeniorButton.secondary(
                  label: pickImageLabel,
                  icon: pickImageIcon,
                  fullWidth: MediaQuery.of(context).size.width < BUTTON_MAX_WIDTH,
                  onPressed: () {
                    _imageService.pickImageFromGallery(
                      context: context,
                      onCropImage: onCropImage,
                      style: style,
                      maxSizeMb: maxSizeMb,
                      onPermissionGalleryDenied: onPermissionGalleryDenied,
                      onException: onException,
                    );
                    Navigator.pop(context);
                  },
                ),
                pickFileLabel != null && onPickFile != null
                    ? Column(
                        children: [
                          const SizedBox(
                            height: SeniorSpacing.medium,
                          ),
                          SeniorButton.secondary(
                            label: pickFileLabel!,
                            fullWidth: MediaQuery.of(context).size.width < BUTTON_MAX_WIDTH,
                            icon: pickFileIcon,
                            onPressed: onPickFile!,
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
