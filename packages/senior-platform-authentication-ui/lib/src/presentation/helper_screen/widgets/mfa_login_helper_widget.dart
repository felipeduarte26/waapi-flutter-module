import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/l10n/l10n_extension.dart';
import '../../../core/utils/constants.dart';

class MfaLoginHelperWidget extends StatelessWidget {
  const MfaLoginHelperWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: SeniorSpacing.xmedium,
              bottom: SeniorSpacing.normal,
            ),
            child: SeniorText.cta(context.l10n.helpTextLoginMfaDescriptioTitle),
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
                    child: SeniorText.label(
                      context.l10n.helpTextLoginMfaDescriptio1,
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
                    child: SeniorText.label(
                      context.l10n.helpTextLoginMfaDescriptio2,
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
                    child: SeniorText.label(
                        context.l10n.helpTextLoginMfaDescriptio3),
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: SeniorSpacing.xmedium,
              bottom: SeniorSpacing.normal,
            ),
            child:
                SeniorText.cta(context.l10n.helpTextLoginMfaDescriptioTitle2),
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
                    text: context.l10n.helpTextLoginMfaDescriptio4,
                    style: SeniorTypography.label(),
                    children: <TextSpan>[
                      TextSpan(
                        text: context.l10n.helpTextDocumentationPortal,
                        style: const TextStyle(
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold,
                            color: SeniorColors.primaryColor600),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            Uri url = Uri.parse(
                              linkSeniorDocumentation,
                            );
                            if (await canLaunchUrl(url)) {
                              await launchUrl(
                                url,
                                mode: LaunchMode.externalNonBrowserApplication,
                              );
                            }
                          },
                      ),
                      // can add more TextSpans here...
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
