import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

class DependentConsideredItemWidget extends StatelessWidget {
  final String text;
  final Color? backgroundColor;
  final Color? textColor;

  const DependentConsideredItemWidget({
    Key? key,
    required this.text,
    this.backgroundColor,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SeniorSpacing.xmedium,
      padding: const EdgeInsets.symmetric(
        horizontal: SeniorSpacing.small,
      ),
      decoration: BoxDecoration(
        color: _backgroundColor(
          context: context,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(
            SeniorSpacing.xxsmall,
          ),
        ),
      ),
      child: Center(
        child: SeniorText.small(
          text,
          color: textColor,
        ),
      ),
    );
  }

  Color _backgroundColor({required BuildContext context}) {
    if (backgroundColor != null) {
      return backgroundColor!;
    }
    return Provider.of<ThemeRepository>(context).isDarkTheme()
        ? Provider.of<ThemeRepository>(context).theme.colorfulHeaderStructureTheme!.style!.bodyColor!
        : SeniorColors.secondaryColor200;
  }
}
