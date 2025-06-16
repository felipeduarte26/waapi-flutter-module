import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/l10n/l10n_extension.dart';
import '../../../core/utils/constants.dart';

class LoginHelperWidget extends StatelessWidget {
  const LoginHelperWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: SeniorSpacing.xmedium,
              bottom: SeniorSpacing.normal,
            ),
            child: SeniorText.cta(
              context.l10n.helpTextLoginAuthenticationTitle,
            ),
          ),
          Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SeniorText.label(
                    bulletPoint,
                  ),
                  const SizedBox(
                    width: SeniorSpacing.xsmall,
                  ),
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        text: context
                            .l10n.helpTextLoginAuthenticationDescriptio11,
                        style: SeniorTypography.label(),
                        children: <TextSpan>[
                          TextSpan(
                            text: context
                                .l10n.helpTextLoginAuthenticationDescriptio12,
                            style: SeniorTypography.labelBold(),
                          ),
                          TextSpan(
                            text: context
                                .l10n.helpTextLoginAuthenticationDescriptio13,
                          ),
                          // can add more TextSpans here...
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SeniorText.label(
                    bulletPoint,
                  ),
                  const SizedBox(
                    width: SeniorSpacing.xsmall,
                  ),
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        text:
                            context.l10n.helpTextLoginAuthenticationDescriptio2,
                        style: SeniorTypography.label(),
                        children: <TextSpan>[
                          TextSpan(
                            text: context
                                .l10n.helpTextLoginAuthenticationDescriptio21,
                            style: SeniorTypography.labelBold(),
                          ),
                          // can add more TextSpans here...
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SeniorText.label(
                    bulletPoint,
                  ),
                  const SizedBox(
                    width: SeniorSpacing.xsmall,
                  ),
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        text:
                            context.l10n.helpTextLoginAuthenticationDescriptio3,
                        style: SeniorTypography.label(),
                        children: <TextSpan>[
                          TextSpan(
                            text: context.l10n.helpTextDocumentationPortal,
                            style: const TextStyle(
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.w700,
                              color: SeniorColors.primaryColor600,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                Uri url = Uri.parse(
                                  linkSeniorDocumentation,
                                );
                                if (await canLaunchUrl(url)) {
                                  await launchUrl(url);
                                }
                              },
                          ),
                          // can add more TextSpans here...
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
