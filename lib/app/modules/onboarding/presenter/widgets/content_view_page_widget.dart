import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../core/extension/media_query_extension.dart';
import '../../../../core/extension/translate_extension.dart';

class ContentViewPageWidget extends StatelessWidget {
  final VoidCallback? onJump;
  final bool showJump;
  final String imagePath;
  final Widget textContent;
  final bool? isPng;

  const ContentViewPageWidget({
    Key? key,
    this.onJump,
    required this.imagePath,
    required this.textContent,
    this.showJump = true,
    this.isPng = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeRepository = Provider.of<ThemeRepository>(context);
    final heightSize = context.heightSize * 0.30;

    return Scaffold(
      backgroundColor: Provider.of<ThemeRepository>(context).theme.colorfulHeaderStructureTheme!.style!.bodyColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: SeniorSpacing.normal,
              ),
              child: TextButton(
                onPressed: showJump ? onJump : null,
                child: showJump
                    ? SeniorText.label(
                        context.translate.jump,
                        color: themeRepository.isCustomTheme()
                            ? SeniorServiceColor.getContrastAdjustedColorTheme(
                                color: themeRepository.theme.primaryColor!,
                              )
                            : SeniorColors.primaryColor600,
                        darkColor: themeRepository.theme.textTheme!.labelStyle!.color,
                      )
                    : const SizedBox.shrink(),
              ),
            ),
            SizedBox(
              height: heightSize,
              child: Padding(
                padding: const EdgeInsets.only(
                  right: SeniorSpacing.normal,
                  left: SeniorSpacing.normal,
                  bottom: SeniorSpacing.normal,
                ),
                child: Center(
                  child: isPng! ? Image.asset(imagePath) : SvgPicture.asset(imagePath),
                ),
              ),
            ),
            const Divider(
              color: SeniorColors.primaryColor200,
            ),
            Padding(
              padding: const EdgeInsets.all(
                SeniorSpacing.normal,
              ),
              child: textContent,
            ),
          ],
        ),
      ),
    );
  }
}
