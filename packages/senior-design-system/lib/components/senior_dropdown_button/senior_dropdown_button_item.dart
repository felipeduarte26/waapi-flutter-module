class SeniorDropdownButtonItem {
  /// Represents the list items of a [SeniorDropdownButton].
  /// The [value] and [title] parameters are required.
  const SeniorDropdownButtonItem({
    required this.value,
    required this.title,
  });

  /// The value that the item represents.
  final dynamic value;

  /// The item's title.
  final String title;
}
