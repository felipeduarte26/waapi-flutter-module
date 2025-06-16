import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import './senior_contact_book_item_style.dart';
import '../../repositories/theme_repository.dart';
import '../../theme/senior_theme_data.dart';

class SeniorContactBookItem extends StatelessWidget {
  /// Creates the SDS ContactBookItem component.
  const SeniorContactBookItem({
    Key? key,
    this.items,
    this.onTap,
    this.padding = const EdgeInsets.symmetric(
      horizontal: SeniorSpacing.xbig,
      vertical: SeniorSpacing.normal,
    ),
    this.style,
    this.title,
  }) : super(key: key);

  /// The component items.
  /// The information displayed in the component.
  final List<String>? items;

  /// Callback function that is executed when the item is tapped.
  final Function()? onTap;

  /// A padding that will be added to the component.
  ///
  /// The default value is a padding with [SeniorSpacing.xbig] horizontally and [SeniorSpacing.normal] vertically.
  final EdgeInsets padding;

  /// Component style definitions.
  /// Allows you to configure:
  /// [SeniorContactBookItemStyle.titleColor] the color of the item's title.
  /// [SeniorContactBookItemStyle.itemsColor] the color of the item's contents.
  final SeniorContactBookItemStyle? style;

  /// The item's title.
  final String? title;

  Widget _buildItems({
    required SeniorThemeData theme,
    required List<String>? items,
  }) {
    return items != null
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: items
                .map((item) => Text(
                      item,
                      style: SeniorTypography.small(
                        color: style?.itemsColor ??
                            theme.contactBookItemTheme?.style?.itemsColor ??
                            SeniorColors.grayscale50,
                      ),
                    ))
                .toList(),
          )
        : const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeRepository>(context).theme;

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            title == null
                ? const SizedBox.shrink()
                : Container(
                    padding: items != null
                        ? const EdgeInsets.only(bottom: SeniorSpacing.xxsmall)
                        : null,
                    child: Text(
                      title!,
                      style: SeniorTypography.body(
                        color: style?.titleColor ??
                            theme.contactBookItemTheme?.style?.titleColor ??
                            SeniorColors.grayscale80,
                      ),
                    ),
                  ),
            _buildItems(items: items, theme: theme),
          ],
        ),
      ),
    );
  }
}
