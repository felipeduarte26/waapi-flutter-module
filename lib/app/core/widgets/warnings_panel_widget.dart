import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../extension/translate_extension.dart';

class WarningsPanelWidget extends StatelessWidget {
  final bool isRequiredAttachments;

  const WarningsPanelWidget({
    Key? key,
    this.isRequiredAttachments = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: SeniorSpacing.normal,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              bottom: SeniorSpacing.normal,
            ),
            child: Row(
              children: [
                const SeniorIcon(
                  icon: FontAwesomeIcons.solidCircleCheck,
                  size: SeniorSpacing.medium,
                ),
                const SizedBox(
                  width: SeniorSpacing.small,
                ),
                Expanded(
                  child: SeniorText.body(
                    isRequiredAttachments ? context.translate.receiptTips : context.translate.receiptTipsOptional,
                    color: SeniorColors.neutralColor600,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: SeniorSpacing.normal,
            ),
            child: Row(
              children: [
                const SeniorIcon(
                  icon: FontAwesomeIcons.solidFileLines,
                  size: SeniorSpacing.medium,
                ),
                const SizedBox(
                  width: SeniorSpacing.small,
                ),
                Expanded(
                  child: SeniorText.body(
                    context.translate.receiptTipsImage,
                    color: SeniorColors.neutralColor600,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: SeniorSpacing.normal,
            ),
            child: Row(
              children: [
                const SeniorIcon(
                  icon: FontAwesomeIcons.solidCamera,
                  size: SeniorSpacing.medium,
                ),
                const SizedBox(
                  width: SeniorSpacing.small,
                ),
                Expanded(
                  child: SeniorText.body(
                    context.translate.receiptTipsLegible,
                    color: SeniorColors.neutralColor600,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: SeniorSpacing.normal,
            ),
            child: Row(
              children: [
                const Icon(
                  FontAwesomeIcons.fileCircleExclamation,
                  color: SeniorColors.primaryColor500,
                  size: SeniorSpacing.medium,
                ),
                const SizedBox(
                  width: SeniorSpacing.small,
                ),
                Expanded(
                  child: SeniorText.body(
                    context.translate.theFollowingFileFormatAllowed('pdf, png, jpeg, jpg, doc, docx e xlsx'),
                    color: SeniorColors.neutralColor600,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: SeniorSpacing.normal,
            ),
            child: Row(
              children: [
                const Icon(
                  FontAwesomeIcons.fileArrowUp,
                  color: SeniorColors.primaryColor500,
                  size: SeniorSpacing.medium,
                ),
                const SizedBox(
                  width: SeniorSpacing.small,
                ),
                Expanded(
                  child: SeniorText.body(
                    context.translate.theFileSizeMustMaximumOf('2'),
                    color: SeniorColors.neutralColor600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
