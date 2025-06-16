import 'package:flutter/material.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../extension/media_query_extension.dart';

class EmployeeBottomSheetWidget extends StatelessWidget {
  final List<Widget> seniorButtons;
  final bool horizontalPadding;
  final AlignmentGeometry? alignmentGeometry;

  const EmployeeBottomSheetWidget({
    Key? key,
    required this.seniorButtons,
    required this.horizontalPadding,
    this.alignmentGeometry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bottomPadding = context.bottomSize;

    return AnimatedContainer(
      duration: kThemeAnimationDuration,
      color: Colors.transparent,
      padding: EdgeInsets.only(
        top: SeniorSpacing.normal,
        left: horizontalPadding ? SeniorSpacing.normal : 0,
        right: horizontalPadding ? SeniorSpacing.normal : 0,
        bottom: bottomPadding,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: seniorButtons,
      ),
    );
  }
}
