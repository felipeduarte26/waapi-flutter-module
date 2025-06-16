import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../../core/constants/assets_path.dart';
import '../../../../../../../core/extension/translate_extension.dart';
import '../../../../../../../core/widgets/employee_bottom_sheet_widget.dart';
import '../../../../../../../routes/management_panel_routes.dart';

class HappinessIndexInformationWidget extends StatelessWidget {
  const HappinessIndexInformationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkColor = Provider.of<ThemeRepository>(context).isDarkTheme();
    return SingleChildScrollView(
      child: Column(
        children: [
          SvgPicture.asset(
            AssetsPath.happinesIndexFeelings,
            width: 200,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: SeniorSpacing.normal,
              ),
              SeniorText.label(
                context.translate.firstTextExplanationHappinessIndex,
              ),
              const SizedBox(
                height: SeniorSpacing.normal,
              ),
              RichText(
                text: TextSpan(
                  style: SeniorTypography.label(
                    color: isDarkColor ? SeniorColors.pureWhite : SeniorColors.grayscale70,
                  ),
                  text: context.translate.secodTextExplanationHappinessIndex,
                  children: [
                    TextSpan(
                      text: context.translate.anonymously,
                      style: SeniorTypography.labelBold(),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: SeniorSpacing.normal,
              ),
              SeniorText.label(
                context.translate.thirdTextExplanationHappinessIndex,
              ),
              EmployeeBottomSheetWidget(
                seniorButtons: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: SeniorSpacing.normal,
                    ),
                    child: SeniorButton.ghost(
                      label: context.translate.textButtonExplanationHappinessIndex,
                      onPressed: () {
                        Modular.to.pushNamed(
                          ManagementPanelRoutes.toDocumentationHappinessScreenRoute,
                        );
                      },
                      fullWidth: true,
                    ),
                  ),
                ],
                horizontalPadding: false,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
