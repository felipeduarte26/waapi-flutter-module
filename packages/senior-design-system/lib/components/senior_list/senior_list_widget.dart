import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../theme/senior_theme_data.dart';
import '../../repositories/theme_repository.dart';
import 'models/item_type.dart';
import 'models/senior_list_item.dart';
import 'senior_list_style.dart';

class SeniorList extends StatelessWidget {
  /// Creates the SDS list component.
  ///
  /// The [items] parameter is required.
  const SeniorList({
    Key? key,
    required this.items,
    this.style,
    this.withLineSeparator = false,
  }) : super(key: key);

  /// List items.
  final List<SeniorListItem> items;

  /// The component's style definitions.
  /// Allows you to configure:
  /// [SeniorListStyle.emphasisRightLabelColor] the color of the label on the right of emphasis list items.
  /// [SeniorListStyle.emphasisTitleColor] the title color of list items of type emphasis.
  /// [SeniorListStyle.lineColor] the color of the line that separates the list items.
  /// [SeniorListStyle.neutralRightLabelColor] the color of the label on the right of neutral list items.
  /// [SeniorListStyle.neutralTitleColor] the title color of neutral list items.
  /// [SeniorListStyle.rightIconColor] the icon color on the right.
  /// [SeniorListStyle.subtitleColor] the color of the list item's subtitle.
  final SeniorListStyle? style;

  /// Whether to add a line separating the list items.
  ///
  /// The default value is false.
  final bool withLineSeparator;

  Widget _buildIcon(SeniorListItem item) {
    if (item.icon == null) {
      return const SizedBox.shrink();
    }

    if (item.iconBackground == null) {
      return Padding(
        padding: const EdgeInsets.only(right: SeniorSpacing.small),
        child: Center(
          child: Icon(
            item.icon,
            size: SeniorIconSize.small,
            color: item.iconColor,
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(right: SeniorSpacing.small),
      child: Container(
        height: 20.0,
        width: 20.0,
        decoration: BoxDecoration(
          color: item.iconBackground,
          borderRadius: BorderRadius.circular(SeniorRadius.xsmall),
        ),
        child: Center(
          child: Icon(
            item.icon,
            size: SeniorIconSize.xsmall,
            color: item.iconColor,
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(SeniorListItem item, SeniorThemeData theme) {
    if (item.title == null) {
      return const SizedBox.shrink();
    }

    final Widget itemTitle;
    final Widget itemSubtitle = item.subtitle != null
        ? Text(
            item.subtitle!,
            style: SeniorTypography.small(
              color: style?.subtitleColor ??
                  theme.listTheme?.style?.subtitleColor ??
                  SeniorColors.grayscale50,
            ),
          )
        : const SizedBox.shrink();

    switch (item.type) {
      case ItemType.emphasis:
        itemTitle = Text(
          item.title!,
          style: SeniorTypography.body(
            color: style?.emphasisTitleColor ??
                theme.listTheme?.style?.emphasisTitleColor ??
                SeniorColors.primaryColor500,
          ),
        );
        break;
      case ItemType.emphasisBold:
        itemTitle = Text(
          item.title!,
          style: SeniorTypography.cta(
            color: style?.emphasisTitleColor ??
                theme.listTheme?.style?.emphasisTitleColor ??
                SeniorColors.primaryColor500,
          ),
        );
        break;
      case ItemType.neutral:
        itemTitle = Text(
          item.title!,
          style: SeniorTypography.body(
            color: style?.neutralTitleColor ??
                theme.listTheme?.style?.neutralTitleColor ??
                SeniorColors.grayscale80,
          ),
        );
        break;
      case ItemType.neutralBold:
        itemTitle = Text(
          item.title!,
          style: SeniorTypography.cta(
            color: style?.neutralTitleColor ??
                theme.listTheme?.style?.neutralTitleColor ??
                SeniorColors.grayscale80,
          ),
        );
        break;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        itemTitle,
        itemSubtitle,
      ],
    );
  }

  Widget _buildRightElement(SeniorListItem item, SeniorThemeData theme) {
    if (item.rightIcon != null) {
      return Icon(
        item.rightIcon,
        size: SeniorIconSize.xsmall,
        color: style?.rightIconColor ??
            theme.listTheme?.style?.rightIconColor ??
            SeniorColors.grayscale80,
      );
    } else if (item.rightLabel != null) {
      switch (item.type) {
        case ItemType.emphasis:
          return Text(
            item.rightLabel!,
            style: SeniorTypography.body(
                color: style?.emphasisRightLabelColor ??
                    theme.listTheme?.style?.emphasisRightLabelColor ??
                    SeniorColors.primaryColor500),
          );
        case ItemType.emphasisBold:
          return Text(
            item.rightLabel!,
            style: SeniorTypography.h4(
                color: style?.emphasisRightLabelColor ??
                    theme.listTheme?.style?.emphasisRightLabelColor ??
                    SeniorColors.primaryColor500),
          );
        case ItemType.neutral:
          return Text(
            item.rightLabel!,
            style: SeniorTypography.body(
                color: style?.neutralRightLabelColor ??
                    theme.listTheme?.style?.neutralRightLabelColor ??
                    SeniorColors.grayscale60),
          );
        case ItemType.neutralBold:
          return Text(
            item.rightLabel!,
            style: SeniorTypography.h4(
                color: style?.neutralRightLabelColor ??
                    theme.listTheme?.style?.neutralRightLabelColor ??
                    SeniorColors.grayscale60),
          );
      }
    }
    return const SizedBox.shrink();
  }

  Widget _buildItem(SeniorListItem item, SeniorThemeData theme) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        child: InkWell(
          onTap: item.onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    _buildIcon(item),
                    Expanded(
                      child: _buildTitle(item, theme),
                    ),
                  ],
                ),
              ),
              _buildRightElement(item, theme),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeRepository>(context).theme;

    final line = Padding(
      padding: const EdgeInsets.only(
        top: SeniorSpacing.small,
        bottom: SeniorSpacing.medium,
      ),
      child: Container(
        height: 1.0,
        width: double.infinity,
        color: style?.lineColor ??
            theme.listTheme?.style?.lineColor ??
            SeniorColors.grayscale20,
      ),
    );

    const spacing = const SizedBox(
      height: SeniorSpacing.medium,
    );

    return ListView.separated(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return _buildItem(items[index], theme);
      },
      separatorBuilder: (context, index) {
        return withLineSeparator ? line : spacing;
      },
      itemCount: items.length,
    );

    // return Column(
    //   children: items.map((item) {
    //     return Column(
    //       children: [
    //         _buildItem(item, theme),
    //         withLineSeparator ? line : spacing,
    //       ],
    //     );
    //   }).toList(),
    // );
  }
}
