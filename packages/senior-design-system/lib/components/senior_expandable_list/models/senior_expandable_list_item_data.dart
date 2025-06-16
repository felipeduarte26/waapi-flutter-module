import 'package:flutter/material.dart';

class SeniorExpandableListItemData {
  /// Data of expandable list item.
  /// The [title], [icon] and [content] are required.
  const SeniorExpandableListItemData({
    required this.title,
    this.summary,
    required this.icon,
    required this.content,
    this.disabled = false,
  });

  /// The title of the list item.
  final String title;

  /// A summary of the list item.
  final String? summary;

  /// The list item icon.
  final IconData icon;

  /// The content of the list item.
  final Widget content;

  /// Defines whether the list item will be disabled.
  /// Default value is false.
  final bool disabled;
}
