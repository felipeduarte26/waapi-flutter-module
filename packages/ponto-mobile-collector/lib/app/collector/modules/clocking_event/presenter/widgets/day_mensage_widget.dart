import 'package:flutter/material.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../generated/l10n/collector_localizations.dart';


class DayMessageWidget extends StatelessWidget {
  final String? fullName;
  final DateTime day;

  const DayMessageWidget({
    required this.day,
    this.fullName,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String msg;
    if (day.hour >= 1 && day.hour < 12) {
      msg = CollectorLocalizations.of(context).clockingEventGoodMorning;
    } else if (day.hour >= 12 && day.hour < 18) {
      msg = CollectorLocalizations.of(context).clockingEventGoodAfternoon;
    } else {
      msg = CollectorLocalizations.of(context).clockingEventGoodEvening;
    }

    if (fullName != null) {
      msg = '$msg, ${fullName?.split(' ').first}';
    } else {
      msg = '$msg!';
    }

    return SeniorText.h4(
      msg,
      color: SeniorColors.secondaryColor900,
    );
  }
}
