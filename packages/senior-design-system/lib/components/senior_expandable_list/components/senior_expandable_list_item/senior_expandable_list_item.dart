import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../senior_design_system.dart';

class SeniorExpandableListItem extends StatefulWidget {
  /// Creates an item of expandable list.
  /// The [title], [icon] and [child] parameters are required.
  const SeniorExpandableListItem({
    super.key,
    required this.title,
    this.summary,
    required this.icon,
    this.disabled = false,
    required this.child,
    this.style,
  });

  /// The title of the list item.
  final String title;

  /// A summary of the list item.
  final String? summary;

  /// The list item color.
  final IconData icon;

  /// Defines whether the list item will be disabled.
  /// Default value is false.
  final bool disabled;

  /// The content of the list item.
  final Widget child;

  /// Style definitions for the component.
  /// Allows you to configure:
  /// [SeniorExpandableListStyle.titleColor] the list items title color.
  /// [SeniorExpandableListStyle.summaryColor] the list items summary color.
  /// [SeniorExpandableListStyle.iconColor] the list items icon color.
  /// [SeniorExpandableListStyle.arrowIconColor] the list items arrow icon color.
  /// [SeniorExpandableListStyle.separationLine] the list items separation line color.
  final SeniorExpandableListStyle? style;

  @override
  State<SeniorExpandableListItem> createState() =>
      _SeniorExpandableListItemState();
}

class _SeniorExpandableListItemState extends State<SeniorExpandableListItem> {
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeRepository>(context).theme;

    return GestureDetector(
      onTap: () {
        if (widget.disabled) {
          return;
        }
        setState(() {
          isOpen = !isOpen;
        });
      },
      child: Opacity(
        opacity: widget.disabled ? 0.5 : 1.0,
        child: Container(
          color: Colors.transparent,
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: SeniorSpacing.small),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(SeniorSpacing.xxsmall),
                      child: Icon(
                        widget.icon,
                        size: 20.0,
                        color: widget.style?.iconColor ??
                            theme.expandableListTheme?.style?.iconColor ??
                            SeniorColors.primaryColor400,
                      ),
                    ),
                    const SizedBox(width: SeniorSpacing.xsmall),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SeniorText.labelBold(
                            widget.title,
                            color: widget.style?.titleColor ??
                                theme.expandableListTheme?.style?.titleColor,
                          ),
                          widget.summary != null
                              ? SeniorText.small(
                                  widget.summary!,
                                  color: widget.style?.summaryColor ??
                                      theme.expandableListTheme?.style
                                          ?.summaryColor,
                                )
                              : const SizedBox.shrink(),
                        ],
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(SeniorSpacing.xsmall),
                        child: Icon(
                          isOpen
                              ? FontAwesomeIcons.chevronUp
                              : FontAwesomeIcons.chevronDown,
                          size: SeniorSpacing.small,
                          color: widget.style?.arrowIconColor ??
                              theme
                                  .expandableListTheme?.style?.arrowIconColor ??
                              SeniorColors.grayscale90,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              AnimatedSize(
                duration: const Duration(milliseconds: 180),
                child: ClipRect(
                  child: Align(
                    alignment: Alignment.topCenter,
                    heightFactor: isOpen ? null : 0,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(bottom: SeniorSpacing.small),
                      child: widget.child,
                    ),
                  ),
                ),
              ),
              Container(
                color: widget.style?.separationLine ??
                    theme.expandableListTheme?.style?.separationLine ??
                    SeniorColors.grayscale30,
                height: 1.0,
                width: double.infinity,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
