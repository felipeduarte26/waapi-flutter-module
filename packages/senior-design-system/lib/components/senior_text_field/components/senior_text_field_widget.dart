import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../repositories/theme_repository.dart';
import '../../../theme/senior_theme_data.dart';
import '../../components.dart';

class SeniorTextField extends StatefulWidget {
  const SeniorTextField({
    super.key,
    this.autocorrect = true,
    this.autofocus = false,
    this.autovalidateMode,
    this.controller,
    this.counterText,
    this.disabled = false,
    this.enableSuggestions = true,
    this.focusNode,
    this.helper,
    this.hintText,
    this.initialValue,
    this.inputFormatters,
    this.keyboardType,
    this.label,
    this.maxLength,
    this.maxLines,
    this.minLines,
    this.obscureText = false,
    this.onChanged,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onSaved,
    this.onTap,
    this.onTapOutside,
    this.prefixIcon,
    this.prefixWidget,
    this.readOnly = false,
    this.showCounterText = false,
    this.style,
    this.suffixIcon,
    this.sufixIcon,
    this.suffixWidget,
    this.sufixWidget,
    this.textInputAction,
    this.validator,
    this.expands = false,
    this.border,
  })  : assert(
          !(showCounterText && maxLength == null),
          'You cannot set showCounterText as true if maxLength was not specified',
        ),
        assert(
          !(prefixIcon != null && prefixWidget != null),
          'You cannot use prefixIcon and prefixWidget at the same time',
        ),
        assert(
          !((suffixIcon != null || sufixIcon != null) && (suffixWidget != null || sufixWidget != null)),
          'You cannot use suffixIcon and suffixWidget at the same time',
        );

  final bool expands;

  /// Whether to enable autocorrection.
  final bool autocorrect;

  /// Whether this text field should focus itself if nothing else is already focused.
  final bool autofocus;

  /// Used to enable/disable this form field auto validation and update its error text.
  final AutovalidateMode? autovalidateMode;

  /// Controls the text being edited.
  final TextEditingController? controller;

  /// Character counter text.
  final String? counterText;

  /// If true the text field is "disabled": it ignores taps.
  final bool disabled;

  /// Whether to show input suggestions as the user types.
  final bool enableSuggestions;

  /// Defines the keyboard focus for this widget.
  final FocusNode? focusNode;

  /// Auxiliary text displayed below the field.
  final String? helper;

  /// Auxiliary text within the field when there is no content entered yet.
  final String? hintText;

  /// An optional value to initialize the form field to, or null otherwise.
  final String? initialValue;

  /// Optional input validation and formatting overrides.
  final List<TextInputFormatter>? inputFormatters;

  /// The type of keyboard to use for editing the text.
  final TextInputType? keyboardType;

  /// Field label.
  final String? label;

  /// The maximum number of characters (Unicode grapheme clusters) to allow in the text field.
  final int? maxLength;

  /// The maximum number of lines to show at one time, wrapping if necessary.
  final int? maxLines;

  /// The minimum number of lines to occupy when the content spans fewer lines.
  final int? minLines;

  /// Whether to hide the text being edited (e.g., for passwords).
  final bool obscureText;

  /// Called when the user initiates a change to the TextField's value: when they have inserted or deleted text.
  final Function(String)? onChanged;

  /// Called when the user submits editable content (e.g., user presses the "done" button on the keyboard).
  final VoidCallback? onEditingComplete;

  /// Called when field content is submitted.
  final Function(String)? onFieldSubmitted;

  /// An optional method to call with the final value when the form is saved via [FormState.save].
  final void Function(String?)? onSaved;

  /// Called for each distinct tap except for every second tap of a double tap.
  final VoidCallback? onTap;

  /// Called for each tap that occurs outside of theTextFieldTapRegion group when the text field is focused.
  final void Function(PointerDownEvent)? onTapOutside;

  /// Icon presented before the content and within the field.
  final IconData? prefixIcon;

  /// Widget presented before the content and within the field.
  final Widget? prefixWidget;

  /// Whether the text can be changed.
  final bool readOnly;

  /// Whether to show the character counter.
  final bool showCounterText;

  /// Component style settings.
  final SeniorTextFieldStyle? style;

  /// Icon presented after the content and within the field.
  final IconData? suffixIcon;

  /// Widget presented after the content and within the field.
  final Widget? suffixWidget;

  /// The type of action button to use for the keyboard.
  final TextInputAction? textInputAction;

  /// An optional method that validates an input. Returns an error string to display if the input is invalid, or null otherwise.
  final String? Function(String?)? validator;

  @Deprecated('sufixIcon is deprecated. Use suffixIcon instead.')
  final IconData? sufixIcon;

  @Deprecated('sufixWidget is deprecated. Use suffixWidget instead.')
  final Widget? sufixWidget;

  /// Custom border for the text field.
  final InputBorder? border;

  @override
  State<SeniorTextField> createState() => _SeniorTextFieldState();
}

class _SeniorTextFieldState extends State<SeniorTextField> {
  int remaining = 0;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    if (widget.showCounterText) {
      remaining = widget.maxLength ?? 0;
    }
  }

  void _onChanged(String value) {
    if (widget.showCounterText) {
      setState(() {
        remaining = widget.maxLength! - value.length;
      });
    }
    widget.onChanged?.call(value);
  }

  String? _validator(String? value) {
    final validate = widget.validator?.call(value);

    setState(() {
      hasError = validate != null && validate.isNotEmpty;
    });

    return validate;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeRepository>(context).theme;

    return Opacity(
      opacity: widget.disabled ? 0.5 : 1.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: SeniorSpacing.xxsmall),
        child: TextFormField(
          expands: widget.expands,
          autocorrect: widget.autocorrect,
          autofocus: widget.autofocus,
          autovalidateMode: widget.autovalidateMode,
          controller: widget.controller,
          decoration: InputDecoration(
            labelText: widget.label,
            labelStyle: SeniorTypography.label(
              color: widget.disabled
                  ? widget.style?.borderColor ?? theme.textFieldTheme?.style?.borderColor ?? SeniorColors.grayscale50
                  : hasError
                      ? widget.style?.errorColor ??
                          theme.textFieldTheme?.style?.errorColor ??
                          SeniorColors.manchesterColorRed
                      : widget.style?.focusColor ??
                          theme.textFieldTheme?.style?.focusColor ??
                          SeniorColors.primaryColor,
            ),
            helperText: widget.helper,
            helperStyle: SeniorTypography.small(
              color: widget.style?.helperTextColor ??
                  theme.textFieldTheme?.style?.helperTextColor ??
                  SeniorColors.grayscale10,
            ),
            hintText: widget.hintText,
            hintStyle: SeniorTypography.label(
              color:
                  widget.style?.hintTextColor ?? theme.textFieldTheme?.style?.hintTextColor ?? SeniorColors.grayscale60,
            ),
            counterStyle: SeniorTypography.small(
              color:
                  widget.style?.counterColor ?? theme.textFieldTheme?.style?.counterColor ?? SeniorColors.grayscale10,
            ),
            counterText: widget.showCounterText ? '$remaining ${widget.counterText ?? ''}' : '',
            errorStyle: SeniorTypography.small(
              color: widget.style?.errorColor ??
                  theme.textFieldTheme?.style?.errorColor ??
                  SeniorColors.manchesterColorRed,
            ),
            disabledBorder: widget.border ??
                UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: widget.style?.borderColor ??
                        theme.textFieldTheme?.style?.borderColor ??
                        SeniorColors.grayscale60,
                    width: 2.0,
                  ),
                ),
            enabledBorder: widget.border ??
                UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: widget.style?.borderColor ??
                        theme.textFieldTheme?.style?.borderColor ??
                        SeniorColors.grayscale50,
                    width: 2.0,
                  ),
                ),
            errorBorder: widget.border ??
                UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: widget.style?.errorColor ??
                        theme.textFieldTheme?.style?.errorColor ??
                        SeniorColors.manchesterColorRed,
                    width: 2.0,
                  ),
                ),
            filled: true,
            fillColor: widget.style?.fillColor ?? theme.textFieldTheme?.style?.fillColor ?? SeniorColors.grayscale5,
            focusedBorder: widget.border ??
                UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: widget.style?.focusColor ??
                        theme.textFieldTheme?.style?.focusColor ??
                        SeniorColors.primaryColor500,
                    width: 2.0,
                  ),
                ),
            focusedErrorBorder: widget.border ??
                UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: widget.style?.errorColor ??
                        theme.textFieldTheme?.style?.errorColor ??
                        SeniorColors.manchesterColorRed,
                    width: 2.0,
                  ),
                ),
            prefixIcon: _buildPrefixIcon(theme: theme),
            suffixIcon: _buildSuffixIcon(theme: theme),
          ),
          enabled: !widget.disabled,
          enableSuggestions: widget.enableSuggestions,
          focusNode: widget.focusNode,
          initialValue: widget.initialValue,
          inputFormatters: widget.inputFormatters,
          keyboardType: widget.keyboardType,
          maxLength: widget.maxLength,
          maxLines: widget.maxLines,
          minLines: widget.minLines,
          obscureText: widget.obscureText,
          onChanged: _onChanged,
          onEditingComplete: widget.onEditingComplete,
          onFieldSubmitted: widget.onFieldSubmitted,
          onSaved: widget.onSaved,
          onTap: widget.onTap,
          onTapOutside: widget.onTapOutside,
          readOnly: widget.readOnly,
          style: SeniorTypography.label(
            color: widget.style?.textColor ?? theme.textFieldTheme?.style?.textColor ?? SeniorColors.grayscale90,
          ),
          textInputAction: widget.textInputAction,
          validator: _validator,
        ),
      ),
    );
  }

  Widget? _buildPrefixIcon({SeniorThemeData? theme}) {
    if (widget.prefixWidget != null) {
      return widget.prefixWidget;
    } else if (widget.prefixIcon != null) {
      return Icon(
        widget.prefixIcon,
        size: 20.0,
        color: widget.style?.iconColor ?? theme?.textFieldTheme?.style?.iconColor ?? SeniorColors.grayscale90,
      );
    } else {
      return null;
    }
  }

  Widget? _buildSuffixIcon({SeniorThemeData? theme}) {
    if (widget.suffixWidget != null || widget.suffixWidget != null) {
      return widget.suffixWidget ?? widget.suffixWidget;
    } else if (widget.suffixIcon != null || widget.suffixIcon != null) {
      return Icon(
        widget.suffixIcon ?? widget.suffixIcon,
        size: 20.0,
        color: widget.style?.iconColor ?? theme?.textFieldTheme?.style?.iconColor ?? SeniorColors.grayscale90,
      );
    } else {
      return null;
    }
  }
}
