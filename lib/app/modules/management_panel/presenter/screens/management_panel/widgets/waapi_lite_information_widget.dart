import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../core/constants/assets_path.dart';
import '../../../../../../core/extension/translate_extension.dart';
import '../../../../../../core/widgets/employee_bottom_sheet_widget.dart';
import '../../../../../../routes/management_panel_routes.dart';

class WaapiLiteInformationWidget extends StatelessWidget {
  const WaapiLiteInformationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SvgPicture.asset(
            AssetsPath.generalWaapiState,
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
                context.translate.waapiLiteCheckOutDescription,
              ),
              const SizedBox(
                height: SeniorSpacing.normal,
              ),
              EmployeeBottomSheetWidget(
                seniorButtons: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: SeniorSpacing.normal,
                    ),
                    child: SeniorButton.ghost(
                      label: context.translate.textButtonExplanationHappinessIndex,
                      onPressed: () async {
                        Modular.to.pushNamed(
                          ManagementPanelRoutes.toDocumentationWaapiLiteScreenRoute,
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
