import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../core/extension/translate_extension.dart';
import '../../../../../../core/widgets/waapi_text_with_bold_widget.dart';

class SocialNameDescription extends StatelessWidget {
  const SocialNameDescription({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkColor = Provider.of<ThemeRepository>(context).isDarkTheme();
    return Column(
      children: [
        WaapiTextWithBold(
          text: context.translate.socialNameRight,
          typography: SeniorTypography.label(
            color: isDarkColor ? SeniorColors.grayscale5 : SeniorColors.grayscale90,
          ),
          typographyBold: SeniorTypography.labelBold(
            color: isDarkColor ? SeniorColors.grayscale5 : SeniorColors.grayscale90,
          ),
        ),
        const SizedBox(
          height: SeniorSpacing.small,
        ),
        SeniorText.label(context.translate.socialNameDocuments),
      ],
    );
  }
}
