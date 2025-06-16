import 'package:flutter/material.dart';

class SeniorBackdropTabBarInfo {
  /// Settings for adding tabs to the backdrop.
  /// The [controller], [initialIndex] and [tabs] parameters are required.
  SeniorBackdropTabBarInfo({
    required this.controller,
    required this.initialIndex,
    this.isScrollable = false,
    this.onTap,
    required this.tabs,
  })  : assert(tabs.isNotEmpty),
        assert(initialIndex >= 0 && initialIndex < tabs.length);

  /// The controller for the backdrop tabs.
  final TabController controller;

  /// The index of the home tab of the backdrop tab list.
  final int initialIndex;

  /// Defines whether the tabs will scroll sideways to accommodate the entire list.
  ///
  /// The default value is false.
  final bool isScrollable;

  /// Callback function executed when a tab is selected.
  /// It receives the index of the current tab as a parameter.
  final Function(int)? onTap;

  /// The backdrop tab list.
  final List<String> tabs;
}
