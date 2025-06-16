import 'package:flutter/material.dart';

import 'item_type.dart';

class SeniorListItem {
  /// The information for creating a list item.
  ///
  /// It is not possible to create a list item without providing an icon or a title.
  /// To enter a subtitle it is necessary to have informed a title.
  /// It is not possible to enter an icon and a right label at the same time.
  /// When informing an icon, it is necessary to inform its color.
  const SeniorListItem({
    this.icon,
    this.iconColor,
    this.iconBackground,
    this.onTap,
    this.rightIcon,
    this.rightLabel,
    this.subtitle,
    this.title,
    this.type = ItemType.neutral,
  })  : assert(!(title == null && icon == null)),
        assert(!(title == null && subtitle != null)),
        assert(!(rightIcon != null && rightLabel != null)),
        assert(!(icon != null && iconColor == null));

  /// The icon that will appear in the list item.
  ///
  /// When informing this parameter, it is necessary to inform [iconColor].
  final IconData? icon;

  /// The icon color for the list items.
  ///
  /// When informing this parameter, it is necessary to inform [icon].
  final Color? iconColor;

  /// The background color that will be added to the icon background.
  /// If a value is not informed for this parameter, no color will be added.
  final Color? iconBackground;

  /// Callback function that is called when the list item is tapped.
  final VoidCallback? onTap;

  /// The icon to the right of the list item.
  /// When informing this parameter, no value can be informed for the [rightLabel] parameter.
  final IconData? rightIcon;

  /// Label displayed to the right of the title.
  /// When informing this parameter, no value can be informed for the [rightIcon] parameter.
  final String? rightLabel;

  /// The subtitle of the list item.
  final String? subtitle;

  /// The title of the list item.
  final String? title;

  /// The type of the list item. It can be [ItemType.emphasis], [ItemType.emphasisBold], [ItemType.neutral] and
  /// [ItemType.neutralBold].
  final ItemType type;
}
