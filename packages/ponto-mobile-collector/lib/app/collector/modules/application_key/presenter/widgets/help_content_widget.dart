import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/infra/utils/constants/constants_path.dart';

class HelpContentWidget extends StatelessWidget {
  final String applicationKeyHelpTitle;
  final String applicationKeyHelpContent1;
  final String applicationKeyHelpContent2;
  final String applicationKeyHelpContent3;
  final String helpTextDocumentationPortal;

  const HelpContentWidget({
    required this.applicationKeyHelpTitle,
    required this.applicationKeyHelpContent1,
    required this.applicationKeyHelpContent2,
    required this.applicationKeyHelpContent3,
    required this.helpTextDocumentationPortal,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(
        SeniorSpacing.normal,
      ),
      child: Column(
        children: [
          SeniorText.labelBold(
            applicationKeyHelpTitle,
          ),
          const SizedBox(
            height: SeniorSpacing.small,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SeniorText.label(
                ConstantsPath.pontoBulletPoint,
              ),
              const SizedBox(
                width: SeniorSpacing.xsmall,
              ),
              Expanded(
                child: Text.rich(
                  TextSpan(
                    text: '$applicationKeyHelpContent1 ',
                    style: SeniorTypography.label(),
                    children: <TextSpan>[
                      TextSpan(
                        text: helpTextDocumentationPortal,
                        style: const TextStyle(
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w700,
                          color: SeniorColors.primaryColor600,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            Uri url = Uri.parse(
                              ConstantsPath
                                  .pontoLinkSeniorDocumentationRegisterKey,
                            );
                            await launchUrl(url);
                          },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: SeniorSpacing.small,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SeniorText.label(
                ConstantsPath.pontoBulletPoint,
              ),
              const SizedBox(
                width: SeniorSpacing.xsmall,
              ),
              Expanded(
                child: Text.rich(
                  TextSpan(
                    text: applicationKeyHelpContent2,
                    style: SeniorTypography.label(),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: SeniorSpacing.small,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SeniorText.label(
                ConstantsPath.pontoBulletPoint,
              ),
              const SizedBox(
                width: SeniorSpacing.xsmall,
              ),
              Expanded(
                child: Text.rich(
                  TextSpan(
                    text: applicationKeyHelpContent3,
                    style: SeniorTypography.label(),
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          SeniorButton.primary(
            label: helpTextDocumentationPortal,
            fullWidth: true,
            onPressed: () async {
              Uri url = Uri.parse(
                ConstantsPath.pontoLinkSeniorDocumentation,
              );
              await launchUrl(url);
            },
          ),
        ],
      ),
    );
  }
}
