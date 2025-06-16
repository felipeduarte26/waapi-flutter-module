import './senior_dropdown_button_style.dart';

class SeniorDropdownButtonThemeData {
  /// Theme definitions for the SeniorDropdownButton component.
  const SeniorDropdownButtonThemeData({
    this.style,
  });

  /// Component style definitions.
  /// Allows you to configure:
  /// [SeniorDropdownButtonStyle.buttonColor] the dropdown background color.
  /// [SeniorDropdownButtonStyle.disabledButtonColor] the dropdown background pain when it is disabled.
  /// [SeniorDropdownButtonStyle.disabledHelperColor] the color of the drop icon when the dropdown is disabled.
  /// [SeniorDropdownButtonStyle.disabledDropIconColor] the help color when the dropdown is disabled.
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

  SeniorDropdownButtonThemeData copyWith({
    SeniorDropdownButtonStyle? style,
  }) {
    return SeniorDropdownButtonThemeData(
      style: style ?? this.style,
    );
  }
}
