import 'package:flutter/material.dart';

import './components/components.dart';
import './senior_expandable_list_style.dart';
import './models/senior_expandable_list_item_data.dart';

class SeniorExpandableList extends StatelessWidget {
  /// Creates an SDS expandable list component.
  /// The [items] parameter is required.
  const SeniorExpandableList({
    super.key,
    required this.items,
    this.style,
  });

  /// List items data.
  final List<SeniorExpandableListItemData> items;

  /// Style definitions for the component.
  /// Allows you to configure:
  /// [SeniorExpandableListStyle.titleColor] the list items title color.
  /// [SeniorExpandableListStyle.summaryColor] the list items summary color.
  /// [SeniorExpandableListStyle.iconColor] the list items icon color.
  /// [SeniorExpandableListStyle.arrowIconColor] the list items arrow icon color.
  /// [SeniorExpandableListStyle.separationLine] the list items separation line color.
  final SeniorExpandableListStyle? style;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: items
            .map((item) => SeniorExpandableListItem(
                  title: item.title,
                  summary: item.summary,
                  icon: item.icon,
                  disabled: item.disabled,
                  child: item.content,
                  style: style,
                ))
            .toList(),
      ),
    );
  }
}
