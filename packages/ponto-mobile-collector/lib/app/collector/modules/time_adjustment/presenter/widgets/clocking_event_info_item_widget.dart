import 'package:flutter/material.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

class ClockingEventInfoItemWidget extends StatelessWidget {
  final Icon icon;
  final String title;
  final String description;

  const ClockingEventInfoItemWidget({
    super.key,
    required this.description,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            icon,
          ],
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SeniorText.body(
                  title,
                  color: SeniorColors.neutralColor800,
                ),
                SeniorText.small(
                  description,
                  textProperties: const TextProperties(
                    softWrap: true,
                  ),
                  color: SeniorColors.neutralColor500,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
