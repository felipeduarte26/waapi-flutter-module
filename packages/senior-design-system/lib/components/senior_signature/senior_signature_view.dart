import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';
import 'package:signature/signature.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:path_provider/path_provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import './senior_signature_style.dart';
import './models/signature.dart';
import '../senior_icon_button/senior_icon_button.dart';
import '../senior_modal/senior_modal.dart';
import '../../theme/senior_theme_data.dart';
import '../../repositories/theme_repository.dart';

class SeniorSignatureView extends StatefulWidget {
  SeniorSignatureView({
    Key? key,
    required this.emptySignatureText,
    required this.modalClear,
    required this.modalGoBack,
    required this.onSaveSignature,
    required this.points,
    this.style,
  }) : super(key: key);

  final String emptySignatureText;
  final SeniorModalDefinitions modalClear;
  final SeniorModalDefinitions modalGoBack;
  final Function(SignatureData signature) onSaveSignature;
  final List<Point> points;
  final SeniorSignatureStyle? style;

  @override
  State<SeniorSignatureView> createState() => SeniorSignatureViewState();
}

class SeniorSignatureViewState extends State<SeniorSignatureView> {
  late SignatureController controller;
  bool isDrawing = false;
  late bool emptySignature;

  double verticalMargin = 0;
  double horizontalMargin = 0;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    controller = SignatureController(
      penStrokeWidth: 3.0,
      penColor: Colors.black,
      exportBackgroundColor: SeniorColors.pureWhite,
      exportPenColor: SeniorColors.pureBlack,
      onDrawStart: () {
        setState(() {
          isDrawing = true;
          emptySignature = false;
        });
      },
      onDrawEnd: () {
        setState(() {
          isDrawing = false;
          emptySignature = controller.isEmpty;
        });
      },
      points: widget.points,
    );

    emptySignature = controller.isEmpty;
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    controller.dispose();
    super.dispose();
  }

  Future<File?> exportSignature() async {
    final signature = await controller.toPngBytes();

    if (signature != null) {
      final tempDir = await getTemporaryDirectory();
      final timestamp = DateTime.now().millisecondsSinceEpoch;

      final File file =
          await File('${tempDir.path}/image$timestamp.png').create();
      file.writeAsBytesSync(signature);

      return file;
    }
    return null;
  }

  void _showModal({
    required BuildContext context,
    required SeniorModalDefinitions modalInfo,
    required VoidCallback onConfirm,
    required VoidCallback onCancel,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return SeniorModal(
          title: modalInfo.title,
          content: modalInfo.content,
          defaultAction: SeniorModalAction(
            label: modalInfo.cancelLabel,
            action: onCancel,
          ),
          otherAction: SeniorModalAction(
            label: modalInfo.confirmLabel,
            action: onConfirm,
            danger: true,
          ),
        );
      },
    );
  }

  Widget _buildGoBackOption(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: SeniorSpacing.normal,
        vertical: SeniorSpacing.small,
      ),
      child: SeniorIconButton(
        icon: FontAwesomeIcons.arrowLeft,
        onTap: () {
          if (controller.isNotEmpty) {
            _showModal(
              context: context,
              modalInfo: widget.modalGoBack,
              onConfirm: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              onCancel: () {
                Navigator.pop(context);
              },
            );
          } else {
            Navigator.pop(context);
          }
        },
        size: SeniorIconButtonSize.small,
        type: SeniorIconButtonType.ghost,
        style: const SeniorIconButtonStyle(
          borderColor: Colors.transparent,
        ),
      ),
    );
  }

  Widget _buildSaveOption(BuildContext context, SeniorThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: SeniorSpacing.small,
      ),
      child: SeniorIconButton(
        icon: FontAwesomeIcons.check,
        disabled: emptySignature,
        onTap: () async {
          if (controller.isNotEmpty) {
            final signatureFile = await exportSignature();

            if (signatureFile != null) {
              widget.onSaveSignature(
                SignatureData(
                  file: signatureFile,
                  points: controller.points,
                ),
              );
            }
          }

          Navigator.pop(context);
        },
        size: SeniorIconButtonSize.small,
        style: SeniorIconButtonStyle(
          iconColor: widget.style?.saveButtonIconColor ??
              theme.signatureTheme?.style?.saveButtonIconColor ??
              SeniorColors.primaryColor,
          disabledIconColor: widget.style?.disabledSaveButtonIconColor ??
              theme.signatureTheme?.style?.disabledSaveButtonIconColor ??
              SeniorColors.primaryColor100,
        ),
        type: SeniorIconButtonType.ghost,
      ),
    );
  }

  Widget _buildClearOption(BuildContext context, SeniorThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: SeniorSpacing.small,
      ),
      child: SeniorIconButton(
        icon: FontAwesomeIcons.trash,
        disabled: emptySignature,
        onTap: () {
          if (controller.isNotEmpty) {
            _showModal(
              context: context,
              modalInfo: widget.modalClear,
              onConfirm: () {
                if (controller.isNotEmpty) {
                  controller.clear();
                  setState(() {
                    emptySignature = true;
                  });
                }
                Navigator.pop(context);
              },
              onCancel: () {
                Navigator.pop(context);
              },
            );
          }
        },
        size: SeniorIconButtonSize.small,
        style: SeniorIconButtonStyle(
          iconColor: widget.style?.clearButtonIconColor ??
              theme.signatureTheme?.style?.clearButtonIconColor ??
              SeniorColors.manchesterColorRed,
          disabledIconColor: widget.style?.disabledClearButtonIconColor ??
              theme.signatureTheme?.style?.disabledClearButtonIconColor ??
              SeniorColors.manchesterColorRed200,
        ),
        type: SeniorIconButtonType.ghost,
      ),
    );
  }

  Widget _buildBottomButtons(SeniorThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: SeniorSpacing.normal),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _buildClearOption(context, theme),
          const SizedBox(width: SeniorSpacing.small),
          _buildSaveOption(context, theme),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeRepository>(context).theme;

    // left padding + right padding
    const double horizontalRetreat = 32.0;
    // top goBack padding + bottom goBack padding + top bottom buttons padding + bottom bottom buttons padding + dotted.
    const double verticalRetreat = 184.0;

    return SafeArea(
      child: Scaffold(
        backgroundColor: widget.style?.backgroundColor ??
            theme.signatureTheme?.style?.backgroundColor ??
            SeniorColors.pureWhite, // Tem que pegar do tema.
        primary: true,
        body: Stack(
          children: [
            emptySignature
                ? Center(
                    child: Text(
                      widget.emptySignatureText,
                      style: SeniorTypography.body(
                        color: widget.style?.emptySignatureTextColor ??
                            theme.signatureTheme?.style
                                ?.emptySignatureTextColor ??
                            SeniorColors.grayscale50,
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildGoBackOption(context),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: SeniorSpacing.normal,
                  ),
                  child: Center(
                    child: DottedBorder(
                      borderType: BorderType.RRect,
                      color: widget.style?.signatureDottedBorderColor ??
                          theme.signatureTheme?.style
                              ?.signatureDottedBorderColor ??
                          SeniorColors.grayscale50,
                      child: Signature(
                        controller: controller,
                        backgroundColor:
                            widget.style?.signatureBackgrounColor ??
                                theme.signatureTheme?.style
                                    ?.signatureBackgrounColor ??
                                SeniorColors.pureWhite,
                        height: MediaQuery.of(context).size.shortestSide -
                            verticalRetreat,
                        width: MediaQuery.of(context).size.longestSide -
                            horizontalRetreat,
                      ),
                    ),
                  ),
                ),
                _buildBottomButtons(theme),
              ],
            )
          ],
        ),
      ),
    );
  }
}
