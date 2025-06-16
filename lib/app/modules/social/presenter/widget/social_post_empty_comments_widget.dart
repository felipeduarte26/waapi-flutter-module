import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../core/constants/assets_path.dart';
import '../../../../core/extension/translate_extension.dart';

class SocialPostEmptyCommentsWidget extends StatelessWidget {
  const SocialPostEmptyCommentsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          AssetsPath.speechBalloons,
          height: 160,
        ),
        const SizedBox(
          height: SeniorSpacing.small,
        ),
        SeniorText.h4(
          context.translate.socialNoComments,
          textProperties: const TextProperties(
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: SeniorSpacing.xsmall,
          ),
          child: SeniorText.label(
            context.translate.socialNoCommentsSuggestion,
            color: SeniorColors.neutralColor500,
            textProperties: const TextProperties(
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
