import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

class IconHeaderWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool removeBottomPadding;
  final bool removeHorizontalPadding;
  final bool? enableInfoButton;
  final VoidCallback? onInfoButtonPressed;

  const IconHeaderWidget({
    Key? key,
    required this.title,
    required this.icon,
    this.removeBottomPadding = false,
    this.removeHorizontalPadding = false,
    this.enableInfoButton = false,
    this.onInfoButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkColor = Provider.of<ThemeRepository>(context).isDarkTheme();
    return Container(
      padding: EdgeInsets.only(
        right: removeHorizontalPadding ? 0 : SeniorSpacing.normal,
        left: removeHorizontalPadding ? 0 : SeniorSpacing.normal,
        bottom: removeBottomPadding ? 0 : SeniorSpacing.normal,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SeniorIcon(
            icon: icon,
            style: SeniorIconStyle(
              color: isDarkColor ? SeniorColors.grayscale5 : SeniorColors.grayscale60,
            ),
            size: SeniorIconSize.small,
          ),
          const SizedBox(
            width: SeniorSpacing.xsmall,
          ),
          Expanded(
            child: SeniorText.cta(
              title,
              color: Provider.of<ThemeRepository>(context).theme.textTheme!.ctaStyle!.color,
              textProperties: const TextProperties(
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
              ),
            ),
          ),
          enableInfoButton!
              ? IconButton(
                  iconSize: SeniorSpacing.normal,
                  onPressed: onInfoButtonPressed,
                  icon: SeniorIcon(
                    icon: FontAwesomeIcons.solidCircleInfo,
                    size: SeniorSpacing.normal,
                    style: SeniorIconStyle(
                      color: isDarkColor ? SeniorColors.grayscale5 : SeniorColors.neutralColor900,
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
