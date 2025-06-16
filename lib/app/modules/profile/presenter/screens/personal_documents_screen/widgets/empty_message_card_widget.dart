import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/tokens/senior_colors.dart';
import 'package:senior_design_tokens/tokens/senior_spacing.dart';

class EmptyMessageCardWidget extends StatelessWidget {
  final String text;

  const EmptyMessageCardWidget({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isCustomTheme = Provider.of<ThemeRepository>(context).isCustomTheme();
    return Column(
      children: [
        SeniorCard(
          withElevation: isCustomTheme,
          style: isCustomTheme
              ? const SeniorCardStyle(
                  outlinedColor: SeniorColors.grayscale50,
                  backgroundColor: SeniorColors.pureWhite,
                )
              : null,
          child: Row(
            children: [
              const SeniorIcon(
                icon: FontAwesomeIcons.solidFileLines,
                size: SeniorSpacing.big,
              ),
              const SizedBox(
                width: SeniorSpacing.medium,
              ),
              Expanded(
                child: SeniorText.body(
                  text,
                  color: SeniorColors.pureBlack,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
