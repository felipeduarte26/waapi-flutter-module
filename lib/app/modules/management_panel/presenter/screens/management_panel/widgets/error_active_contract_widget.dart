import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../core/constants/assets_path.dart';
import '../../../../../../core/extension/translate_extension.dart';
import '../../../../../../core/widgets/empty_state_widget.dart';

class ErrorActiveContractWidget extends StatelessWidget {
  final Function() onTryAgain;
  final Function() onSignOut;

  const ErrorActiveContractWidget({
    Key? key,
    required this.onTryAgain,
    required this.onSignOut,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Provider.of<ThemeRepository>(context, listen: false).isDarkTheme()
          ? Provider.of<ThemeRepository>(context, listen: false).theme.colorfulHeaderStructureTheme!.style!.bodyColor
          : SeniorColors.neutralColor100,
      body: EmptyStateWidget(
        title: context.translate.errorGetContractEmployee,
        imagePath: AssetsPath.generalErrorState,
        subTitle: context.translate.errorGetContractEmployeeDescription,
        actions: [
          SeniorButton(
            label: context.translate.tryAgain,
            fullWidth: true,
            onPressed: onTryAgain,
          ),
          const SizedBox(
            height: SeniorSpacing.xsmall,
          ),
          SeniorButton.ghost(
            label: context.translate.optionExitDialogExit,
            fullWidth: true,
            onPressed: onSignOut,
          ),
        ],
      ),
    );
  }
}
