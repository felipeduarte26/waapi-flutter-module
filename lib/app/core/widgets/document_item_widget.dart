import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

class DocumentItemWidget extends StatefulWidget {
  final String? title;
  final List<String>? items;
  final Function()? onTap;
  final EdgeInsets padding;
  final CrossAxisAlignment crossAxisAlignment;

  const DocumentItemWidget({
    Key? key,
    this.title,
    this.items,
    this.onTap,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.padding = const EdgeInsets.symmetric(
      horizontal: SeniorSpacing.xbig,
      vertical: SeniorSpacing.normal,
    ),
  }) : super(key: key);

  @override
  State<DocumentItemWidget> createState() => _DocumentItemWidgetState();
}

class _DocumentItemWidgetState extends State<DocumentItemWidget> {
  Widget _buildItems(List<String>? items, SeniorThemeData theme) {
    return items != null
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: items
                .map(
                  (item) => SeniorText.small(
                    item,
                    color: theme.contactBookItemTheme?.style?.itemsColor,
                    darkColor: theme.contactBookItemTheme?.style?.itemsColor,
                  ),
                )
                .toList(),
          )
        : const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeRepository>(context).theme;

    return InkWell(
      onTap: widget.onTap,
      child: Container(
        padding: widget.padding,
        child: Column(
          crossAxisAlignment: widget.crossAxisAlignment,
          children: [
            widget.title == null
                ? const SizedBox.shrink()
                : Container(
                    padding: widget.items != null
                        ? const EdgeInsets.only(
                            bottom: SeniorSpacing.xxsmall,
                          )
                        : null,
                    child: SeniorText.small(
                      textProperties: TextProperties(
                        textAlign:
                            widget.crossAxisAlignment == CrossAxisAlignment.end ? TextAlign.right : TextAlign.left,
                        maxLines: 2,
                      ),
                      widget.title!,
                      color: theme.contactBookItemTheme?.style?.titleColor,
                      darkColor: theme.contactBookItemTheme?.style?.titleColor,
                    ),
                  ),
            _buildItems(widget.items, theme),
          ],
        ),
      ),
    );
  }
}
