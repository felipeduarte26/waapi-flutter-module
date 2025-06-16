import 'package:flutter/material.dart';

class SeniorDropdownButtonStyle {
  /// Style definitions for the SeniorDropdownButton component.
  const SeniorDropdownButtonStyle({
    this.buttonColor,
    this.disabledButtonColor,
    this.disabledHelperColor,
    this.disabledDropIconColor,
    this.disabledIconColor,
    this.disabledLabelColor,
    this.disabledSelectedItemTextColor,
    this.disabledUnderlineColor,
    this.dropIconColor,
    this.errorColor,
    this.iconColor,
    this.itemListTextColor,
    this.labelColorEmpty,
    this.labelColorFilled,
    this.helperColor,
    this.popupMenuColor,
    this.selectedItemTextColor,
    this.underlineColor,
  });

  /// Defines the dropdown background color.
  final Color? buttonColor;

  /// Defines the dropdown background pain when it is disabled.
  final Color? disabledButtonColor;

  /// Defines the color of the drop icon when the dropdown is disabled.
  final Color? disabledDropIconColor;

  /// the help color when the dropdown is disabled.
  final Color? disabledHelperColor;

  /// Defines the icon color when dropdown is disabled.
  final Color? disabledIconColor;

  /// Defines the color of the label when the dropdown is disabled.
  final Color? disabledLabelColor;

  /// Defines the text color of the selected item when the dropdown is disabled.
  final Color? disabledSelectedItemTextColor;

  /// Defines the underline color when the dropdown is disabled.
  final Color? disabledUnderlineColor;

  /// Defines the color of the dropdown icon.
  final Color? dropIconColor;

  /// Defines the error color applied to the label, selected item, helper and underline.
  final Color? errorColor;

  /// Defines the icon color.
  final Color? iconColor;

  /// Defines the color of the list items in the dropdown popup menu.
  final Color? itemListTextColor;

  /// Defines the color of the label when there is no item selected.
  final Color? labelColorEmpty;

  /// Defines the color of the label when an item is selected.
  final Color? labelColorFilled;

  /// Defines the helper color.
  final Color? helperColor;

  /// Defines the color of the dropdown menu popup.
  final Color? popupMenuColor;

  /// Defines the text color of the selected item.
  final Color? selectedItemTextColor;

  /// Defines the underline color.
  final Color? underlineColor;

  SeniorDropdownButtonStyle copyWith({
    Color? buttonColor,
    Color? disabledButtonColor,
    Color? disabledDropIconColor,
    Color? disabledHelperColor,
    Color? disabledIconColor,
    Color? disabledLabelColor,
    Color? disabledSelectedItemTextColor,
    Color? disabledUnderlineColor,
    Color? dropIconColor,
    Color? errorColor,
    Color? iconColor,
    Color? itemListTextColor,
    Color? labelColorEmpty,
    Color? labelColorFilled,
    Color? helperColor,
    Color? popupMenuColor,
    Color? selectedItemTextColor,
    Color? underlineColor,
  }) {
    return SeniorDropdownButtonStyle(
      buttonColor: buttonColor ?? this.buttonColor,
      disabledButtonColor: disabledButtonColor ?? this.disabledButtonColor,
      disabledDropIconColor: disabledDropIconColor ?? this.disabledDropIconColor,
      disabledHelperColor: disabledHelperColor ?? this.disabledHelperColor,
      disabledIconColor: disabledIconColor ?? this.disabledIconColor,
      disabledLabelColor: disabledLabelColor ?? this.disabledLabelColor,
      disabledSelectedItemTextColor: disabledSelectedItemTextColor ?? this.disabledSelectedItemTextColor,
      disabledUnderlineColor: disabledUnderlineColor ?? this.disabledUnderlineColor,
      dropIconColor: dropIconColor ?? this.dropIconColor,
      errorColor: errorColor ?? this.errorColor,
      iconColor: iconColor ?? this.iconColor,
      itemListTextColor: itemListTextColor ?? this.itemListTextColor,
      labelColorEmpty: labelColorEmpty ?? this.labelColorEmpty,
      labelColorFilled: labelColorFilled ?? this.labelColorFilled,
      helperColor: helperColor ?? this.helperColor,
      popupMenuColor: popupMenuColor ?? this.popupMenuColor,
      selectedItemTextColor: selectedItemTextColor ?? this.selectedItemTextColor,
      underlineColor: underlineColor ?? this.underlineColor,
    );
  }

}
