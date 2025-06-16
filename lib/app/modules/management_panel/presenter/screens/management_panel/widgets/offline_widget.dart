import 'package:flutter/material.dart';

import '../../../../../../core/constants/assets_path.dart';
import '../../../../../../core/extension/translate_extension.dart';
import '../../../../../../core/widgets/empty_state_widget.dart';

class OfflineWidget extends StatelessWidget {
  const OfflineWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: EmptyStateWidget(
        title: context.translate.errorNetwork,
        subTitle: context.translate.errorNetworkDescription,
        imagePath: AssetsPath.generalErrorState,
      ),
    );
  }
}
