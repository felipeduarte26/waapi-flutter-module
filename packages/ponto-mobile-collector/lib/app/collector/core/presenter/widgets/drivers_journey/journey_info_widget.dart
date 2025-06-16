import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

class JourneyInfoWidget extends StatelessWidget {
  final String title;
  final void Function()? onInfoButtonPressed;
  final String? prefixContent;
  final String content;
  final Color? contentLightColor;
  final Color? contentDarkColor;

  const JourneyInfoWidget({
    super.key,
    required this.title,
    this.onInfoButtonPressed,
    this.prefixContent,
    required this.content,
    this.contentLightColor,
    this.contentDarkColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeRepository>(context).isDarkTheme();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SeniorText.small(
              title,
              darkColor: SeniorColors.grayscale40,
            ),
            if (onInfoButtonPressed != null)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: GestureDetector(
                  onTap: onInfoButtonPressed,
                  child: Icon(
                    FontAwesomeIcons.circleInfo,
                    color: isDark
                        ? SeniorColors.grayscale50
                        : SeniorColors.pureBlack,
                    size: SeniorIconSize.xsmall,
                  ),
                ),
              ),
          ],
        ),
        if (prefixContent != null)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: SeniorText.smallBold(
                prefixContent!,
                darkColor: SeniorColors.grayscale50,
                textProperties: const TextProperties(
                  textAlign: TextAlign.end,
                ),
              ),
            ),
          ),
        Expanded(
          flex: prefixContent != null ? 0 : 1,
          child: SeniorText.smallBold(
            content,
            color: contentLightColor,
            darkColor: contentDarkColor ?? SeniorColors.grayscale10,
            textProperties: const TextProperties(
              textAlign: TextAlign.end,
            ),
          ),
        ),
      ],
    );
  }
}
