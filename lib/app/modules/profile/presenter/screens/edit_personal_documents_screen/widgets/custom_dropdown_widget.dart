import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/components/components.dart';
import 'package:senior_design_system/repositories/theme_repository.dart';
import 'package:senior_design_system/theme/senior_theme_data.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

class CustomDropdownWidget<T> extends StatefulWidget {
  /// Creates the Senior Design System dropdown.
  /// The [label], [onSelected], [value] and [items] parameters are required.
  const CustomDropdownWidget({
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
    this.clearField,
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

  /// Function to clear a field.
  final Function()? clearField;

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
  State<CustomDropdownWidget> createState() => _SeniorDropdownButtonState<T>();
}

class _SeniorDropdownButtonState<T> extends State<CustomDropdownWidget> {
  bool _hasError = false;
  bool _isPopupOpen = false;
  String? _validMsg;

  @override
  void initState() {
    super.initState();
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
          return SeniorText.label(
            item.title,
            textProperties: const TextProperties(
              overflow: TextOverflow.ellipsis,
            ),
            color: widget.disabled
                ? widget.style?.disabledSelectedItemTextColor ??
                    theme.dropdownButtonTheme?.style?.disabledSelectedItemTextColor ??
                    SeniorColors.neutralColor400
                : _hasError
                    ? widget.style?.errorColor ??
                        theme.dropdownButtonTheme?.style?.errorColor ??
                        SeniorColors.manchesterColorRed
                    : widget.style?.selectedItemTextColor ??
                        theme.dropdownButtonTheme?.style?.selectedItemTextColor ??
                        SeniorColors.neutralColor600,
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
      color: widget.style?.popupMenuColor ??
          theme.dropdownButtonTheme?.style?.popupMenuColor ??
          SeniorColors.neutralColor100,
      itemBuilder: (context) {
        return widget.items
            .map(
              (item) => PopupMenuItem(
                value: item.value,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: SeniorText.label(
                    item.title,
                    color: widget.style?.itemListTextColor ??
                        theme.dropdownButtonTheme?.style?.itemListTextColor ??
                        SeniorColors.neutralColor800,
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
                      SeniorColors.pureWhite
                  : widget.style?.buttonColor ??
                      theme.dropdownButtonTheme?.style?.buttonColor ??
                      SeniorColors.neutralColor100,
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
                                ? SeniorIcon(
                                    icon: widget.icon!,
                                    size: SeniorIconSize.medium,
                                    style: SeniorIconStyle(
                                      color: widget.disabled
                                          ? widget.style?.disabledIconColor ??
                                              theme.dropdownButtonTheme?.style?.disabledIconColor ??
                                              SeniorColors.neutralColor400
                                          : widget.style?.iconColor ??
                                              theme.dropdownButtonTheme?.style?.iconColor ??
                                              SeniorColors.secondaryColor900,
                                    ),
                                  )
                                : const SizedBox.shrink(),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: SeniorSpacing.small),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    widget.value != null
                                        ? SeniorText.small(
                                            widget.label,
                                            color: widget.disabled
                                                ? widget.style?.disabledLabelColor ??
                                                    theme.dropdownButtonTheme?.style?.disabledLabelColor ??
                                                    SeniorColors.neutralColor400
                                                : _hasError
                                                    ? widget.style?.errorColor ??
                                                        theme.dropdownButtonTheme?.style?.errorColor ??
                                                        SeniorColors.manchesterColorRed
                                                    : widget.style?.labelColorFilled ??
                                                        theme.dropdownButtonTheme?.style?.labelColorFilled ??
                                                        SeniorColors.primaryColor,
                                          )
                                        : const SizedBox.shrink(),
                                    _getItemChildByValue(widget.value, theme) ??
                                        SeniorText.label(
                                          widget.label,
                                          textProperties: const TextProperties(
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          color: widget.disabled
                                              ? widget.style?.disabledLabelColor ??
                                                  theme.dropdownButtonTheme?.style?.disabledLabelColor ??
                                                  SeniorColors.neutralColor400
                                              : _hasError
                                                  ? widget.style?.errorColor ??
                                                      theme.dropdownButtonTheme?.style?.errorColor ??
                                                      SeniorColors.manchesterColorRed
                                                  : widget.style?.labelColorEmpty ??
                                                      theme.dropdownButtonTheme?.style?.labelColorEmpty ??
                                                      SeniorColors.secondaryColor900,
                                        ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SeniorIcon(
                        icon: _isPopupOpen ? FontAwesomeIcons.chevronUp : FontAwesomeIcons.chevronDown,
                        size: SeniorIconSize.xsmall,
                        style: SeniorIconStyle(
                          color: widget.disabled
                              ? widget.style?.disabledDropIconColor ??
                                  theme.dropdownButtonTheme?.style?.disabledDropIconColor ??
                                  SeniorColors.neutralColor400
                              : widget.style?.dropIconColor ??
                                  theme.dropdownButtonTheme?.style?.dropIconColor ??
                                  SeniorColors.neutralColor900,
                        ),
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
                                  SeniorColors.neutralColor400
                              : _hasError
                                  ? widget.style?.errorColor ??
                                      theme.dropdownButtonTheme?.style?.errorColor ??
                                      SeniorColors.manchesterColorRed
                                  : widget.style?.underlineColor ??
                                      theme.dropdownButtonTheme?.style?.underlineColor ??
                                      SeniorColors.secondaryColor500,
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
                  child: SeniorText.small(
                    _hasError && _validMsg != null ? _validMsg! : widget.helper!,
                    color: widget.disabled
                        ? widget.style?.disabledHelperColor ??
                            theme.dropdownButtonTheme?.style?.disabledHelperColor ??
                            SeniorColors.neutralColor400
                        : _hasError
                            ? widget.style?.errorColor ??
                                theme.dropdownButtonTheme?.style?.errorColor ??
                                SeniorColors.manchesterColorRed
                            : widget.style?.helperColor ??
                                theme.dropdownButtonTheme?.style?.helperColor ??
                                SeniorColors.neutralColor700,
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
      onSelected: (value) {
        _internalValidator(value: widget.value);
        _whenClosePopup();
        widget.onSelected(value);
      },
    );
  }
}
