import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../core/constants/assets_path.dart';
import '../../../../../../core/extension/translate_extension.dart';
import '../../../../../../core/helper/string_helper.dart';
import '../../../../../../core/widgets/document_item_widget.dart';

class FixRequestVacationUpdateScreen extends StatelessWidget {
  final String approverCommentary;
  final String integrationErrorMessage;
  final String employeeId;

  const FixRequestVacationUpdateScreen({
    Key? key,
    required this.employeeId,
    required this.approverCommentary,
    required this.integrationErrorMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final approverCommentaryScreen =
        approverCommentary != '' ? '${StringHelper.bulletPoint()} $approverCommentary' : '';
    final integrationErrorMessageScreen =
        integrationErrorMessage != '' ? '${StringHelper.bulletPoint()} $integrationErrorMessage' : '';
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: SeniorSpacing.normal,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            AssetsPath.vacationEmptyState,
            height: 229,
          ),
          const SizedBox(
            height: SeniorSpacing.xmedium,
          ),
          Padding(
            padding: EdgeInsets.zero,
            child: SeniorText.h4(
              context.translate.couldNotInsertTheIndividualProgrammedVacation,
              color: SeniorColors.pureBlack,
              textProperties: const TextProperties(
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(
            height: SeniorSpacing.xmedium,
          ),
          DocumentItemWidget(
            padding: const EdgeInsets.symmetric(
              horizontal: SeniorSpacing.xsmall,
            ),
            items: [approverCommentaryScreen, integrationErrorMessageScreen],
          ),
        ],
      ),
    );
  }
}
