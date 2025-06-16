import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import './senior_tab_bar_style.dart';
import '../../repositories/theme_repository.dart';

class SeniorTabBar extends StatelessWidget implements PreferredSizeWidget {
  /// Creates a SDS tab bar component.
  ///
  /// The [tabs], [initialIndex] and [onTap] parameters are required.
  const SeniorTabBar({
    Key? key,
    required this.tabs,
    required this.initialIndex,
    required this.onTap,
    this.isScrollable = false,
    this.controller,
    this.style,
  }) : super(key: key);

  /// The titles of the component's tabs.
  final List<String> tabs;

  /// Index of the initially selected tab.
  final int initialIndex;

  /// Defines if the component will have a horizontal scroll when the available space does not support all the tabs.
  ///
  /// The default value is false.
  final bool isScrollable;

  /// Callback function executed when a component's tab is touched.
  /// It receives the index of the selected tab as a parameter.
  final Function(int) onTap;

  /// Component's TabController.
  final TabController? controller;

  /// The component's style definitions.
  /// Allows you to configure:
  /// [SeniorTabBarStyle.indicatorColor] the indicator color of the active tab.
  /// [SeniorTabBarStyle.labelColor] the color of the tab label.
  /// [SeniorTabBarStyle.unselectedLabelColor] the label color of disabled tabs.
  final SeniorTabBarStyle? style;

  @override
  Size get preferredSize => const Size.fromHeight(100.0);

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeRepository>(context).theme;

    final Color labelColor = style?.labelColor ??
        theme.tabBarTheme?.style?.labelColor ??
        SeniorColors.grayscale80;

    final Color unselectedLabelColor = style?.unselectedLabelColor ??
        theme.tabBarTheme?.style?.unselectedLabelColor ??
        SeniorColors.grayscale50;

    final Color indicatorColor = style?.indicatorColor ??
        theme.tabBarTheme?.style?.indicatorColor ??
        SeniorColors.primaryColor;

    return TabBar(
      tabs: tabs.map((tab) => Tab(text: tab)).toList(),
      labelColor: labelColor,
      unselectedLabelColor: unselectedLabelColor,
      indicatorColor: indicatorColor,
      labelStyle: SeniorTypography.body(
        color: labelColor,
      ),
      indicatorWeight: 2.0,
      isScrollable: isScrollable,
      onTap: onTap,
      controller: controller,
    );
  }
}
