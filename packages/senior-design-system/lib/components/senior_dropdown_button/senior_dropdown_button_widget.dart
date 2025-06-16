import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../repositories/theme_repository.dart';
import '../../theme/senior_theme_data.dart';
import 'senior_dropdown_button_item.dart';
import 'senior_dropdown_button_style.dart';

class SeniorDropdownButton<T> extends StatefulWidget {
  /// Creates the Senior Design System dropdown.
  /// The [label], [onSelected], [value] and [items] parameters are required.
  const SeniorDropdownButton({
    Key? key,
    this.disabled = false,
    this.helper,
    this.icon,
    required this.label,
    required this.onSelected,
    this.showUnderline = true,
    this.style,
    this.validator,
    required this.value,
    required this.items,
  })  : assert(items.length > 0),
        super(key: key);

  /// Defines if the dropdown will be disabled.
  ///
  /// The default value is false.
  final bool disabled;

  /// The helper text that is displayed below the dropdown.
  final String? helper;

  /// An icon that will be added to the dropdown.
  final IconData? icon;

  /// The dropdown item list.
  /// The list cannot be empty.
  final List<SeniorDropdownButtonItem> items;

  /// The dropdown label text.
  final String label;

  /// Callback function executed when an item from the dropdown list is selected.
  final Function(dynamic) onSelected;

  /// Defines whether the line below the dropdown will be displayed.
  ///
  /// The default value is true.
  final bool showUnderline;

  /// The component's style definitions.
  /// Allows you to configure:
  /// [SeniorDropdownButtonStyle.buttonColor] the dropdown background color.
  /// [SeniorDropdownButtonStyle.disabledButtonColor] the dropdown background pain when it is disabled.
  /// [SeniorDropdownButtonStyle.disabledDropIconColor] the color of the drop icon when the dropdown is disabled.
  /// [SeniorDropdownButtonStyle.disabledHelperColor] the help color when the dropdown is disabled.
  /// [SeniorDropdownButtonStyle.disabledIconColor] the icon color when dropdown is disabled.
  /// [SeniorDropdownButtonStyle.disabledLabelColor] the color of the label when the dropdown is disabled.
  /// [SeniorDropdownButtonStyle.disabledSelectedItemTextColor] the text color of the selected item when the dropdown is disabled.
  /// [SeniorDropdownButtonStyle.disabledUnderlineColor] the underline color when the dropdown is disabled.
  /// [SeniorDropdownButtonStyle.dropIconColor] the color of the dropdown icon.
  /// [SeniorDropdownButtonStyle.errorColor] the error color applied to the label, selected item, helper and underline.
  /// [SeniorDropdownButtonStyle.iconColor] the icon color.
  /// [SeniorDropdownButtonStyle.itemListTextColor] the color of the list items in the dropdown popup menu.
  /// [SeniorDropdownButtonStyle.labelColorEmpty] the color of the label when there is no item selected.
  /// [SeniorDropdownButtonStyle.labelColorFilled] the color of the label when an item is selected.
  /// [SeniorDropdownButtonStyle.helperColor] the helper color.
  /// [SeniorDropdownButtonStyle.popupMenuColor] the color of the dropdown menu popup.
  /// [SeniorDropdownButtonStyle.selectedItemTextColor] the text color of the selected item.
  /// [SeniorDropdownButtonStyle.underlineColor] the underline color.
  final SeniorDropdownButtonStyle? style;

  /// The dropdown validation function.
  /// It is executed at component initialization and whenever a change is identified.
  /// Return a string, indicating a validation error, or null if it passes validation.
  final String? Function(dynamic)? validator;

  /// The current dropdown value.
  final T value;

  @override
  State<SeniorDropdownButton> createState() => _SeniorDropdownButtonState<T>();
}

class _SeniorDropdownButtonState<T> extends State<SeniorDropdownButton> {
  bool _hasError = false;
  bool _isPopupOpen = false;
  String? _validMsg;

  @override
  void initState() {
    super.initState();
    _internalValidator(value: widget.value);
  }

  void _internalValidator({T? value}) {
    if (widget.validator != null) {
      _validMsg = widget.validator!(value);
      _hasError = _validMsg != null;
    }

    setState(() {});
  }

  // The popupMenuButton does not yet provide an event to identify when the popup is open.
  // There is an open issue for this. When it becomes available, we apply this method to the event.
  // ignore: unused_element
  void _whenOpenPopup() {
    setState(() {
      _isPopupOpen = true;
    });
  }

  void _whenClosePopup() {
    setState(() {
      _isPopupOpen = false;
    });
  }

  Widget? _getItemChildByValue(T? value, SeniorThemeData theme) {
    if (value != null) {
      for (final item in widget.items) {
        if (item.value == value) {
          return Text(
            item.title,
            overflow: TextOverflow.ellipsis,
            style: SeniorTypography.label(
              color: widget.disabled
                  ? widget.style?.disabledSelectedItemTextColor ??
                      theme.dropdownButtonTheme?.style?.disabledSelectedItemTextColor ??
                      SeniorColors.grayscale40
                  : _hasError
                      ? widget.style?.errorColor ??
                          theme.dropdownButtonTheme?.style?.errorColor ??
                          SeniorColors.manchesterColorRed
                      : widget.style?.selectedItemTextColor ??
                          theme.dropdownButtonTheme?.style?.selectedItemTextColor ??
                          SeniorColors.grayscale50,
            ),
          );
        }
      }
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeRepository>(context).theme;

    return PopupMenuButton(
      onCanceled: () {
        _whenClosePopup();
      },
      enabled: !widget.disabled,
      color:
          widget.style?.popupMenuColor ?? theme.dropdownButtonTheme?.style?.popupMenuColor ?? SeniorColors.grayscale5,
      itemBuilder: (context) {
        return widget.items
            .map(
              (item) => PopupMenuItem(
                value: item.value,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    item.title,
                    style: SeniorTypography.label(
                      color: widget.style?.itemListTextColor ??
                          theme.dropdownButtonTheme?.style?.itemListTextColor ??
                          SeniorColors.grayscale80,
                    ),
                  ),
                ),
              ),
            )
            .toList();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: widget.disabled
                  ? widget.style?.disabledButtonColor ??
                      theme.dropdownButtonTheme?.style?.disabledButtonColor ??
                      SeniorColors.grayscale5
                  : widget.style?.buttonColor ??
                      theme.dropdownButtonTheme?.style?.buttonColor ??
                      SeniorColors.grayscale5,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(SeniorRadius.xbig),
                bottom: Radius.circular(SeniorRadius.xsmall),
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: widget.value != null
                      ? const EdgeInsets.symmetric(
                          horizontal: SeniorSpacing.small,
                          vertical: SeniorSpacing.xsmall,
                        )
                      : const EdgeInsets.symmetric(
                          horizontal: SeniorSpacing.small,
                          vertical: SeniorSpacing.normal,
                        ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            widget.icon != null
                                ? Icon(
                                    widget.icon,
                                    size: SeniorIconSize.medium,
                                    color: widget.disabled
                                        ? widget.style?.disabledIconColor ??
                                            theme.dropdownButtonTheme?.style?.disabledIconColor ??
                                            SeniorColors.grayscale40
                                        : widget.style?.iconColor ??
                                            theme.dropdownButtonTheme?.style?.iconColor ??
                                            SeniorColors.grayscale90,
                                  )
                                : const SizedBox.shrink(),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: SeniorSpacing.small),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    widget.value != null
                                        ? Text(
                                            widget.label,
                                            style: SeniorTypography.small(
                                              color: widget.disabled
                                                  ? widget.style?.disabledLabelColor ??
                                                      theme.dropdownButtonTheme?.style?.disabledLabelColor ??
                                                      SeniorColors.grayscale40
                                                  : _hasError
                                                      ? widget.style?.errorColor ??
                                                          theme.dropdownButtonTheme?.style?.errorColor ??
                                                          SeniorColors.manchesterColorRed
                                                      : widget.style?.labelColorFilled ??
                                                          theme.dropdownButtonTheme?.style?.labelColorFilled ??
                                                          SeniorColors.primaryColor,
                                            ),
                                          )
                                        : const SizedBox.shrink(),
                                    _getItemChildByValue(widget.value, theme) ??
                                        Text(
                                          widget.label,
                                          overflow: TextOverflow.ellipsis,
                                          style: SeniorTypography.label(
                                            color: widget.disabled
                                                ? widget.style?.disabledLabelColor ??
                                                    theme.dropdownButtonTheme?.style?.disabledLabelColor ??
                                                    SeniorColors.grayscale40
                                                : _hasError
                                                    ? widget.style?.errorColor ??
                                                        theme.dropdownButtonTheme?.style?.errorColor ??
                                                        SeniorColors.manchesterColorRed
                                                    : widget.style?.labelColorEmpty ??
                                                        theme.dropdownButtonTheme?.style?.labelColorEmpty ??
                                                        SeniorColors.grayscale90,
                                          ),
                                        ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        _isPopupOpen ? FontAwesomeIcons.chevronUp : FontAwesomeIcons.chevronDown,
                        size: SeniorIconSize.xsmall,
                        color: widget.disabled
                            ? widget.style?.disabledDropIconColor ??
                                theme.dropdownButtonTheme?.style?.disabledDropIconColor ??
                                SeniorColors.grayscale40
                            : widget.style?.dropIconColor ??
                                theme.dropdownButtonTheme?.style?.dropIconColor ??
                                SeniorColors.grayscale90,
                      ),
                    ],
                  ),
                ),
                widget.showUnderline
                    ? Container(
                        height: 2.0,
                        decoration: BoxDecoration(
                          color: widget.disabled
                              ? widget.style?.disabledUnderlineColor ??
                                  theme.dropdownButtonTheme?.style?.disabledUnderlineColor ??
                                  SeniorColors.grayscale40
                              : _hasError
                                  ? widget.style?.errorColor ??
                                      theme.dropdownButtonTheme?.style?.errorColor ??
                                      SeniorColors.manchesterColorRed
                                  : widget.style?.underlineColor ??
                                      theme.dropdownButtonTheme?.style?.underlineColor ??
                                      SeniorColors.grayscale40,
                          borderRadius: const BorderRadius.vertical(
                            bottom: Radius.circular(SeniorRadius.xbig),
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
          widget.helper != null || _hasError
              ? Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: SeniorSpacing.small,
                    vertical: SeniorSpacing.xxsmall,
                  ),
                  child: Text(
                    _hasError && _validMsg != null ? _validMsg! : widget.helper!,
                    style: SeniorTypography.small(
                      color: widget.disabled
                          ? widget.style?.disabledHelperColor ??
                              theme.dropdownButtonTheme?.style?.disabledHelperColor ??
                              SeniorColors.grayscale40
                          : _hasError
                              ? widget.style?.errorColor ??
                                  theme.dropdownButtonTheme?.style?.errorColor ??
                                  SeniorColors.manchesterColorRed
                              : widget.style?.helperColor ??
                                  theme.dropdownButtonTheme?.style?.helperColor ??
                                  SeniorColors.grayscale70,
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
      onSelected: (value) {
        _internalValidator(value: value as T);
        _whenClosePopup();
        return widget.onSelected(value);
      },
    );
  }
}
