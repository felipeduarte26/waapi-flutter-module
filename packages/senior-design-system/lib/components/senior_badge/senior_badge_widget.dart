import 'package:flutter/material.dart';

import 'package:senior_design_tokens/senior_design_tokens.dart';

import 'models/senior_badge_shape.dart';
import 'models/senior_badge_icon_position.dart';
import './components/senior_badge_base.dart';

class SeniorBadge extends StatefulWidget {
  /// Creates an Badge component.
  /// The [backgroundColor], [fontColor] and [label] parameters are required.
  SeniorBadge({
    Key? key,
    required this.backgroundColor,
    required this.fontColor,
    required this.label,
    this.shape = SeniorBadgeShape.chip,
    this.outlined = false,
    this.value,
    this.selected = false,
    this.onSelect,
    this.disabled = false,
    this.disabledBackgroundColor,
    this.disabledFontColor,
    this.count,
    this.selectedBackgroundColor,
    this.selectedFontColor,
    this.counterColor = SeniorColors.grayscale80,
    this.couterBackgroundColor = SeniorColors.grayscale30,
    this.textStyle,
    this.padding,
  }) : super(key: key);

  /// Defines the background color of the badge.
  final Color backgroundColor;

  /// Defines if the badge will be disabled.
  /// The default value is false.
  final bool disabled;

  /// Defines the background color of the badge when it is disabled.
  /// If this parameter is not informed, there will be no distinction in the background color of the badge when enabled and disabled.
  final Color? disabledBackgroundColor;

  /// Defines the font color of the badge's label when it is disabled.
  /// If this parameter is not informed, there will be no distinction in the font color of the badge when enabled and disabled.
  final Color? disabledFontColor;

  /// Defines the font color of the badge's label when it is disabled.
  final Color fontColor;

  /// The text that is displayed on the badge.
  final String label;

  /// Defines whether the badge will have a line around it.
  final bool outlined;

  /// Defines the format of the badge, which can be [Senior Badge Shape.chip] and [SeniorBadgeShape.pill].
  final SeniorBadgeShape shape;

  /// A value that the badge element will represent.
  final dynamic value;

  // Defines whether the badge will be selected.
  final bool selected;

  /// Function executed when the badge is selected. Returns the stored value.
  final Function(dynamic)? onSelect;

  /// A counter that is displayed to the right of the badge content.
  final int? count;

  /// Defines the color of the bag when it is selected.
  final Color? selectedBackgroundColor;

  /// Defines the font color of the badge when it is selected.
  final Color? selectedFontColor;

  /// Defines the font color of the badge counter.
  final Color counterColor;

  /// Defines the background color of the badge counter.
  final Color couterBackgroundColor;

  /// Defines the badge text style
  final TextStyle? textStyle;

  /// Defines the badge internal padding
  final EdgeInsets? padding;

  /// Creates an Badge with icon component.
  /// The [backgroundColor], [fontColor], [label], [onSelect] parameters are required.
  factory SeniorBadge.icon({
    required Color backgroundColor,
    required Color fontColor,
    required String label,
    SeniorBadgeShape shape,
    bool outlined,
    dynamic value,
    bool selected,
    Function(dynamic)? onSelect,
    bool disabled,
    Color disabledBackgroundColor,
    Color disabledFontColor,
    int count,
    Color selectedBackgroundColor,
    Color selectedFontColor,
    Color counterColor,
    Color couterBackgroundColor,
    Color selectedIconColor,
    required IconData icon,
    Color iconColor,
    Color disabledIconColor,
    SeniorBadgeIconPosition iconPosition,
    TextStyle? textStyle,
    EdgeInsets? padding,
  }) = _SeniorBadgeIcon;

  @override
  State<SeniorBadge> createState() => _SeniorBadgeState();
}

class _SeniorBadgeState extends State<SeniorBadge> {
  bool _selected = false;

  @override
  Widget build(BuildContext context) {
    _selected = widget.selected;

    return Semantics(
      button: widget.onSelect != null,
      enabled: !widget.disabled,
      child: GestureDetector(
        onTap: () {
          if (!widget.disabled && widget.onSelect != null) {
            widget.onSelect!(widget.value);
            setState(() {
              _selected = !_selected;
            });
          }
        },
        child: SeniorBadgeBase(
          selected: _selected,
          backgroundColor: widget.backgroundColor,
          fontColor: widget.fontColor,
          label: widget.label,
          shape: widget.shape,
          outlined: widget.outlined,
          value: widget.value,
          onSelect: widget.onSelect,
          disabled: widget.disabled,
          disabledBackgroundColor: widget.disabledBackgroundColor,
          disabledFontColor: widget.disabledFontColor,
          count: widget.count,
          selectedBackgroundColor: widget.selectedBackgroundColor,
          selectedFontColor: widget.selectedFontColor,
          counterColor: widget.counterColor,
          couterBackgroundColor: widget.couterBackgroundColor,
          textStyle: widget.textStyle,
          padding: widget.padding,
        ),
      ),
    );
  }
}

class _SeniorBadgeIcon extends SeniorBadge {
  _SeniorBadgeIcon({
    required super.backgroundColor,
    required super.fontColor,
    required super.label,
    super.shape = SeniorBadgeShape.chip,
    super.outlined = false,
    super.value,
    super.selected = false,
    super.onSelect,
    super.disabled = false,
    super.disabledBackgroundColor,
    super.disabledFontColor,
    super.count,
    super.selectedBackgroundColor,
    super.selectedFontColor,
    super.counterColor,
    super.couterBackgroundColor,
    this.selectedIconColor,
    required this.icon,
    this.iconColor,
    this.disabledIconColor,
    this.iconPosition = SeniorBadgeIconPosition.left,
    super.textStyle,
    super.padding,
  });

  /// The icon that will be displayed inside the badge.
  final IconData icon;

  /// Defines the color of the badge icon.
  final Color? iconColor;

  /// Defines the icon color of the bagde when it is disabled.
  /// If this parameter is not informed, there will be no distinction between enabled and disabled.
  final Color? disabledIconColor;

  /// Defines the position of the icon, which can be [SeniorBadgeIconPosition.left] and [SeniorBadgeIconPosition.right].
  /// The default value is [SeniorBadgeIconPosition.left].
  final SeniorBadgeIconPosition iconPosition;

  /// Defines the color of the badge icon when it is selected.
  /// If this parameter is not informed, there will be no distinction between enabled and disabled.
  final Color? selectedIconColor;

  @override
  State<_SeniorBadgeIcon> createState() => _SeniorBadgeIconState();
}

class _SeniorBadgeIconState extends State<_SeniorBadgeIcon> {
  bool _selected = false;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: widget.onSelect != null,
      enabled: !widget.disabled,
      child: GestureDetector(
        onTap: () {
          if (!widget.disabled && widget.onSelect != null) {
            widget.onSelect!(widget.value);
            setState(() {
              _selected = !_selected;
            });
          }
        },
        child: SeniorBadgeBase(
          backgroundColor: widget.backgroundColor,
          fontColor: widget.fontColor,
          icon: widget.icon,
          iconColor: widget.iconColor,
          label: widget.label,
          selected: _selected,
          count: widget.count,
          disabled: widget.disabled,
          disabledBackgroundColor: widget.disabledBackgroundColor,
          disabledFontColor: widget.disabledFontColor,
          disabledIconColor: widget.disabledIconColor,
          iconPosition: widget.iconPosition,
          onSelect: widget.onSelect,
          outlined: widget.outlined,
          selectedBackgroundColor: widget.selectedBackgroundColor,
          selectedFontColor: widget.selectedFontColor,
          selectedIconColor: widget.selectedIconColor,
          shape: widget.shape,
          value: widget.value,
          counterColor: widget.counterColor,
          couterBackgroundColor: widget.couterBackgroundColor,
          textStyle: widget.textStyle,
          padding: widget.padding,
        ),
      ),
    );
  }
}
