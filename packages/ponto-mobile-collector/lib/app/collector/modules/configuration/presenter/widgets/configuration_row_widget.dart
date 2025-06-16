// ignore_for_file: use_named_constants

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/tokens/senior_colors.dart';
import 'package:senior_design_tokens/tokens/senior_spacing.dart';

class ConfigurationRowWidget extends StatelessWidget {
  final String title;
  final String? description;
  final Icon icon;
  final VoidCallback onTap;
  final RotationTransition? rotationTransition;
  final bool showRightIcon;

  const ConfigurationRowWidget({
    super.key,
    required this.title,
    this.description,
    required this.icon,
    required this.onTap,
    this.rotationTransition,
    this.showRightIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeRepository>(context).isDarkTheme();

    return Padding(
      padding: const EdgeInsets.only(
        top: SeniorSpacing.small,
        bottom: SeniorSpacing.small,
      ),
      child: InkWell(
        onTap: onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            rotationTransition ?? icon,
            const SizedBox(width: SeniorSpacing.small),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SeniorText.body(
                    title,
                    color: SeniorColors.neutralColor800,
                    darkColor: SeniorColors.pureWhite,
                  ),
                  getDescription(),
                ],
              ),
            ),
            const SizedBox(width: SeniorSpacing.xsmall),
            if (showRightIcon) ...[
              Icon(
                FontAwesomeIcons.angleRight,
                size: SeniorSpacing.normal,
                color: isDark
                    ? SeniorColors.pureWhite
                    : SeniorColors.neutralColor800,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget getDescription() {
    if (description != null) {
      return SeniorText.small(
        description!,
        color: SeniorColors.neutralColor800,
        textProperties: const TextProperties(
          softWrap: true,
        ),
      );
    } else {
      return const SizedBox();
    }
  }
}
