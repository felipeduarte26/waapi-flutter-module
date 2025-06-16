import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../senior_design_system.dart';

class SeniorModal extends StatelessWidget {
  /// Displays a modal according to SDS definitions.
  ///
  /// The [content], [ghostButton] and [title] parameters are required.
  const SeniorModal({
    Key? key,
    required this.defaultAction,
    this.otherAction,
    this.content,
    this.contentAsWidget,
    this.style,
    required this.title,
    this.checkboxTitle,
    this.checkboxValue = false,
    this.checkboxDisabled = false,
    this.checkboxOnChanged,
    this.checkboxStyle,
    this.checkboxExtraTapMargin = 0,
    this.checkboxVisible = false,
    this.checkboxActionOnTitle = false,
    this.checkboxdisableLayoutBuilder = false,
    this.closable = false,
    this.onClose,
  })  : assert(
          content != null || contentAsWidget != null,
          'Either content or contentAsWidget must be provided, but both are null.',
        ),
        super(key: key);

  /// Defines whether the modal will have an option to close it.
  final bool closable;

  /// The action that is performed when the modal is closed.
  final Function()? onClose;

  final SeniorModalAction defaultAction;
  final SeniorModalAction? otherAction;

  /// The information content that will be displayed in the modal.
  final String? content;

  /// The information content that will be displayed in the modal as widget.
  final Widget? contentAsWidget;

  /// The component's style definitions.
  ///
  /// Allows you to configure:
  /// [SeniorModalStyle.backgroundColor] the background color of the modal.
  final SeniorModalStyle? style;

  /// The modal title.
  final String title;

  /// The title of the checkbox.
  final String? checkboxTitle;

  /// The value of the checkbox.
  final bool? checkboxValue;

  /// The action that will be executed when the title is clicked.
  final bool? checkboxDisabled;

  /// The action that will be executed when the title is clicked.
  final Function(bool?)? checkboxOnChanged;

  /// The style of the checkbox.
  final SeniorCheckboxStyle? checkboxStyle;

  /// The extra tap margin of the checkbox.
  final double? checkboxExtraTapMargin;

  /// The visibility of the checkbox.
  final bool? checkboxVisible;

  /// The action that will be executed when the title is clicked.
  final bool? checkboxActionOnTitle;

  /// Disables the use of LayoutBuilder to avoid layout issues.
  final bool? checkboxdisableLayoutBuilder;

  Widget _buildRowActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SeniorButton.ghost(
          label: defaultAction.label,
          onPressed: defaultAction.action,
          icon: defaultAction.icon,
        ),
        otherAction != null
            ? Padding(
                padding: const EdgeInsets.only(
                  left: SeniorSpacing.small,
                ),
                child: SeniorButton.primary(
                  label: otherAction!.label,
                  onPressed: otherAction!.action,
                  icon: otherAction!.icon,
                  danger: otherAction!.danger,
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }

  Widget _buildColumnActionButtons() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        otherAction != null
            ? Padding(
                padding: const EdgeInsets.only(bottom: SeniorSpacing.small),
                child: SeniorButton.primary(
                  label: otherAction!.label,
                  onPressed: otherAction!.action,
                  icon: otherAction!.icon,
                  danger: otherAction!.danger,
                  fullWidth: true,
                  busy: otherAction!.busy,
                  busyMessage: otherAction!.busyMessage,
                ),
              )
            : const SizedBox.shrink(),
        SeniorButton.ghost(
          label: defaultAction.label,
          onPressed: defaultAction.action,
          icon: defaultAction.icon,
          fullWidth: true,
          busy: defaultAction.busy,
          busyMessage: defaultAction.busyMessage,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeRepository>(context).theme;

    return AlertDialog(
      surfaceTintColor: Colors.transparent,
      backgroundColor: style?.backgroundColor ?? theme.modalTheme?.style?.backgroundColor ?? SeniorColors.pureWhite,
      titlePadding: const EdgeInsets.only(
        top: SeniorSpacing.normal,
        right: SeniorSpacing.normal,
        left: SeniorSpacing.normal,
        bottom: SeniorSpacing.xsmall,
      ),
      contentPadding: const EdgeInsets.only(
        left: SeniorSpacing.normal,
        right: SeniorSpacing.normal,
        bottom: SeniorSpacing.normal,
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title,
              style: SeniorTypography.h3(
                color: style?.titleColor ?? theme.modalTheme?.style?.titleColor ?? SeniorColors.grayscale90,
              ),
            ),
          ),
          closable
              ? IconButton(
                  icon: const Icon(
                    FontAwesomeIcons.x,
                    color: SeniorColors.primaryColor,
                    size: 16.0,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    onClose?.call();
                  },
                )
              : const SizedBox.shrink(),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: SingleChildScrollView(
              child: contentAsWidget ??
                  Text(
                    content ?? '',
                    style: SeniorTypography.label(
                      color: style?.contentColor ?? theme.modalTheme?.style?.contentColor ?? SeniorColors.grayscale90,
                    ),
                  ),
            ),
          ),
          checkboxVisible!
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: SeniorSpacing.normal),
                  child: SeniorCheckbox(
                    style: checkboxStyle,
                    disableLayoutBuilder: checkboxdisableLayoutBuilder!,
                    value: checkboxValue!,
                    title: checkboxTitle!,
                    actionOnTitle: checkboxActionOnTitle!,
                    disabled: checkboxDisabled!,
                    onChanged: checkboxOnChanged,
                    extraTapMargin: checkboxExtraTapMargin!,
                  ),
                )
              : const SizedBox.shrink(),
          Padding(
            padding: const EdgeInsets.only(top: SeniorSpacing.small),
            child: MediaQuery.of(context).size.width >= 576 ? _buildRowActionButtons() : _buildColumnActionButtons(),
          ),
        ],
      ),
    );
  }
}
