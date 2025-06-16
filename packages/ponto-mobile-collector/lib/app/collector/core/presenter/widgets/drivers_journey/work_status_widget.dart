import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../ponto_mobile_collector.dart';

class WorkStatusWidget extends StatelessWidget {
  final DriversWorkStatusEnum driversWorkStatus;
  final DriversWorkStatusIndicatorEnum _driversWorkStatusIndicator;

  WorkStatusWidget({
    super.key,
    required this.driversWorkStatus,
  }) : _driversWorkStatusIndicator = DriversWorkStatusIndicatorEnum.values
            .byName(driversWorkStatus.name);

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeRepository>(context).isDarkTheme();
    final collectorLocalizations = CollectorLocalizations.of(context);
    final (
      icon,
      status,
    ) = (
      driversWorkStatus.icon,
      _driversWorkStatusIndicator.status(context),
    );

    return Row(
      children: [
        Icon(
          icon,
          size: SeniorIconSize.big,
          color:
              isDark ? SeniorColors.primaryColor400 : SeniorColors.primaryColor,
        ),
        const SizedBox(
          width: 15,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SeniorText.small(
              collectorLocalizations.workStatus,
              darkColor: SeniorColors.grayscale40,
            ),
            SeniorText.labelBold(
              status,
              darkColor: SeniorColors.grayscale40,
            ),
          ],
        ),
      ],
    );
  }
}
