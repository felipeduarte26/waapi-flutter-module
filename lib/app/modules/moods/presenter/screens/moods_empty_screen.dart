import 'package:flutter/material.dart';

import '../../../../core/constants/assets_path.dart';
import '../../../../core/extension/translate_extension.dart';
import '../../../../core/widgets/empty_state_widget.dart';
import '../../../../core/widgets/waapi_colorful_header.dart';

class MoodsEmptyScreen extends StatelessWidget {
  const MoodsEmptyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WaapiColorfulHeader(
        hasTopPadding: false,
        titleLabel: context.translate.moodsTitle,
        body: EmptyStateWidget(
          title: context.translate.moodsEmptyStateTitle,
          subTitle: context.translate.moodsEmptyStateSubTitle,
          imagePath: AssetsPath.moodsAnsweredState,
        ),
      ),
    );
  }
}
