import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../ponto_mobile_collector.dart';

class StatusExplanationWidget extends StatelessWidget {
  const StatusExplanationWidget({super.key});

  Widget _item({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 5,
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: SeniorColors.grayscale70,
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SeniorText.body(
                  title,
                  darkColor: SeniorColors.pureWhite,
                ),
                SeniorText.small(
                  description,
                  textProperties: const TextProperties(
                    softWrap: true,
                    overflow: TextOverflow.visible,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final collectorLocalizations = CollectorLocalizations.of(context);

    return Column(
      children: [
        _item(
          icon: DriversWorkStatusEnum.driving.icon,
          title: collectorLocalizations.drive,
          description: collectorLocalizations.drivingStatusDescription,
        ),
        _item(
          icon: DriversWorkStatusEnum.notStarted.icon,
          title: collectorLocalizations.mainTimeClocking,
          description: collectorLocalizations.mainTimeClockingDescription,
        ),
        _item(
          icon: DriversWorkStatusEnum.mandatoryBreak.icon,
          title: collectorLocalizations.mandatoryBreak,
          description: collectorLocalizations.mandatoryBreakStatusDescription,
        ),
        _item(
          icon: FontAwesomeIcons.solidMoon,
          title: collectorLocalizations.overnight,
          description: collectorLocalizations.overnightDescription,
        ),
        _item(
          icon: DriversWorkStatusEnum.foodTime.icon,
          title: collectorLocalizations.foodTimeOrBreaks,
          description: collectorLocalizations.foodTimeStatusDescription,
        ),
        _item(
          icon: DriversWorkStatusEnum.waiting.icon,
          title: collectorLocalizations.waitingTime,
          description: collectorLocalizations.waitingStatusDescription,
        ),
        _item(
          icon: DriversWorkStatusEnum.working.icon,
          title: collectorLocalizations.working,
          description: collectorLocalizations.workingStatusDescription,
        ),
      ],
    );
  }
}
