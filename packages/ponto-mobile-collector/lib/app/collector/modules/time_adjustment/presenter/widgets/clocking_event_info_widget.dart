import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../generated/l10n/collector_localizations.dart';
import '../../../../core/presenter/widgets/drivers_journey/status_explanation_widget.dart';
import 'clocking_event_info_item_widget.dart';

class ClockingEventInfoWidget extends StatelessWidget {
  final bool showSynced;
  final bool showMobile;
  final bool showPlatform;
  final bool showManual;
  final bool showOdd;
  final bool showRemoteness;
  final bool driver;

  const ClockingEventInfoWidget({
    this.showSynced = false,
    this.showMobile = false,
    this.showPlatform = false,
    this.showManual = false,
    this.showOdd = false,
    this.showRemoteness = false,
    this.driver = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    SizedBox sizedBox = const SizedBox();
    SizedBox sizedBoxSmall = const SizedBox(
      height: SeniorSpacing.xsmall,
    );
    return Column(
      children: [
        SizedBox(
          child: SingleChildScrollView(
            child: Column(
              children: [
                driver ? const StatusExplanationWidget() : sizedBox,
                showSynced
                    ? ClockingEventInfoItemWidget(
                        description: CollectorLocalizations.of(context)
                            .clockInfoDescription1,
                        icon: const Icon(
                          FontAwesomeIcons.rotate,
                          size: SeniorIconSize.large - SeniorIconSize.xsmall,
                          color: SeniorColors.manchesterColorBlue600,
                        ),
                        title:
                            CollectorLocalizations.of(context).clockInfoTitle1,
                      )
                    : sizedBox,
                showSynced ? sizedBoxSmall : sizedBox,
                showMobile
                    ? ClockingEventInfoItemWidget(
                        description: CollectorLocalizations.of(context)
                            .clockInfoDescription3,
                        icon: const Icon(
                          FontAwesomeIcons.mobileScreenButton,
                          size: SeniorIconSize.large - SeniorIconSize.xsmall,
                          color: SeniorColors.neutralColor600,
                        ),
                        title:
                            CollectorLocalizations.of(context).clockInfoTitle3,
                      )
                    : sizedBox,
                showMobile ? sizedBoxSmall : sizedBox,
                showPlatform
                    ? ClockingEventInfoItemWidget(
                        description: CollectorLocalizations.of(context)
                            .clockInfoDescription4,
                        icon: const Icon(
                          FontAwesomeIcons.desktop,
                          size: SeniorIconSize.large - SeniorIconSize.xsmall,
                          color: SeniorColors.neutralColor600,
                        ),
                        title:
                            CollectorLocalizations.of(context).clockInfoTitle4,
                      )
                    : sizedBox,
                showPlatform ? sizedBoxSmall : sizedBox,
                showManual
                    ? ClockingEventInfoItemWidget(
                        description: CollectorLocalizations.of(context)
                            .clockInfoDescription5,
                        icon: const Icon(
                          FontAwesomeIcons.squarePen,
                          size: SeniorIconSize.large - SeniorIconSize.xsmall,
                          color: SeniorColors.manchesterColorOrange600,
                        ),
                        title:
                            CollectorLocalizations.of(context).clockInfoTitle5,
                      )
                    : sizedBox,
                showManual ? sizedBoxSmall : sizedBox,
                showOdd
                    ? ClockingEventInfoItemWidget(
                        description: CollectorLocalizations.of(context)
                            .clockInfoDescription6,
                        icon: const Icon(
                          FontAwesomeIcons.solidCalendarXmark,
                          size: SeniorIconSize.large - SeniorIconSize.xsmall,
                          color: SeniorColors.manchesterColorRed600,
                        ),
                        title:
                            CollectorLocalizations.of(context).clockInfoTitle6,
                      )
                    : sizedBox,
                showOdd ? sizedBoxSmall : sizedBox,
                showRemoteness
                    ? ClockingEventInfoItemWidget(
                        description: CollectorLocalizations.of(context)
                            .clockInfoDescription7,
                        icon: const Icon(
                          FontAwesomeIcons.userInjured,
                          size: SeniorIconSize.large - SeniorIconSize.xsmall,
                          color: SeniorColors.manchesterColorYellow600,
                        ),
                        title:
                            CollectorLocalizations.of(context).clockInfoTitle7,
                      )
                    : sizedBox,
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(SeniorSpacing.medium),
          child: SeniorButton.ghost(
            label: CollectorLocalizations.of(context).infoUnderstoodButton,
            fullWidth: true,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ],
    );
  }
}
