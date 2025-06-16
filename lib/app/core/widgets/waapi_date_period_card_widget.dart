import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../extension/translate_extension.dart';
import '../helper/date_time_helper.dart';
import '../helper/locale_helper.dart';

class WaapiDatePeriodCardWidget extends StatefulWidget {
  final DateTime startDate;
  final DateTime endDate;
  final IconData icon;
  final EdgeInsetsGeometry padding;
  final String? title;

  const WaapiDatePeriodCardWidget({
    Key? key,
    required this.startDate,
    required this.endDate,
    this.title,
    this.icon = FontAwesomeIcons.calendarDays,
    this.padding = const EdgeInsets.only(
      bottom: SeniorSpacing.normal,
    ),
  }) : super(key: key);

  @override
  State<WaapiDatePeriodCardWidget> createState() => _WaapiDatePeriodCardWidgetState();
}

class _WaapiDatePeriodCardWidgetState extends State<WaapiDatePeriodCardWidget> {
  String formattedStartDate = '';
  String formattedEndDate = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      formattedStartDate = DateTimeHelper.formatWithDefaultDatePattern(
        dateTime: widget.startDate,
        locale: LocaleHelper.languageAndCountryCode(
          locale: Localizations.localeOf(context),
        ),
      );

      formattedEndDate = DateTimeHelper.formatWithDefaultDatePattern(
        dateTime: widget.endDate,
        locale: LocaleHelper.languageAndCountryCode(
          locale: Localizations.localeOf(context),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: SizedBox(
        child: Column(
          children: [
            ClipOval(
              child: Container(
                width: SeniorIconSize.big,
                height: SeniorIconSize.big,
                color: SeniorColors.secondaryColor100,
                child: Center(
                  child: SeniorIcon(
                    icon: widget.icon,
                    size: SeniorIconSize.small,
                    style: const SeniorIconStyle(
                      color: SeniorColors.secondaryColor800,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: SeniorSpacing.xsmall,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SeniorText.smallBold(
                  context.translate.rangeDate(
                    formattedStartDate,
                    formattedEndDate,
                  ),
                ),
              ],
            ),
            if (widget.title != null)
              SeniorText.small(
                widget.title!,
                color: SeniorColors.neutralColor500,
              ),
          ],
        ),
      ),
    );
  }
}
