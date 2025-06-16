import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

class SeniorDraggableItem {
  /// Information for creating an item for the Senior Draggable List component.
  ///
  /// The [text], [color], [textColor] and [iconColor] parameters are required.
  const SeniorDraggableItem({
    this.key,
    required this.color,
    required this.iconColor,
    required this.text,
    required this.textColor,
  });

  /// Key for the component.
  final Key? key;

  /// Item color.
  final Color color;

  /// Item icon color.
  final Color iconColor;

  /// Item text.
  final String text;

  /// Item text color.
  final Color textColor;
}

class SeniorDraggableList extends StatefulWidget {
  /// Creates the SDS draggableList.
  ///
  /// The [items] parameter is required.
  const SeniorDraggableList({
    Key? key,
    required this.items,
    this.padding,
  }) : super(
          key: key,
        );

  /// List items.
  final List<SeniorDraggableItem> items;

  /// A padding that will be added to the component.
  final EdgeInsetsGeometry? padding;

  @override
  State<SeniorDraggableList> createState() => _SeniorDraggableListState();
}

class _SeniorDraggableListState extends State<SeniorDraggableList> {
  Widget buildContent(SeniorDraggableItem item) {
    return Container(
      key: item.key,
      margin: const EdgeInsets.symmetric(vertical: SeniorSpacing.xsmall),
      padding: const EdgeInsets.all(SeniorSpacing.xsmall),
      decoration: BoxDecoration(
        color: item.color,
        borderRadius: BorderRadius.circular(SeniorRadius.small),
      ),
      child: Row(
        children: [
          Expanded(
            child: Center(
              child: Text(
                item.text,
                style: SeniorTypography.smallBold(
                  color: item.textColor,
                ),
              ),
            ),
          ),
          Icon(
            FontAwesomeIcons.sort,
            size: SeniorIconSize.small,
            color: item.iconColor,
          ),
        ],
      ),
    );
  }

  void onReorder(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      final int end = newIndex - 1;
      int i = 0;
      int local = oldIndex;
      final SeniorDraggableItem startItem = widget.items[oldIndex];
      do {
        widget.items[local] = widget.items[++local];
        i++;
      } while (i < end - oldIndex);
      widget.items[end] = startItem;
    }
    // dragging from bottom to top
    else if (oldIndex > newIndex) {
      final startItem = widget.items[oldIndex];
      for (int i = oldIndex; i > newIndex; i--) {
        widget.items[i] = widget.items[i - 1];
      }
      widget.items[newIndex] = startItem;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? const EdgeInsets.all(0),
      child: Theme(
        data: ThemeData(
          canvasColor: Colors.transparent,
        ),
        child: ReorderableListView(
          children: widget.items.map((item) => buildContent(item)).toList(),
          onReorder: onReorder,
        ),
      ),
    );
  }
}
