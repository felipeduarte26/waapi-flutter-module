import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../core/extension/translate_extension.dart';

class NotAllowToViewMyFeedbacksWidget extends StatelessWidget {
  const NotAllowToViewMyFeedbacksWidget({
    Key? key,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(
          SeniorSpacing.xsmall,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SeniorGradientIcon(
              icon: FontAwesomeIcons.faceFrown,
              sizeIcon: 66,
            ),
            const SizedBox(
              height: SeniorSpacing.medium,
            ),
            SeniorText.h4(
              context.translate.titleNotAllowToViewMyFeedbacks,
              color: SeniorColors.neutralColor800,
              textProperties: const TextProperties(
                maxLines: 3,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
