import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../senior_modal/model/senior_modal_action.dart';
import './senior_pin_code_field_style.dart';
import '../../repositories/theme_repository.dart';
import '../../theme/senior_theme_data.dart';
import '../senior_modal/model/senior_modal_definitions.dart';
import '../senior_modal/senior_modal_widget.dart';

class SeniorPinCodeFields extends StatefulWidget {
  /// Creates the design system's pin code fields component.
  /// The [length] and [onComplete] parameters are required.
  /// if [allowPasteText] is true you must set [pasteModalDefinitions].
  const SeniorPinCodeFields({
    Key? key,
    this.allowPasteText = false,
    this.autoClear = false,
    this.autofocus = false,
    this.autoHideKeyboard = true,
    this.controller,
    this.disabled = false,
    this.focusNode,
    required this.length,
    this.obscureText = false,
    this.onChange,
    required this.onComplete,
    this.onCompleteValidator,
    this.onPaste,
    this.pasteModalDefinitions,
    this.keyboardType = TextInputType.text,
    this.style,
  })  : assert(allowPasteText && pasteModalDefinitions != null ||
            !allowPasteText && pasteModalDefinitions == null),
        super(key: key);

  /// Whether the option to "paste" content into the component will be available.
  /// The default value is false.
  final bool allowPasteText;

  /// Whether the content added to the fields will be removed when it loses focus and it has not been filled in
  /// completely.
  /// The default value is false.
  final bool autoClear;

  /// Whether the component will request focus.
  /// The default value is false.
  final bool autofocus;

  /// Whether the keyboard will close automatically.
  /// The default value is true.
  final bool autoHideKeyboard;

  /// The control that represents the component's text field. Allows you to get and provide information related to
  /// the value of pin code fields.
  final TextEditingController? controller;

  /// Define se os campos estarão desabilitados. Neste estado eles não poderão receber interações.
  /// The default value is false.
  final bool disabled;

  /// The focus node to control the component's focus.
  final FocusNode? focusNode;

  /// The number of fields (characters) in the field.
  final int length;

  /// Defines if the value filled in the component will be explicit. When true the content display will be replaced
  /// by a neutral character. Stored content will still be preserved.
  /// The default value is false.
  final bool obscureText;

  /// Callback function executed when there are changes in the field.
  final ValueChanged<String>? onChange;

  /// Callback function executed when all fields are filled.
  final ValueChanged<String> onComplete;

  /// Callback function executed when all fields are filled to validate the content. If your return is false, a
  /// validation error will be considered.
  final Future<bool> Function(String)? onCompleteValidator;

  /// Callback function executed when content is "pasted" in the component.
  final ValueChanged<String>? onPaste;

  /// The definitions for the paste option modal.
  /// Allows you to configure:
  /// [SeniorModalDefinitions.cancelLabel] the text for the button with the cancel function.
  /// [SeniorModalDefinitions.confirmLabel] the text for the confirmation button.
  /// [SeniorModalDefinitions.content] the message shown in the modal.
  /// [SeniorModalDefinitions.title] the modal title.
  final SeniorModalDefinitions? pasteModalDefinitions;

  /// The keyboard type displayed in the field. Defines the content that can be added to the field.
  /// The default value is [TextInputType.text].
  final TextInputType keyboardType;

  /// The style definitions for the component.
  /// Allows you to configure:
  /// [SeniorPinCodeFieldStyle.defaultBorderColor] the default color for the border color. The color displayed when the
  /// field is not in focus, has no content, or in an no-error state.
  /// [SeniorPinCodeFieldStyle.disabledDefaultBorderColor] the default color for the border color. The color displayed
  /// when the field has no content and is disabled.
  /// [SeniorPinCodeFieldStyle.disabledHasTextBorderColor] the border color for when the field has content and is disabled.
  /// [SeniorPinCodeFieldStyle.disabledPinBoxColor] the field text color for when it is disabled.
  /// [SeniorPinCodeFieldStyle.disabledPinTextColor] the field's background color for when it is disabled.
  /// [SeniorPinCodeFieldStyle.errorBorderColor] the border color for fields that are in an error state.
  /// [SeniorPinCodeFieldStyle.hasTextBorderColor] the border color for when the field has content.
  /// [SeniorPinCodeFieldStyle.highlightColor] the border color for when the field is in focus.
  /// [SeniorPinCodeFieldStyle.pinBoxColor] the field's background color.
  /// [SeniorPinCodeFieldStyle.pinTextColor] the text color of the field.
  final SeniorPinCodeFieldStyle? style;

  @override
  _SeniorPinCodeFieldsState createState() => _SeniorPinCodeFieldsState();
}

class _SeniorPinCodeFieldsState extends State<SeniorPinCodeFields> {
  late TextEditingController _textEditingController;
  late FocusNode _focusNode;
  late List<String> _inputList;
  int _selectedIndex = 0;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();

    _assignController();

    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(() {
      if (widget.autoClear &&
          !_focusNode.hasFocus &&
          _textEditingController.text.length < _inputList.length) {
        _textEditingController.clear();
      }
      setState(() {});
    });

    _inputList = List<String>.filled(widget.length, '', growable: false);
    final String currentText = _textEditingController.text;
    _setTextToInput(currentText);
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _assignController() {
    _textEditingController = widget.controller ?? TextEditingController();
    _textEditingController.addListener(() {
      String currentText = _textEditingController.text;

      if (!widget.disabled && _inputList.join('') != currentText) {
        if (currentText.length >= widget.length) {
          if (currentText.length > widget.length) {
            currentText = currentText.substring(0, widget.length);
          }

          widget.onComplete(currentText);

          widget.onCompleteValidator?.call(currentText).then(
                (value) => setState(() {
                  _hasError = !value;
                }),
              );

          if (widget.autoHideKeyboard) {
            _focusNode.unfocus();
          }
        } else if (currentText.isEmpty) {
          if (widget.autoHideKeyboard) {
            _focusNode.unfocus();
          }
        } else {
          setState(() {
            _hasError = false;
          });
        }

        widget.onChange?.call(currentText);
      }
      _setTextToInput(currentText);
    });
  }

  void _onFocus() {
    if (_focusNode.hasFocus) {
      _focusNode.unfocus();
    }

    FocusScope.of(context).requestFocus(_focusNode);
    SystemChannels.textInput.invokeMethod('TextInput.show');
  }

  void _setTextToInput(String text) async {
    final List<String> replaceInputList =
        List<String>.filled(widget.length, '');

    if (text.isNotEmpty) {
      final List<String> tokens = text.substring(0, text.length).split('');

      for (int i = 0; i < text.length; i++) {
        replaceInputList[i] = tokens[i];
      }
    }

    setState(() {
      _selectedIndex = text.length;
      _inputList = replaceInputList;
    });
  }

  void _onPasteText() {
    Clipboard.getData('text/plain').then((data) {
      String currentText = data?.text ?? '';

      if (currentText.length > widget.length) {
        currentText = currentText.substring(0, widget.length);
      }

      showDialog(
        context: context,
        builder: (context) {
          return SeniorModal(
            title: widget.pasteModalDefinitions!.title,
            content: widget.pasteModalDefinitions!.content,
            defaultAction: SeniorModalAction(
              label: widget.pasteModalDefinitions!.cancelLabel,
              action: () {
                Navigator.pop(context);
                return;
              },
            ),
            otherAction: SeniorModalAction(
              label: widget.pasteModalDefinitions!.confirmLabel,
              action: () {
                Navigator.pop(context);
                widget.onPaste?.call(currentText);

                if (currentText.isNotEmpty) {
                  setState(() {
                    _textEditingController.text = currentText;
                  });
                }
              },
            ),
          );
        },
      );
    });
  }

  Color _getBorderColor(int index, SeniorThemeData theme) {
    if (widget.disabled) {
      return widget.style?.disabledDefaultBorderColor ??
          theme.pinCodeFieldTheme?.style?.disabledDefaultBorderColor ??
          SeniorColors.grayscale30;
    }
    if (_hasError) {
      return widget.style?.errorBorderColor ??
          theme.pinCodeFieldTheme?.style?.errorBorderColor ??
          SeniorColors.manchesterColorRed500;
    }
    if (((_selectedIndex == index) ||
            (_selectedIndex == index + 1 && index + 1 == widget.length)) &&
        _focusNode.hasFocus) {
      return widget.style?.highlightColor ??
          theme.pinCodeFieldTheme?.style?.highlightColor ??
          SeniorColors.primaryColor500;
    }
    return widget.style?.defaultBorderColor ??
        theme.pinCodeFieldTheme?.style?.defaultBorderColor ??
        SeniorColors.grayscale30;
  }

  Color _getBackgroundColor(int index, SeniorThemeData theme) {
    if (widget.disabled) {
      return widget.style?.disabledPinBoxColor ??
          theme.pinCodeFieldTheme?.style?.disabledPinBoxColor ??
          SeniorColors.grayscale10;
    } else {
      return widget.style?.pinBoxColor ??
          theme.pinCodeFieldTheme?.style?.pinBoxColor ??
          Colors.transparent;
    }
  }

  Widget _generateTextField(int index, SeniorThemeData theme) {
    const Duration animationDuration = Duration(milliseconds: 150);
    const double pinHeight = 56.0;
    const double pinWidth = 40.0;
    const double borderRadius = 4.0;
    final double borderWidth =
        _selectedIndex == index && _focusNode.hasFocus ? 2.0 : 1.0;

    return Container(
      child: AnimatedContainer(
        margin: const EdgeInsets.all(SeniorSpacing.xsmall),
        padding: const EdgeInsets.only(bottom: SeniorSpacing.xxsmall),
        curve: Curves.easeInOut,
        duration: animationDuration,
        width: pinWidth,
        height: pinHeight,
        decoration: BoxDecoration(
          color: _getBackgroundColor(index, theme),
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            color: _getBorderColor(index, theme),
            width: borderWidth,
          ),
        ),
        child: Center(
          child: AnimatedSwitcher(
            switchInCurve: Curves.easeIn,
            switchOutCurve: Curves.easeOut,
            duration: animationDuration,
            transitionBuilder: (child, animation) {
              return FadeTransition(
                opacity: Tween(begin: 0.0, end: 1.0).animate(animation),
                child: child,
              );
            },
            child: Text(
              widget.obscureText
                  ? _inputList[index].replaceAll(RegExp(r'.'), '•')
                  : _inputList[index],
              key: ValueKey(_inputList[index]),
              style: SeniorTypography.h2(
                color: widget.disabled
                    ? widget.style?.disabledPinTextColor ??
                        theme.pinCodeFieldTheme?.style?.disabledPinTextColor ??
                        SeniorColors.grayscale30
                    : widget.style?.pinTextColor ??
                        theme.pinCodeFieldTheme?.style?.pinTextColor ??
                        SeniorColors.grayscale90,
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _generateFields(SeniorThemeData theme) {
    final result = <Widget>[];

    for (int i = 0; i < widget.length; i++) {
      result.add(_generateTextField(i, theme));
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeRepository>(context).theme;

    return Container(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: SeniorSpacing.xxsmall),
            child: AbsorbPointer(
              absorbing: true,
              child: Opacity(
                opacity: 0,
                child: TextField(
                  controller: _textEditingController,
                  focusNode: _focusNode,
                  enabled: !widget.disabled,
                  autofocus: widget.autofocus,
                  autocorrect: false,
                  keyboardType: widget.keyboardType,
                  enableInteractiveSelection: false,
                  showCursor: false,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: _onFocus,
            onLongPress: widget.allowPasteText ? _onPasteText : null,
            child: Container(
              constraints: const BoxConstraints(minHeight: 30.0),
              padding:
                  const EdgeInsets.symmetric(vertical: SeniorSpacing.xsmall),
              child: Wrap(
                children: _generateFields(theme),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
