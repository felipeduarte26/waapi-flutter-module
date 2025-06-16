import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../theme/senior_theme_data.dart';
import './senior_timeline_style.dart';
import './senior_timeline_theme.dart';
import '../../repositories/theme_repository.dart';

class Timeline extends StatefulWidget {
  /// Creates a timeline component according to SDS definitions.
  ///
  /// The [children] and [indicators] parameters are required.
  /// The number of records in [children] and [indicators] must be equal.
  const Timeline({
    Key? key,
    required this.children,
    this.controller,
    this.gutterSpacing,
    required this.indicators,
    this.indicatorSize,
    this.isLeftAligned = true,
    this.itemGap,
    this.lineGap,
    this.minimizeable = false,
    this.padding = const EdgeInsets.all(SeniorSpacing.small),
    this.physics,
    this.primary = false,
    this.reverse = false,
    this.shrinkWrap = true,
    this.strokeWidth,
    this.style,
  })  : itemCount = children.length,
        assert(children.length == indicators.length),
        super(key: key);

  /// The timeline items.
  ///
  /// The number of elements in the list must be equivalent to the number of items in the list [indicators].
  final List<Widget> children;

  /// ScrollController of the list of timeline elements.
  final ScrollController? controller;

  /// Spacing between indicators and their respective content.
  ///
  /// Can be set on instance if [SeniorTheme] assigned to app in [SeniorTimelineThemeData.gutterSpacing] parameter.
  /// The default value is [SeniorSpacing.small] (12 logical pixels).
  final double? gutterSpacing;

  /// Timeline indicators. The quantity of items must be equivalent to the quantity of items of [children].
  final List<SeniorTimelineIndicator> indicators;

  /// Defines the size of timeline indicators.
  ///
  /// It can be set on the [SeniorTheme] instance assigned to the app in the [SeniorTimelineThemeData.indicatorSize]
  /// parameter.
  /// The default value is 32 logical pixels.
  final double? indicatorSize;

  /// Defines whether timeline indicators will be left-aligned.
  ///
  /// The default value is true.
  final bool isLeftAligned;

  /// The number of items on the timeline.
  final int itemCount;

  /// Spacing between timeline indicators.
  ///
  /// It can be set on the [SeniorTheme] instance assigned to the app in the [SeniorTimelineThemeData.itemGap] parameter.
  /// The default value is [SeniorSpacing.xbig] (40 logical pixels).
  final double? itemGap;

  /// Spacing between the line and the indicator. This value is within the value of [itemGap].
  ///
  /// It can be set on the [SeniorTheme] instance assigned to the app in the [SeniorTimelineThemeData.lineGap] parameter.
  /// The default value is [SeniorSpacing.xsmall] (8 logical pixels).
  final double? lineGap;

  /// Whether the timeline can be expanded and minimized.
  ///
  /// The default value is false.
  final bool minimizeable;

  /// Component padding.
  ///
  /// The default value is [SeniorSpacing.small] (12 logical pixels) on all sides of the component.
  final EdgeInsets padding;

  /// Defines the value that will be assigned to the ListView's physics property that contains the timeline items.
  /// Determines how the scrolling view should respond to user input.
  final ScrollPhysics? physics;

  /// Defines the value that will be assigned to the ListView's primary property that contains the timeline items.
  /// Determines whether this is the primary scroll view associated with the parent PrimaryScrollController.
  ///
  /// The default value is false.
  final bool primary;

  /// Defines the value that will be assigned to the reverse property of the ListView that contains the timeline items.
  /// Determines whether the scrolling view scrolls in the reading direction.
  ///
  /// The default value is false.
  final bool reverse;

  /// Defines the value that will be assigned to the ListView's shrinkWrap property that contains the timeline items.
  /// Determines whether the extent of scrolling view in scrollDirection should be determined by the content being viewed.
  ///
  /// The default value is true.
  final bool shrinkWrap;

  /// Defines the thickness of the line between the indicators.
  ///
  /// It can be set on the [SeniorTheme] instance assigned to the app in the [SeniorTimelineThemeData.strokeWidth]
  /// parameter.
  /// The default value is 2 logical pixels.
  final double? strokeWidth;

  /// The style definitions for the component.
  /// As definições de estilo para o componente.
  /// [SeniorTimelineStyle.expandIconColor] the color of the expand icon.
  /// [SeniorTimelineStyle.expandIconSize] the size of the expand icon.
  ///
  /// It can be set on the [SeniorTheme] instance assigned to the app in the [SeniorTimelineThemeData.style] parameter.
  final SeniorTimelineStyle? style;

  @override
  State<Timeline> createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeRepository>(context).theme;
    final double _itemGap =
        widget.itemGap ?? theme.timelineTheme?.itemGap ?? SeniorSpacing.xbig;
    final double _indicatorSize =
        widget.indicatorSize ?? theme.timelineTheme?.indicatorSize ?? 32.0;
    final double _lineGap =
        widget.lineGap ?? theme.timelineTheme?.lineGap ?? SeniorSpacing.xsmall;
    final double _strokeWidth =
        widget.strokeWidth ?? theme.timelineTheme?.strokeWidth ?? 2.0;
    final double _gutterSpacing = widget.gutterSpacing ??
        theme.timelineTheme?.gutterSpacing ??
        SeniorSpacing.small;

    return ListView.separated(
      padding: widget.padding,
      separatorBuilder: (_, __) => SizedBox(height: _itemGap),
      physics: widget.physics,
      shrinkWrap: widget.shrinkWrap,
      itemCount: _expanded || !widget.minimizeable ? widget.itemCount : 1,
      controller: widget.controller,
      reverse: widget.reverse,
      primary: widget.primary,
      itemBuilder: (context, index) {
        final child = widget.children[index];
        final bool isFirst = index == 0;
        final bool isLast = index == widget.itemCount - 1;
        final List<Color> colors =
            widget.indicators.map((indicator) => indicator.color).toList();
        final Color indicatorColor = theme.themeType == ThemeType.dark
            ? widget.indicators[index].darkColor ??
                widget.indicators[index].color
            : widget.indicators[index].color;
        final Color indicatorIconColor = theme.themeType == ThemeType.dark
            ? widget.indicators[index].iconDarkColor ??
                widget.indicators[index].iconColor
            : widget.indicators[index].iconColor;

        final Widget? indicator = Center(
          child: Stack(
            children: [
              Container(
                height: _indicatorSize,
                width: _indicatorSize,
                decoration: BoxDecoration(
                  color: indicatorColor,
                  borderRadius: BorderRadius.circular(_indicatorSize / 2),
                ),
                child: Center(
                  child: widget.indicators[index].iconId != null
                      ? Icon(
                          widget.indicators[index].iconId,
                          size: SeniorIconSize.xsmall,
                          color: indicatorIconColor,
                        )
                      : Text(
                          widget.indicators[index].textId!,
                          style: widget.indicators[index].textId!.length > 2
                              ? SeniorTypography.bodyBold(
                                  color: indicatorIconColor)
                              : SeniorTypography.label(
                                  color: indicatorIconColor),
                        ),
                ),
              ),
            ],
          ),
        );

        final Widget expanderButton = isFirst && widget.minimizeable
            ? Padding(
                padding: const EdgeInsets.all(SeniorSpacing.xsmall),
                child: Icon(
                  _expanded
                      ? FontAwesomeIcons.chevronUp
                      : FontAwesomeIcons.chevronDown,
                  size: theme.timelineTheme?.style?.expandIconSize ??
                      SeniorIconSize.small,
                  color: theme.timelineTheme?.style?.expandIconColor ??
                      SeniorColors.grayscale90,
                ),
              )
            : const SizedBox.shrink();

        final timelineTile = [
          CustomPaint(
            foregroundPainter: _expanded || !widget.minimizeable
                ? _TimelinePainter(
                    indicatorSize: _indicatorSize,
                    isFirst: isFirst,
                    isLast: isLast,
                    lineGap: _lineGap,
                    strokeWidth: _strokeWidth,
                    itemGap: _itemGap,
                    itemColor: colors[index],
                    previousItemColor: index > 0 ? colors[index - 1] : null,
                  )
                : null,
            child: SizedBox(
              height: double.infinity,
              width: _indicatorSize,
              child: indicator,
            ),
          ),
          SizedBox(
            width: _gutterSpacing,
          ),
          Expanded(child: child),
          expanderButton,
        ];

        return IntrinsicHeight(
          child: GestureDetector(
            onTap: isFirst && widget.minimizeable
                ? () => setState(() => _expanded = !_expanded)
                : null,
            child: Container(
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: widget.isLeftAligned
                    ? timelineTile
                    : timelineTile.reversed.toList(),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _TimelinePainter extends CustomPainter {
  _TimelinePainter({
    required this.indicatorSize,
    required this.itemGap,
    required this.isFirst,
    required this.isLast,
    this.itemColor,
    required this.lineGap,
    this.previousItemColor,
    required this.strokeWidth,
  });

  final double indicatorSize;
  final double itemGap;
  final bool isFirst;
  final bool isLast;
  final Color? itemColor;
  final double lineGap;
  final Color? previousItemColor;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final indicatorRadius = indicatorSize / 2;
    final halfItemGap = itemGap / 2;
    final indicatorMargin = indicatorRadius + lineGap;
    final top = size.topLeft(Offset(indicatorRadius, 0.0 - halfItemGap));
    final centerTop =
        size.centerLeft(Offset(indicatorRadius, -indicatorMargin));
    final bottom = size.bottomLeft(Offset(indicatorRadius, 0.0 + halfItemGap));
    final centerBottom =
        size.centerLeft(Offset(indicatorRadius, indicatorMargin));

    if (!isFirst) {
      canvas.drawLine(
        top,
        centerTop,
        Paint()
          ..color = previousItemColor ?? SeniorColors.grayscale90
          ..strokeCap = StrokeCap.round
          ..strokeWidth = strokeWidth
          ..style = PaintingStyle.stroke,
      );
    }

    if (!isLast) {
      canvas.drawLine(
        centerBottom,
        bottom,
        Paint()
          ..color = itemColor ?? SeniorColors.grayscale90
          ..strokeCap = StrokeCap.round
          ..strokeWidth = strokeWidth
          ..style = PaintingStyle.stroke,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class SeniorTimelineIndicator {
  /// Defines an indicator for the Timeline component.
  /// The [color] and [iconColor] parameters are required.
  /// Do not enter a [textId] and [IconId] at the same time. Only one.
  const SeniorTimelineIndicator({
    required this.color,
    this.darkColor,
    this.iconId,
    required this.iconColor,
    this.iconDarkColor,
    this.textId,
  }) : assert(!(iconId != null && textId != null));

  /// The identifier color.
  final Color color;

  /// The identifier color when in dark mode. If not informed, it assumes the value of [color].
  final Color? darkColor;

  /// The icon that will be applied as the identifier of the indicator.
  final IconData? iconId;

  /// Defines the indicator icon color. If text is being used instead of an icon, change the text color.
  final Color iconColor;

  /// Defines icon color when in dark mode. If not informed, it assumes the value of [iconColor].
  final Color? iconDarkColor;

  /// The text that will be applied as the indicator's identifier.
  final String? textId;
}
