import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../repositories/theme_repository.dart';
import './senior_bottom_navigation_bar_style.dart';

class SeniorBottomNavigationBarItem {
  /// The information needed to create a SeniorBottomNavigationBar component item.
  ///
  /// The [icon] and [label] parameters are required.
  const SeniorBottomNavigationBarItem({
    required this.icon,
    required this.label,
    this.activeIcon,
    this.badgeInfo,
    this.iconSize,
    this.iconPadding,
  });

  /// The item icon.
  final IconData icon;

  /// The item's label.
  final String label;

  /// The item's icon when it is selected.
  final IconData? activeIcon;

  /// Information that will be displayed in a badge on the item.
  final String? badgeInfo;

  /// The size of the item's icon.
  final double? iconSize;

  final EdgeInsetsGeometry? iconPadding;
}

class SeniorBottomNavigationBar extends StatelessWidget {
  /// Creates a bottom navigation bar component.
  ///
  /// The [currentIndex], [items] and [onTap] parameters are required.
  const SeniorBottomNavigationBar({
    Key? key,
    required this.currentIndex,
    required this.items,
    required this.onTap,
    this.style,
  }) : super(key: key);

  /// The index representing the item initially selected in the bottom navigation bar.
  final int currentIndex;

  /// The bottom navigation bar items.
  final List<SeniorBottomNavigationBarItem> items;

  /// Callback function executed when an item from the bottom navigation bar is selected.
  /// Receives the index of the selected item.
  final Function(int) onTap;

  /// The component's style definitions.
  /// Allows you to configure:
  /// [SeniorBottomNavigationBarStyle.badgeColor] the badge color of the bottom navigation bar items.
  /// [SeniorBottomNavigationBarStyle.badgeItemColor] the content color of badges for bottom navigation bar items.
  /// [SeniorBottomNavigationBarStyle.color] the color of the bottom navigation bar.
  /// [SeniorBottomNavigationBarStyle.selectedItemColor] the color of the selected bottom navigation bar item.
  /// [SeniorBottomNavigationBarStyle.unselectedItemColor] the color of unselected items from the bottom navigation bar.
  final SeniorBottomNavigationBarStyle? style;

  Widget _buildIcon({
    required IconData icon,
    required Color badgeColor,
    required Color badgeItemColor,
    String? badgeInfo,
    double? iconSize,
    EdgeInsetsGeometry? iconPadding,
  }) {
    return badgeInfo != null
        ? Badge(
            backgroundColor: badgeColor,
            label: Text(
              badgeInfo,
              style: SeniorTypography.small(
                color: badgeItemColor,
              ),
            ),
            child: Icon(
              icon,
              size: iconSize ?? SeniorIconSize.medium,
            ),
          )
        : Padding(
            padding: iconPadding ?? EdgeInsets.zero,
            child: Icon(
              icon,
              size: iconSize ?? SeniorIconSize.medium,
            ),
          );
  }

  List<BottomNavigationBarItem> buildBottomNavBarItems({
    required Color color,
    required Color badgeColor,
    required Color badgeItemColor,
  }) {
    final List<BottomNavigationBarItem> bottomNavItems = [];

    items.forEach((item) {
      bottomNavItems.add(
        BottomNavigationBarItem(
          icon: _buildIcon(
            icon: item.icon,
            badgeInfo: item.badgeInfo,
            badgeColor: badgeColor,
            badgeItemColor: badgeItemColor,
            iconSize: item.iconSize,
            iconPadding: item.iconPadding,
          ),
          activeIcon: _buildIcon(
            icon: item.activeIcon ?? item.icon,
            badgeInfo: item.badgeInfo,
            badgeColor: badgeColor,
            badgeItemColor: badgeItemColor,
            iconSize: item.iconSize,
            iconPadding: item.iconPadding,
          ),
          label: item.label,
          backgroundColor: color,
        ),
      );
    });

    return bottomNavItems;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeRepository>(context).theme;

    final Color selectedItemColor = style?.selectedItemColor ??
        theme.bottomNavigationBarTheme?.style?.selectedItemColor ??
        SeniorColors.primaryColor;

    final Color unselectedItemColor = style?.unselectedItemColor ??
        theme.bottomNavigationBarTheme?.style?.unselectedItemColor ??
        SeniorColors.grayscale50;

    return BottomNavigationBar(
      key: key,
      backgroundColor: style?.color ??
          theme.bottomNavigationBarTheme?.style?.color ??
          SeniorColors.grayscale10,
      type: BottomNavigationBarType.fixed,
      items: buildBottomNavBarItems(
        color: style?.color ??
            theme.bottomNavigationBarTheme?.style?.color ??
            SeniorColors.grayscale10,
        badgeColor: style?.badgeColor ??
            theme.bottomNavigationBarTheme?.style?.badgeColor ??
            SeniorColors.primaryColor,
        badgeItemColor: style?.badgeItemColor ??
            theme.bottomNavigationBarTheme?.style?.badgeItemColor ??
            SeniorColors.pureWhite,
      ),
      currentIndex: currentIndex,
      iconSize: SeniorIconSize.medium,
      showSelectedLabels: true,
      selectedLabelStyle: TextStyle(
        color: selectedItemColor,
        fontFamily: 'ProductSans',
        fontSize: 14,
      ),
      selectedItemColor: selectedItemColor,
      showUnselectedLabels: true,
      unselectedLabelStyle: TextStyle(
        color: unselectedItemColor,
        fontSize: 14,
        fontFamily: 'ProductSans',
      ),
      unselectedItemColor: unselectedItemColor,
      onTap: onTap,
    );
  }
}
