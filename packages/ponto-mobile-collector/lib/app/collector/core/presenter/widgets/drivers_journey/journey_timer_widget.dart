import 'package:flutter/material.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../ponto_mobile_collector.dart';

class JourneyTimerWidget extends StatelessWidget {
  final DriversWorkStatusTimerIndicatorEnum _driversWorkStatusTimerIndicator;
  final Duration _timer;

  JourneyTimerWidget({
    super.key,
    required DriversWorkStatusEnum driversWorkStatus,
    required Duration timer,
  })  : _driversWorkStatusTimerIndicator = DriversWorkStatusTimerIndicatorEnum
            .values
            .byName(driversWorkStatus.name),
        _timer = timer;

  @override
  Widget build(BuildContext context) {
    final collectorLocalizations = CollectorLocalizations.of(context);
    final label = _driversWorkStatusTimerIndicator.label(context);
    final seconds = _timer.inSeconds;
    final (
      hour,
      minute,
      second,
    ) = (
      (seconds ~/ 3600).toString().padLeft(2, '0'),
      ((seconds % 3600) ~/ 60).toString().padLeft(2, '0'),
      (seconds % 60).toString().padLeft(2, '0'),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(),
        SeniorText.label(
          label,
          darkColor: SeniorColors.grayscale40,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SeniorText.h2(
                  '$hour:',
                  darkColor: SeniorColors.pureWhite,
                ),
                SeniorText.small(
                  collectorLocalizations.hours,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SeniorText.h2(
                  '$minute:',
                  darkColor: SeniorColors.pureWhite,
                ),
                SeniorText.small(
                  collectorLocalizations.minutes,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SeniorText.h2(
                  second,
                  darkColor: SeniorColors.pureWhite,
                ),
                SeniorText.small(
                  collectorLocalizations.seconds,
                ),
              ],
            ),
          ],
        ),
        const Divider(),
      ],
    );
  }
}
