import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

class FeedbackSelectorCardWidget extends StatefulWidget {
  final void Function()? onTap;
  final VoidCallback? onTapIcon;
  final Widget title;
  final Widget content;
  final SeniorIcon? icon;

  const FeedbackSelectorCardWidget({
    Key? key,
    required this.onTap,
    required this.title,
    required this.content,
    this.icon,
    this.onTapIcon,
  }) : super(key: key);

  @override
  State<FeedbackSelectorCardWidget> createState() {
    return _FeedbackSelectorCardWidgetState();
  }
}

class _FeedbackSelectorCardWidgetState extends State<FeedbackSelectorCardWidget> {
  @override
  Widget build(BuildContext context) {
    return SeniorElevatedElement(
      elevation: SeniorElevations.dp01,
      borderRadius: SeniorRadius.xbig,
      child: Material(
        borderRadius: BorderRadius.circular(SeniorRadius.xbig),
        color: Provider.of<ThemeRepository>(context).isDarkTheme()
            ? Provider.of<ThemeRepository>(context).theme.cardTheme!.style!.backgroundColor
            : SeniorColors.neutralColor100,
        child: InkWell(
          onTap: widget.onTap,
          borderRadius: BorderRadius.circular(SeniorRadius.xbig),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(SeniorRadius.xbig),
            ),
            child: Padding(
              padding: const EdgeInsets.all(SeniorSpacing.small),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        widget.title,
                        widget.content,
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: SeniorSpacing.xsmall,
                  ),
                  widget.icon == null
                      ? const SizedBox.shrink()
                      : GestureDetector(
                          onTap: widget.onTapIcon,
                          child: SizedBox(
                            height: IconTheme.of(context).size,
                            width: IconTheme.of(context).size,
                            child: Align(
                              alignment: Alignment.center,
                              child: widget.icon,
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
