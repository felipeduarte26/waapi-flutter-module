import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../constants/assets_path.dart';
import '../extension/media_query_extension.dart';
import '../extension/translate_extension.dart';

class InformationWidget extends StatefulWidget {
  final String? title;
  final IconData? icon;
  final Widget? description;
  final VoidCallback? onTapThumbsUp;
  final VoidCallback? onTapThumbsDown;
  final bool isThank;

  const InformationWidget({
    super.key,
    this.title,
    this.icon,
    this.description,
    this.onTapThumbsUp,
    this.isThank = false,
    this.onTapThumbsDown,
  });

  @override
  State<InformationWidget> createState() => _InformationWidgetState();
}

class _InformationWidgetState extends State<InformationWidget> {
  @override
  Widget build(BuildContext context) {
    final themeRepository = Provider.of<ThemeRepository>(context, listen: false);
    final bottomPadding = context.bottomSize;
    return widget.isThank
        ? Column(
            children: [
              SvgPicture.asset(
                AssetsPath.generalThankState,
                height: 180,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: SeniorSpacing.normal,
                  bottom: SeniorSpacing.big,
                ),
                child: SeniorText.h4(
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                  context.translate.messageThankYouInput,
                ),
              ),
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  bottom: SeniorSpacing.normal,
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        right: SeniorSpacing.small,
                      ),
                      child: SeniorGradientIcon(
                        icon: widget.icon!,
                        sizeIcon: SeniorSpacing.medium,
                        boxSize: SeniorSpacing.medium,
                      ),
                    ),
                    Flexible(
                      child: SeniorText.cta(
                        widget.title!,
                      ),
                    ),
                  ],
                ),
              ),
              widget.description ?? const SizedBox.shrink(),
              const Padding(
                padding: EdgeInsets.symmetric(
                  vertical: SeniorSpacing.normal,
                ),
                child: Divider(
                  color: SeniorColors.neutralColor200,
                  thickness: 2,
                ),
              ),
              SeniorText.labelBold(
                context.translate.messageInformationHelpful,
                textProperties: const TextProperties(
                  textAlign: TextAlign.left,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: SeniorSpacing.normal + bottomPadding,
                  top: SeniorSpacing.xsmall,
                ),
                child: Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                            color: Provider.of<ThemeRepository>(context, listen: false).isDarkTheme()
                                ? SeniorColors.grayscale60
                                : SeniorColors.secondaryColor200,
                          ),
                        ),
                        height: SeniorSpacing.xxbig,
                        width: SeniorSpacing.xxbig,
                        child: SeniorIconButton(
                          style: SeniorIconButtonStyle(
                            buttonColor: Colors.transparent,
                            iconColor: themeRepository.isCustomTheme()
                                ? SeniorServiceColor.getContrastAdjustedColorTheme(
                                    color: themeRepository.theme.primaryColor!,
                                  )
                                : themeRepository.isDarkTheme()
                                    ? SeniorColors.primaryColor500
                                    : SeniorColors.primaryColor600,
                          ),
                          size: SeniorIconButtonSize.small,
                          type: SeniorIconButtonType.primary,
                          onTap: widget.onTapThumbsDown!,
                          icon: FontAwesomeIcons.solidThumbsDown,
                        ),
                      ),
                      const SizedBox(
                        width: SeniorSpacing.normal,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                            color: Provider.of<ThemeRepository>(context, listen: false).isDarkTheme()
                                ? SeniorColors.grayscale60
                                : SeniorColors.secondaryColor200,
                          ),
                        ),
                        height: SeniorSpacing.xxbig,
                        width: SeniorSpacing.xxbig,
                        child: SeniorIconButton(
                          style: SeniorIconButtonStyle(
                            buttonColor: Colors.transparent,
                            iconColor: themeRepository.isCustomTheme()
                                ? SeniorServiceColor.getContrastAdjustedColorTheme(
                                    color: themeRepository.theme.primaryColor!,
                                  )
                                : themeRepository.isDarkTheme()
                                    ? SeniorColors.primaryColor500
                                    : SeniorColors.primaryColor600,
                          ),
                          size: SeniorIconButtonSize.small,
                          type: SeniorIconButtonType.primary,
                          onTap: widget.onTapThumbsUp!,
                          icon: FontAwesomeIcons.solidThumbsUp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
  }
}
