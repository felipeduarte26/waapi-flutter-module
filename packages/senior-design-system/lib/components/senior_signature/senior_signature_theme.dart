import './senior_signature_style.dart';

class SeniorSignatureThemeData {
  /// Theme definitions for the SeniorSignature component.
  const SeniorSignatureThemeData({
    this.style,
  });

  /// The component's style definitions.
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

  SeniorSignatureThemeData copyWith({
    SeniorSignatureStyle? style,
  }) {
    return SeniorSignatureThemeData(
      style: style ?? this.style,
    );
  }
}
