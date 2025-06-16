class TabBarConfig {
  /// App bar tab settings.
  /// the [tabs], [onSelect] and [tabIndex] parameters are required.
  TabBarConfig({
    required this.tabs,
    required this.onSelect,
    required this.tabIndex,
  });

  /// The titles of the tabs that will be added to the app bar.
  final List<String> tabs;

  /// Callback function that is executed when a tab is selected. The index of the selected tab is provided as a parameter.
  final Function(int)? onSelect;

  /// Index of the tab selected.
  int tabIndex;
}
