import 'package:flutter/material.dart';

class SeniorSignatureStyle {
  /// Style definitions for the SeniorSignature component.
  const SeniorSignatureStyle({
    this.backgroundColor,
    this.clearButtonIconColor,
    this.disabledClearButtonIconColor,
    this.disabledSaveButtonIconColor,
    this.emptySignatureTextColor,
    this.saveButtonIconColor,
    this.signatureBackgrounColor,
    this.signatureDottedBorderColor,
  });

  /// Defines the background color of the screen.
  final Color? backgroundColor;

  /// Defines the icon color of the clear signature button.
  final Color? clearButtonIconColor;

  /// Defines the icon color of the clear signature button when it is disabled.
  final Color? disabledClearButtonIconColor;

  /// Defines the icon color of the save signature button when it is disabled.
  final Color? disabledSaveButtonIconColor;

  /// Defines the color of the text displayed inside the signature field when it is empty.
  final Color? emptySignatureTextColor;

  /// Defines the icon color of the save signature button.
  final Color? saveButtonIconColor;

  /// Defines the background color of the signature field.
  final Color? signatureBackgrounColor;

  /// Defines the signature field dotted border color.
  final Color? signatureDottedBorderColor;

  SeniorSignatureStyle copyWith({
    Color? backgroundColor,
    Color? clearButtonIconColor,
    Color? disabledClearButtonIconColor,
    Color? disabledSaveButtonIconColor,
    Color? emptySignatureTextColor,
    Color? saveButtonIconColor,
    Color? signatureBackgrounColor,
    Color? signatureDottedBorderColor,
  }) {
    return SeniorSignatureStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      clearButtonIconColor: clearButtonIconColor ?? this.clearButtonIconColor,
      disabledClearButtonIconColor: disabledClearButtonIconColor ?? this.disabledClearButtonIconColor,
      disabledSaveButtonIconColor: disabledSaveButtonIconColor ?? this.disabledSaveButtonIconColor,
      emptySignatureTextColor: emptySignatureTextColor ?? this.emptySignatureTextColor,
      saveButtonIconColor: saveButtonIconColor ?? this.saveButtonIconColor,
      signatureBackgrounColor: signatureBackgrounColor ?? this.signatureBackgrounColor,
      signatureDottedBorderColor: signatureDottedBorderColor ?? this.signatureDottedBorderColor,
    );
  }
}
