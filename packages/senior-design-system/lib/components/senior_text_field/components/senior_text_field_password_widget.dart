import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../repositories/theme_repository.dart';
import '../../../theme/senior_theme_data.dart';
import '../senior_text_field_style.dart';
import './senior_text_field_widget.dart';

class SeniorTextFieldPassword extends StatefulWidget {
  const SeniorTextFieldPassword({
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
    this.onChanged,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onSaved,
    this.onTap,
    this.onTapOutside,
    this.prefixIcon,
    this.prefixWidget,
    this.readOnly = false,
    this.style,
    this.textInputAction,
    this.validator,
  });

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

  /// Component style settings.
  final SeniorTextFieldStyle? style;

  /// The type of action button to use for the keyboard.
  final TextInputAction? textInputAction;

  /// An optional method that validates an input. Returns an error string to display if the input is invalid, or null otherwise.
  final String? Function(String?)? validator;

  @override
  State<SeniorTextFieldPassword> createState() => _SeniorTextFieldPasswordState();
}

class _SeniorTextFieldPasswordState extends State<SeniorTextFieldPassword> {
  bool _obscure = true;
  late FocusNode _fieldFocus;

  @override
  void initState() {
    super.initState();
    _fieldFocus = widget.focusNode ?? FocusNode();
  }

  @override
  void dispose() {
    // Disposing focus node if it was created by the field
    if (widget.focusNode == null) {
      _fieldFocus.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeRepository>(context).theme;

    return SeniorTextField(
      autocorrect: widget.autocorrect,
      autofocus: widget.autofocus,
      autovalidateMode: widget.autovalidateMode,
      controller: widget.controller,
      counterText: widget.counterText,
      disabled: widget.disabled,
      enableSuggestions: widget.enableSuggestions,
      focusNode: _fieldFocus,
      helper: widget.helper,
      hintText: widget.hintText,
      initialValue: widget.initialValue,
      inputFormatters: widget.inputFormatters,
      keyboardType: widget.keyboardType,
      label: widget.label,
      maxLength: widget.maxLength,
      onChanged: widget.onChanged,
      onEditingComplete: widget.onEditingComplete,
      onFieldSubmitted: widget.onFieldSubmitted,
      onSaved: widget.onSaved,
      onTap: widget.onTap,
      onTapOutside: widget.onTapOutside,
      prefixIcon: widget.prefixIcon,
      prefixWidget: widget.prefixWidget,
      readOnly: widget.readOnly,
      style: widget.style,
      textInputAction: widget.textInputAction,
      validator: widget.validator,
      // --
      obscureText: _obscure,
      maxLines: 1,
      minLines: 1,
      suffixWidget: _buildObscureSwitch(theme),
    );
  }

  Widget _buildObscureSwitch(SeniorThemeData theme) {
    bool hasFocus = _fieldFocus.hasFocus;

    // Force interface update when focus changes to update switch
    _fieldFocus.addListener(() {
      setState(() {
        hasFocus = _fieldFocus.hasFocus;
      });
    });

    return Padding(
      padding: const EdgeInsets.only(
        right: SeniorSpacing.xxsmall,
        top: SeniorSpacing.xxsmall,
      ),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _obscure = !_obscure;
            if (!hasFocus) {
              _fieldFocus.requestFocus();
            }
          });
        },
        child: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          padding: const EdgeInsets.all(SeniorSpacing.small),
          child: Icon(
            _obscure ? FontAwesomeIcons.solidEyeSlash : FontAwesomeIcons.solidEye,
            size: SeniorIconSize.small,
            color: hasFocus
                ? widget.style?.focusColor ?? theme.textFieldTheme?.style?.focusColor ?? SeniorColors.primaryColor
                : widget.style?.iconColor ?? theme.textFieldTheme?.style?.iconColor ?? SeniorColors.neutralColor900,
          ),
        ),
      ),
    );
  }
}
