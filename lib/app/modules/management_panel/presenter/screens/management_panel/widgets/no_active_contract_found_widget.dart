import 'package:flutter/material.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../core/constants/assets_path.dart';
import '../../../../../../core/extension/translate_extension.dart';
import '../../../../../../core/widgets/empty_state_widget.dart';

class NoActiveContractFoundWidget extends StatelessWidget {
  final Function() onSignOut;

  const NoActiveContractFoundWidget({
    Key? key,
    required this.onSignOut,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: SeniorSpacing.normal,
      ),
      child: EmptyStateWidget(
        title: context.translate.noFunctionalitiesYourUser,
        subTitle: context.translate.youHaveAccessToTheSeniorPlatform,
        imagePath: AssetsPath.generalEmptyState,
        imageHeight: 120,
        actions: [
          SeniorButton(
            label: context.translate.descriptionTileExitSettings,
            fullWidth: true,
            onPressed: onSignOut,
          ),
        ],
      ),
    );
  }
}
