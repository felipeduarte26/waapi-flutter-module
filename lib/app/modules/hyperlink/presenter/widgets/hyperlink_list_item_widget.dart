import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

class HyperlinkListItemWidget extends StatelessWidget {
  final Widget? prefixIcon;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
  final bool enabled;
  final double leftPadding;
  final double rightPadding;
  final int titleMaxLines;

  const HyperlinkListItemWidget({
    Key? key,
    this.prefixIcon,
    required this.title,
    this.onTap,
    this.subtitle,
    this.enabled = true,
    this.leftPadding = 0,
    this.rightPadding = 0,
    this.titleMaxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeRepository = Provider.of<ThemeRepository>(context);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: enabled ? onTap : null,
        child: Container(
          padding: EdgeInsets.only(
            top: SeniorSpacing.small,
            bottom: SeniorSpacing.small,
            left: leftPadding,
            right: rightPadding,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              prefixIcon != null
                  ? Padding(
                      padding: const EdgeInsets.only(
                        right: SeniorSpacing.small,
                      ),
                      child: prefixIcon,
                    )
                  : const SizedBox.shrink(),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: titleMaxLines,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: SeniorTypography.body(
                        color: themeRepository.isDarkTheme() ? SeniorColors.grayscale5 : SeniorColors.grayscale90,
                      ),
                    ),
                    subtitle == null
                        ? const SizedBox.shrink()
                        : Text(
                            subtitle!,
                            textAlign: TextAlign.left,
                            style: SeniorTypography.small(),
                          ),
                  ],
                ),
              ),
              Offstage(
                offstage: onTap == null,
                child: Align(
                  alignment: Alignment.center,
                  child: SeniorIcon(
                    icon: FontAwesomeIcons.angleRight,
                    style: SeniorIconStyle(
                      color: enabled ? themeRepository.theme.primaryColor : SeniorColors.neutralColor900,
                    ),
                    size: SeniorIconSize.medium,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
