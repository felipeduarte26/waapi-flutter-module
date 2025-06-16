import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

class WaapiColorfulHeader extends StatelessWidget {
  final List<Widget>? actions;
  final Widget body;
  final NotificationMessage? notification;
  final bool hasTopPadding;
  final bool hideLeading;
  final Widget? leading;
  final SeniorColorfulHeaderStructureStyle? style;
  final Widget? title;
  final String? titleLabel;
  final TabBarConfig? tabBarConfig;
  final ScrollController? scrollController;
  final Function()? onTapBack;

  const WaapiColorfulHeader({
    super.key,
    this.actions,
    required this.body,
    this.notification,
    this.hasTopPadding = false,
    this.hideLeading = false,
    this.leading,
    this.onTapBack,
    this.style,
    this.title,
    this.titleLabel,
    this.tabBarConfig,
    this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    final themeRepository = Provider.of<ThemeRepository>(context);
    return SeniorColorfulHeaderStructure(
      key: key,
      body: body,
      title: title ??
          (titleLabel != null
              ? SeniorText.label(
                  color: themeRepository.isCustomTheme()
                      ? SeniorServiceColor.getOptimalContrastColorTheme(color: themeRepository.theme.secondaryColor!)
                      : SeniorColors.pureWhite,
                  darkColor: themeRepository.isCustomTheme()
                      ? SeniorServiceColor.getOptimalContrastColorTheme(color: themeRepository.theme.secondaryColor!)
                      : SeniorColors.grayscale5,
                  titleLabel!,
                )
              : const SizedBox.shrink()),
      leading: hideLeading
          ? const SizedBox.shrink()
          : IconButton(
              icon: leading ??
                  SeniorIcon(
                    icon: FontAwesomeIcons.angleLeft,
                    size: SeniorSpacing.medium,
                    style: SeniorIconStyle(
                      color: themeRepository.isCustomTheme()
                          ? SeniorServiceColor.getOptimalContrastColorTheme(
                              color: themeRepository.theme.secondaryColor!,
                            )
                          : SeniorColors.pureWhite,
                    ),
                  ),
              onPressed: onTapBack ?? () => Navigator.pop(context),
            ),
      actions: actions,
      hasTopPadding: hasTopPadding,
      hideLeading: hideLeading,
      notification: notification,
      scrollController: scrollController,
      style: style,
      tabBarConfig: tabBarConfig,
    );
  }
}
