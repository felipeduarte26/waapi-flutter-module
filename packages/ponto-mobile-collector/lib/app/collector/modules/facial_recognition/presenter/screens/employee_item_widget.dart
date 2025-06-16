import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

class EmployeeItemWidget extends StatelessWidget {
  final int index;
  final String name;
  final String identifier;
  final bool selected;
  final VoidCallback? onTap;

  const EmployeeItemWidget({
    required this.index,
    required this.name,
    required this.identifier,
    this.selected = false,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeRepository>(context).isDarkTheme();

    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius:
              const BorderRadius.all(Radius.circular(SeniorSpacing.xxsmall)),
          color: selected
              ? (isDark ? SeniorColors.grayscale100 : SeniorColors.grayscale30)
              : Colors.transparent,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: SeniorSpacing.xxsmall + SeniorSpacing.xxxsmall,
            horizontal: SeniorSpacing.small,
          ),
          child:  Column(
            children: [
              Row(children: [Expanded(child: SeniorText.body(name),)]),
              Row(children: [Expanded(child:SeniorText.small(identifier),)]),
            ],
          ),
        ),
      ),
    );
  }
}
