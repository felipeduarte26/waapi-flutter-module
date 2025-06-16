import 'package:flutter/material.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../infra/utils/extension/media_query_extension.dart';

class EmployeeBottomSheetWidget extends StatelessWidget {
  final List<Widget> seniorButtons;

  const EmployeeBottomSheetWidget({
    super.key,
    required this.seniorButtons,
  });

  @override
  Widget build(BuildContext context) {
    final bottomPadding = context.bottomSize;

    return AnimatedContainer(
      duration: kThemeAnimationDuration,
      padding: EdgeInsets.only(
        top: SeniorSpacing.normal,
        left: SeniorSpacing.normal,
        right: SeniorSpacing.normal,
        bottom: bottomPadding,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: seniorButtons,
      ),
    );
  }
}
