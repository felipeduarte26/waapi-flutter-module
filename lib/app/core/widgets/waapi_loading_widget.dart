import 'package:flutter/material.dart';
import 'package:senior_design_system/components/senior_loading/senior_loading_widget.dart';
import 'package:senior_design_tokens/tokens/senior_spacing.dart';

import '../enums/analytics/waapi_loading_size_enum.dart';

class WaapiLoadingWidget extends StatelessWidget {
  final WaapiLoadingSizeEnum waapiLoadingSizeEnum;

  const WaapiLoadingWidget({
    Key? key,
    this.waapiLoadingSizeEnum = WaapiLoadingSizeEnum.big,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: waapiLoadingSizeEnum == WaapiLoadingSizeEnum.big ? SeniorSpacing.xbig : SeniorSpacing.big,
        width: waapiLoadingSizeEnum == WaapiLoadingSizeEnum.big ? SeniorSpacing.xbig : SeniorSpacing.big,
        child: const SeniorLoading(),
      ),
    );
  }
}
