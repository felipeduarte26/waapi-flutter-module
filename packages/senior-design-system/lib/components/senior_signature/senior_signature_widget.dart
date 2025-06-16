import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

import './models/signature.dart';
import './senior_signature_view.dart';
import './senior_signature_style.dart';
import '../senior_modal/model/senior_modal_definitions.dart';

class SeniorSignature {
  /// Allows you to collect signatures and turn them into image files.
  SeniorSignature({
    required this.emptySignatureText,
    required this.modalClear,
    required this.modalGoBack,
    required this.onSaveSignature,
    this.style,
  });

  /// The text displayed within the signature field when it is empty.
  final String emptySignatureText;

  /// The modal definitions presented when activating the option to clear the signature.
  final SeniorModalDefinitions modalClear;

  /// The modal definitions presented when activating the option to return with the signature field filled in.
  final SeniorModalDefinitions modalGoBack;

  /// Callback function executed when signature is saved.
  /// Returns a SignatureData object, [SignatureData.file], which contains the signature in file format, and
  /// [SignatureData.points], which contains the points exported from the signature.
  final Function(SignatureData signature) onSaveSignature;

  /// The style definitions for the component.
  /// Allows you to configure:
  /// [SeniorSignatureStyle.backgroundColor] the background color of the screen.
  /// [SeniorSignatureStyle.clearButtonIconColor] the icon color of the clear signature button.
  /// [SeniorSignatureStyle.disabledClearButtonIconColor] the icon color of the clear signature button when it is disabled.
  /// [SeniorSignatureStyle.disabledSaveButtonIconColor] the icon color of the save signature button when it is disabled.
  /// [SeniorSignatureStyle.emptySignatureTextColor] the color of the text displayed inside the signature field when it is empty.
  /// [SeniorSignatureStyle.saveButtonIconColor] the icon color of the save signature button.
  /// [SeniorSignatureStyle.signatureBackgrounColor] the background color of the signature field.
  /// [SeniorSignatureStyle.signatureDottedBorderColor] the signature field dotted border color.
  final SeniorSignatureStyle? style;

  /// Triggers the screen to capture the signature.
  /// [context] the current context where the signature screen will be applied.
  /// [points] receives the points of a signature that can be preloaded in the signature field.
  void pickImage({
    required BuildContext context,
    List<Point>? points,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SeniorSignatureView(
          emptySignatureText: emptySignatureText,
          modalClear: modalClear,
          modalGoBack: modalGoBack,
          onSaveSignature: onSaveSignature,
          points: points ?? [],
        ),
      ),
    );
  }
}
