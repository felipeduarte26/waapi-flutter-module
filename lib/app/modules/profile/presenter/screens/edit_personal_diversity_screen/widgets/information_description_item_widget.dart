import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

class InformationDescriptionItem extends StatelessWidget {
  final String title;
  final String description;

  const InformationDescriptionItem({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    bool isDarkColor = Provider.of<ThemeRepository>(context).isDarkTheme();

    return Padding(
      padding: const EdgeInsets.only(bottom: SeniorSpacing.small),
      child: Row(
        children: [
          Expanded(
            child: RichText(
              text: TextSpan(
                style: SeniorTypography.labelBold(
                  color: isDarkColor ? SeniorColors.grayscale5 : SeniorColors.grayscale90,
                ),
                text: title,
                children: [
                  TextSpan(
                    text: description,
                    style: SeniorTypography.label(
                      color: isDarkColor ? SeniorColors.grayscale5 : SeniorColors.grayscale90,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
