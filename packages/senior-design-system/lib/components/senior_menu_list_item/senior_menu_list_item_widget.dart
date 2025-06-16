import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import './senior_menu_list_item_style.dart';
import '../../repositories/theme_repository.dart';

class SeniorMenuItemList extends StatelessWidget {
  /// Creates a menu list item according to SDS.
  ///
  /// The [title] parameter is required.
  const SeniorMenuItemList({
    Key? key,
    this.leading,
    required this.title,
    this.onTap,
    this.subtitle,
    this.enabled = true,
    this.leftPadding = 0,
    this.rightPadding = 0,
    this.style,
    this.titleMaxLines = 1,
  }) : super(key: key);

  /// A widget presented before the item content.
  final Widget? leading;

  /// The title of the menu item.
  final String title;

  /// The subtitle of the menu item.
  final String? subtitle;

  /// Function performed when the menu item is tapped.
  final VoidCallback? onTap;

  /// Defines whether the menu item will be enabled.
  ///
  /// The default value is true.
  final bool enabled;

  /// The value for a padding to the left of the menu item.
  ///
  /// The default value is 0.
  final double leftPadding;

  /// The value for a padding to the right of the menu item.
  ///
  /// The default value is 0.
  final double rightPadding;

  /// The component's style definitions.
  /// Allows you to configure:
  /// [SeniorMenuListItemStyle.iconColor] the color of the item's icon.
  /// [SeniorMenuListItemStyle.disabledPushIconColor] the color of the item's action icon.
  /// [SeniorMenuListItemStyle.pushIconColor] the color of the item's action icon when disabled.
  /// [SeniorMenuListItemStyle.subtitleColor] the item's subtitle color.
  /// [SeniorMenuListItemStyle.titleColor] the color of the item's title.
  final SeniorMenuListItemStyle? style;

  /// Defines the maximum lines for the menu item title.
  ///
  /// The default value is 1.
  final int titleMaxLines;

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeRepository>(context).theme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: enabled ? onTap : null,
        child: Container(
          padding: EdgeInsets.only(
            top: SeniorSpacing.small,
            bottom: SeniorSpacing.small,
            left: leftPadding,
            right: rightPadding,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              leading != null
                  ? Padding(
                      padding: const EdgeInsets.only(
                        right: SeniorSpacing.small,
                      ),
                      child: leading,
                    )
                  : const SizedBox.shrink(),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: titleMaxLines,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: SeniorTypography.body(
                        color: style?.titleColor ??
                            theme.menuListItemTheme?.style?.titleColor ??
                            SeniorColors.primaryColor900,
                      ),
                    ),
                    subtitle == null
                        ? const SizedBox.shrink()
                        : Text(
                            subtitle!,
                            textAlign: TextAlign.left,
                            style: SeniorTypography.small(
                              color: style?.subtitleColor ??
                                  theme.menuListItemTheme?.style
                                      ?.subtitleColor ??
                                  SeniorColors.grayscale50,
                            ),
                          ),
                  ],
                ),
              ),
              Offstage(
                offstage: onTap == null,
                child: Align(
                  alignment: Alignment.center,
                  child: Icon(
                    FontAwesomeIcons.angleRight,
                    color: enabled
                        ? style?.pushIconColor ??
                            theme.menuListItemTheme?.style?.pushIconColor ??
                            SeniorColors.primaryColor500
                        : style?.disabledPushIconColor ??
                            theme.menuListItemTheme?.style
                                ?.disabledPushIconColor ??
                            SeniorColors.grayscale90,
                    size: SeniorIconSize.medium,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
