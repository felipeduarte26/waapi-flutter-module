import './senior_expansion_panel_list_style.dart';

class SeniorExpansionPanelListThemeData {
  /// Theme definitions for the SeniorExpansionPanelList component.
  const SeniorExpansionPanelListThemeData({
    this.style,
  });

  /// Component style definition.
  /// Allows you to configure:
  /// [SeniorExpansionPanelListStyle.backgroundColor] the component's background color.
  final SeniorExpansionPanelListStyle? style;

  SeniorExpansionPanelListThemeData copyWith({
    SeniorExpansionPanelListStyle? style,
  }) {
    return SeniorExpansionPanelListThemeData(
      style: style ?? this.style,
    );
  }
}
