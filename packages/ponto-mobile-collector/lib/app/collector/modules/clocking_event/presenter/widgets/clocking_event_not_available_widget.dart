import 'package:flutter/material.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/tokens/senior_colors.dart';
import 'package:senior_design_tokens/tokens/senior_spacing.dart';

import 'clocking_event_receipt/app_senior_card_widget.dart';


class ClockingEventNotAvailableWidget extends StatelessWidget {
  final String title;
  final String description;
  final Icon icon;
  final EdgeInsets? margin;
  final EdgeInsetsGeometry? padding;
  final bool disabled;

  const ClockingEventNotAvailableWidget({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    this.margin,
    this.padding,
    required this.disabled,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: AppSeniorCardWidget(
        disabled: disabled,
        margin: margin,
        showActionIcon: false,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icon,
            const SizedBox(width: SeniorSpacing.normal),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SeniorText.body(
                    title,
                    color: SeniorColors.neutralColor900,
                    textProperties: const TextProperties(
                      maxLines: 3,
                      softWrap: true,
                    ),
                  ),
                  SeniorText.small(
                    description,
                    color: SeniorColors.neutralColor700,
                    textProperties: const TextProperties(
                      maxLines: 3,
                      softWrap: true,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
