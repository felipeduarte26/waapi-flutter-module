import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import './senior_expansion_panel_list_style.dart';
import '../../components/senior_button/senior_button_widget.dart';
import '../../repositories/theme_repository.dart';

class SeniorPanelData {
  /// The information needed to create the SeniorExpansionPanelList panels.
  ///
  /// The [headerInfo] parameter is required.
  SeniorPanelData({
    this.actions,
    this.expandedInfo,
    required this.headerInfo,
    this.isExpanded = false,
    this.severityColor = SeniorColors.grayscale10,
  });

  /// A list of action buttons that can be added to the panel.
  final List<SeniorButton>? actions;

  /// The contents of the panel. The content that is omitted when the panel is not expanded.
  final Widget? expandedInfo;

  /// The header content of the panel.
  final Widget headerInfo;

  /// Defines whether the panel will be expanded.
  bool isExpanded;

  /// The panel's highlight color.
  final Color severityColor;
}

class SeniorExpansionPanelList extends StatelessWidget {
  /// Creates the SDS ExpansionPanelList component.
  ///
  /// The [expansionCallback] and [list] parameters are required.
  const SeniorExpansionPanelList({
    Key? key,
    required this.expansionCallback,
    required this.list,
    this.style,
  }) : super(key: key);

  /// Signature for the callback that's called when an [ExpansionPanel] is expanded or collapsed.
  /// The position of the panel within an [ExpansionPanelList] is given by [panelIndex].
  final ExpansionPanelCallback expansionCallback;

  /// List panels.
  final List<SeniorPanelData> list;

  /// The component's style definitions.
  /// Allows you to configure:
  /// [SeniorExpansionPanelListStyle.backgroundColor] the background color of the panel list.
  final SeniorExpansionPanelListStyle? style;

  /// The duration of the animation of expanding the panels.
  final Duration animationDuration = kThemeAnimationDuration;

  bool _isChildExpanded(int index) {
    return list[index].isExpanded;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeRepository>(context).theme;
    final List<Widget> items = [];

    final Color backgroundColor = style?.backgroundColor ??
        theme.expansionPanelListTheme?.style?.backgroundColor ??
        SeniorColors.grayscale10;

    for (int index = 0; index < list.length; index += 1) {
      if (index != 0) {
        items.add(const Divider(height: 15.0));
      }

      final Widget header = Row(
        children: <Widget>[
          Expanded(
            child: AnimatedContainer(
              duration: animationDuration,
              curve: Curves.fastOutSlowIn,
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: SeniorSpacing.normal),
                title: list[index].headerInfo,
              ),
            ),
          ),
          ExpandIcon(
            isExpanded: _isChildExpanded(index),
            padding: const EdgeInsets.all(SeniorSpacing.normal),
            size: SeniorIconSize.small,
            onPressed: (bool isExpanded) {
              expansionCallback(index, isExpanded);
            },
          ),
        ],
      );

      final Widget body = AnimatedCrossFade(
        firstChild: Container(),
        secondChild: Container(
          width: double.maxFinite,
          padding: const EdgeInsets.symmetric(
              horizontal: SeniorSpacing.small, vertical: SeniorSpacing.normal),
          child: Column(
            children: [
              list[index].expandedInfo ?? Container(),
              Padding(
                padding: const EdgeInsets.only(top: SeniorSpacing.big),
                child: Row(
                  children: list[index].actions != null
                      ? list[index]
                          .actions!
                          .asMap()
                          .map((i, action) => MapEntry(
                              i,
                              Expanded(
                                child: Container(
                                  margin: i != list[index].actions!.length - 1
                                      ? const EdgeInsets.only(
                                          right: SeniorSpacing.small)
                                      : const EdgeInsets.all(0),
                                  child: action,
                                ),
                              )))
                          .values
                          .toList()
                      : [],
                ),
              ),
            ],
          ),
        ),
        firstCurve: const Interval(0.0, 0.6, curve: Curves.fastOutSlowIn),
        secondCurve: const Interval(0.4, 1.0, curve: Curves.fastOutSlowIn),
        sizeCurve: Curves.fastOutSlowIn,
        crossFadeState: _isChildExpanded(index)
            ? CrossFadeState.showSecond
            : CrossFadeState.showFirst,
        duration: animationDuration,
      );

      items.add(
        Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius:
                const BorderRadius.all(Radius.circular(SeniorRadius.xbig)),
            gradient: LinearGradient(
              end: const Alignment(-0.97, 0),
              begin: const Alignment(-0.98, 0),
              colors: [list[index].severityColor, backgroundColor],
            ),
          ),
          child: Column(
            children: <Widget>[
              header,
              body,
            ],
          ),
        ),
      );
    }

    return Column(
      children: items,
    );
  }
}
