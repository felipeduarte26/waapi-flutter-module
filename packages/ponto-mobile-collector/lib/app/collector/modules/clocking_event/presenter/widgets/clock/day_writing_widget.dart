import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../../generated/l10n/collector_localizations.dart';
import '../../../../../core/infra/utils/extension/string_extension.dart';

class DayWritingWidget extends StatelessWidget {
  final DateTime day;

  const DayWritingWidget({required this.day, super.key});

  @override
  Widget build(BuildContext context) {
    return SeniorText.body(
      '${DateFormat.EEEE(
        CollectorLocalizations.of(context).localeName,
      ).format(
            day,
          ).capitalize()} - ${DateFormat(
        CollectorLocalizations.of(context).dateFormatClock,
        CollectorLocalizations.of(context).localeName,
      ).format(
            day,
          ).capitalize()}',
      color: SeniorColors.secondaryColor800,
    );
  }
}
