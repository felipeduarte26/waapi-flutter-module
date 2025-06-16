import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import './senior_dropdown_button_item.dart';
import './senior_dropdown_button_style.dart';
import '../../components/senior_checkbox/senior_checkbox.dart';
import '../../repositories/theme_repository.dart';
import '../../theme/senior_theme_data.dart';

class SeniorMultidropdownButton extends StatefulWidget {
  /// Creates the Senior Design System dropdown.
  /// The [label], [onSelected], [value] and [items] parameters are required.
  const SeniorMultidropdownButton({
    Key? key,
    this.disabled = false,
    this.helper,
    this.icon,
    required this.items,
    required this.label,
    required this.onSelected,
    this.selectAllConfig,
    this.showUnderline = true,
    this.style,
    this.validator,
    required this.values,
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
  final Function(List<dynamic>) onSelected;

  /// Settings that allow enabling the option to check all items or uncheck them.
  final SelectAllConfig? selectAllConfig;

  /// Defines whether the line below the dropdown will be displayed.
  ///
  /// The default value is true.
  final bool showUnderline;

  /// The component's style definitions.
  /// Allows you to configure:
  /// [SeniorDropdownButtonStyle.buttonColor] the dropdown background color.
  /// [SeniorDropdownButtonStyle.disabledButtonColor] the dropdown background pain when it is disabled.
  /// [SeniorDropdownButtonStyle.disabledHelperColor] the help color when the dropdown is disabled.
  /// [SeniorDropdownButtonStyle.disabledDropIconColor] the color of the drop icon when the dropdown is disabled.
  /// [SeniorDropdownButtonStyle.disabledIconColor] icon color when dropdown is disabled.
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
  final String? Function(List<dynamic>?)? validator;

  /// The current dropdown value.
  final List<dynamic> values;

  @override
  State<SeniorMultidropdownButton> createState() => _SeniorMultidropdownButtonState();
}

class _SeniorMultidropdownButtonState extends State<SeniorMultidropdownButton> {
  bool selectAllChecked = false;
  final changeNotifier = ValueNotifier(false);

  bool _hasError = false;
  bool _isPopupOpen = false;
  String? _validMsg;

  @override
  void initState() {
    super.initState();
  }

  void _internalValidator({List<dynamic>? values}) {
    if (widget.validator != null) {
      _validMsg = widget.validator!(values);
      _hasError = _validMsg != null;
    }

    setState(() {});
  }

  void _notifyChange() {
    changeNotifier.value = !changeNotifier.value;
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

    setState(() {});
  }

  bool _checkIfItsChecked(dynamic value) {
    if (value != null) {
      for (final item in widget.values) {
        if (item == value) {
          return true;
        }
      }
    }
    return false;
  }

  void _addValue(dynamic value) {
    setState(() {
      if (_checkIfItsChecked(value)) {
        widget.values.remove(value);
        selectAllChecked = false;
      } else {
        widget.values.add(value);
      }
      _notifyChange();
    });
  }

  void _selectAllItems() {
    selectAllChecked = !selectAllChecked;
    if (selectAllChecked) {
      for (final item in widget.items) {
        if (!_checkIfItsChecked(item.value)) {
          widget.values.add(item.value);
        }
      }
    } else {
      widget.values.clear();
    }
    _notifyChange();
  }

  Widget? _getItemChildByValue(List<dynamic>? values, SeniorThemeData theme) {
    if (values != null && values.isNotEmpty) {
      if (values.length > 1) {
        return Text(
          '${values.length} itens selecionados', // Receber como parâmetro
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
                        SeniorColors.grayscale60,
          ),
        );
      } else {
        for (final item in widget.items) {
          if (item.value == values.first) {
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
                            SeniorColors.grayscale60,
              ),
            );
          }
        }
      }
    }

    return null;
  }

  PopupMenuItem _getSelectAllOption(SeniorThemeData theme) {
    return PopupMenuItem(
      value: 'select-all',
      child: ValueListenableBuilder<bool>(
        valueListenable: changeNotifier,
        builder: (context, value, child) {
          return Container(
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      _selectAllItems();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(SeniorSpacing.normal),
                      color: Colors.transparent,
                      child: AbsorbPointer(
                        child: SeniorCheckbox(
                          value: selectAllChecked,
                          title: selectAllChecked
                              ? widget.selectAllConfig!.unselectAllLabel
                              : widget.selectAllConfig!.selectAllLabel,
                          style: SeniorCheckboxStyle(
                            titleColor: widget.style?.itemListTextColor ??
                                theme.dropdownButtonTheme?.style?.itemListTextColor ??
                                SeniorColors.grayscale80,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  List<PopupMenuItem> _getListItems(SeniorThemeData theme) {
    return widget.items
        .map((item) => PopupMenuItem(
              value: item.value,
              child: ValueListenableBuilder<bool>(
                  valueListenable: changeNotifier,
                  builder: (context, value, child) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                _addValue(item.value);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: widget.selectAllConfig != null ? SeniorSpacing.big : SeniorSpacing.normal,
                                  vertical: SeniorSpacing.normal,
                                ),
                                color: Colors.transparent,
                                child: AbsorbPointer(
                                  child: SeniorCheckbox(
                                    value: _checkIfItsChecked(item.value),
                                    title: item.title,
                                    style: SeniorCheckboxStyle(
                                      titleColor: widget.style?.itemListTextColor ??
                                          theme.dropdownButtonTheme?.style?.itemListTextColor ??
                                          SeniorColors.grayscale80,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeRepository>(context).theme;

    return PopupMenuButton(
      onCanceled: () {
        _internalValidator(values: widget.values);
        _whenClosePopup();
        widget.onSelected(widget.values);
      },
      enabled: !widget.disabled,
      color:
          widget.style?.popupMenuColor ?? theme.dropdownButtonTheme?.style?.popupMenuColor ?? SeniorColors.grayscale5,
      itemBuilder: (
        context,
      ) {
        return widget.selectAllConfig != null
            ? [
                _getSelectAllOption(theme),
                ..._getListItems(theme),
              ]
            : _getListItems(theme);
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
                      SeniorColors.grayscale5,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(SeniorRadius.xbig),
                bottom: Radius.circular(SeniorRadius.xsmall),
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: widget.values.isNotEmpty
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
                                    widget.values.isNotEmpty
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
                                    _getItemChildByValue(widget.values, theme) ??
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
    );
  }
}

class SelectAllConfig {
  /// Settings that allow enabling the option to select all items or unselect them.
  /// The [selectAllLabel] and [unselectAllLabel] parameters are required.
  const SelectAllConfig({
    required this.selectAllLabel,
    required this.unselectAllLabel,
  });

  /// The text for the option to select all items.
  final String selectAllLabel;

  /// The text for the option to unselect all items.
  final String unselectAllLabel;
}
