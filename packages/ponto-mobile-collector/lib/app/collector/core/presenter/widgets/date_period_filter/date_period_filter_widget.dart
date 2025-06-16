import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../ponto_mobile_collector.dart';

class DatePeriodFilterWidget extends StatefulWidget {
  final IUtils _utils;
  final bool addKeyboardPadding;
  final GlobalKey<FormState>? formKey;
  final String? initInitialValue;
  final String? endInitialValue;
  final void Function(String value)? onInitDateChanged;
  final void Function(String value)? onEndDateChanged;
  final void Function(
    String initDate,
    String endDate,
  )? onFilterPressed;

  late final TextEditingController _initTextEditingController;
  late final TextEditingController _endTextEditingController;

  DatePeriodFilterWidget({
    super.key,
    required IUtils utils,
    this.formKey,
    this.addKeyboardPadding = true,
    this.initInitialValue,
    this.endInitialValue,
    this.onInitDateChanged,
    this.onEndDateChanged,
    this.onFilterPressed,
  })  : _utils = utils,
        _initTextEditingController = TextEditingController(
          text: initInitialValue,
        ),
        _endTextEditingController = TextEditingController(
          text: endInitialValue,
        );

  @override
  State<DatePeriodFilterWidget> createState() => _DatePeriodFilterWidgetState();
}

class _DatePeriodFilterWidgetState extends State<DatePeriodFilterWidget> {
  DateTime _initCurrentDate = DateTime.now();
  DateTime _endCurrentDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final collectorLocalizations = CollectorLocalizations.of(context);
    final isDark = Provider.of<ThemeRepository>(context).isDarkTheme();
    final mediaQuery = MediaQuery.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SeniorText.cta(
          collectorLocalizations.selectPeriodToFilter,
        ),
        const SizedBox(
          height: SeniorSpacing.normal,
        ),
        SeniorText.small(
          collectorLocalizations.period,
        ),
        const SizedBox(
          height: SeniorSpacing.xsmall,
        ),
        Form(
          key: widget.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SeniorTextField(
                  key: const Key('initDateTextField'),
                  onTap: () {
                    /// Calendar First Date
                    /// The starting period cannot be longer than the ending period
                    if (_initCurrentDate.isAfter(_endCurrentDate)) {
                      _initCurrentDate = _endCurrentDate;
                    }

                    DateTime initRangeDate =
                        _endCurrentDate.subtract(const Duration(days: 60));
                    DateTime endRangeDate = _endCurrentDate;

                    if (endRangeDate.isAfter(DateTime.now())) {
                      endRangeDate = DateTime.now();
                    }

                    SeniorCalendar(
                      key: const Key('initialCalendar'),
                      showStrokeTop: true,
                      calendarTitle: CollectorLocalizations.of(context)
                          .selectTheStartingDate,
                      selectedDay: _initCurrentDate,
                      firstDay: initRangeDate,
                      lastDay: endRangeDate,
                      highlightToday: true,
                      locale: Localizations.localeOf(context).languageCode,
                      onDaySelected: (date) {
                        widget._initTextEditingController.text = DateFormat.yMd(
                          collectorLocalizations.localeName,
                        ).format(date);
                        _initCurrentDate = date;
                        Navigator.pop(context);
                      },
                    ).pickCalendar(context);
                  },
                  controller: widget._initTextEditingController,
                  keyboardType: TextInputType.none,
                  suffixIcon: FontAwesomeIcons.solidCalendarDays,
                  inputFormatters: [
                    MaskedInputFormatter(
                      widget._utils.getDateMaskFromLocale(
                        collectorLocalizations.localeName,
                      ),
                    ),
                  ],
                  style: SeniorTextFieldStyle(
                    fillColor: isDark ? null : SeniorColors.grayscale10,
                  ),
                  label: collectorLocalizations.init,
                  hintText: widget._utils.getDateMaskFromLocale(
                    collectorLocalizations.localeName,
                  ),
                  onChanged: widget.onInitDateChanged,
                  validator: (text) {
                    if (text != null && text.length > 9) {
                      try {
                        final initDateFormat = DateFormat.yMd(
                          collectorLocalizations.localeName,
                        ).parseStrict(
                          text,
                        );

                        try {
                          final endDateFormat = DateFormat.yMd(
                            collectorLocalizations.localeName,
                          ).parseStrict(
                            widget._endTextEditingController.text,
                          );

                          if (initDateFormat.isAfter(endDateFormat)) {
                            return collectorLocalizations.moreThanEndDate;
                          }
                        } catch (_) {}
                      } catch (_) {
                        return collectorLocalizations.invalidDateFormat;
                      }
                    } else {
                      return collectorLocalizations.invalidDate;
                    }

                    return null;
                  },
                ),
              ),
              const SizedBox(
                width: SeniorSpacing.xsmall,
              ),
              Expanded(
                child: SeniorTextField(
                  key: const Key('endDateTextField'),
                  onTap: () {
                    /// Calendar End Date
                    /// The starting period cannot be longer than the ending period
                    if (_initCurrentDate.isBefore(_endCurrentDate)) {
                      _endCurrentDate = _initCurrentDate;
                    }

                    DateTime initRangeDate = _initCurrentDate;
                    DateTime endRangeDate =
                        _initCurrentDate.add(const Duration(days: 60));

                    if (endRangeDate.isAfter(DateTime.now())) {
                      endRangeDate = DateTime.now();
                    }

                    SeniorCalendar(
                      showStrokeTop: true,
                      calendarTitle:
                          CollectorLocalizations.of(context).selectTheEndDate,
                      selectedDay: _endCurrentDate,
                      firstDay: initRangeDate,
                      lastDay: endRangeDate,
                      highlightToday: true,
                      locale: Localizations.localeOf(context).languageCode,
                      onDaySelected: (date) {
                        widget._endTextEditingController.text = DateFormat.yMd(
                          collectorLocalizations.localeName,
                        ).format(date);
                        _endCurrentDate = date;
                        Navigator.pop(context);
                      },
                    ).pickCalendar(context);
                  },
                  controller: widget._endTextEditingController,
                  keyboardType: TextInputType.none,
                  suffixIcon: FontAwesomeIcons.solidCalendarDays,
                  inputFormatters: [
                    MaskedInputFormatter(
                      widget._utils.getDateMaskFromLocale(
                        collectorLocalizations.localeName,
                      ),
                    ),
                  ],
                  style: SeniorTextFieldStyle(
                    fillColor: isDark ? null : SeniorColors.grayscale10,
                  ),
                  label: collectorLocalizations.end,
                  hintText: widget._utils.getDateMaskFromLocale(
                    collectorLocalizations.localeName,
                  ),
                  onChanged: widget.onEndDateChanged,
                  validator: (text) {
                    if (text != null && text.length > 9) {
                      try {
                        final endDateFormat = DateFormat.yMd(
                          collectorLocalizations.localeName,
                        ).parseStrict(
                          text,
                        );

                        try {
                          final initDateFormat = DateFormat.yMd(
                            collectorLocalizations.localeName,
                          ).parseStrict(
                            widget._initTextEditingController.text,
                          );

                          if (endDateFormat.isBefore(initDateFormat)) {
                            return collectorLocalizations.lessThanStartDate;
                          }
                        } catch (_) {}
                      } catch (_) {
                        return collectorLocalizations.invalidDateFormat;
                      }
                    } else {
                      return collectorLocalizations.invalidDate;
                    }

                    return null;
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: SeniorSpacing.normal,
        ),
        SeniorButton(
          fullWidth: true,
          label: collectorLocalizations.filter,
          onPressed: () {
            if (widget.onFilterPressed != null) {
              final initDate = widget._initTextEditingController.text;
              final endDate = widget._endTextEditingController.text;

              widget.onFilterPressed!(
                initDate,
                endDate,
              );
            }
          },
        ),
        const SizedBox(
          height: SeniorSpacing.normal,
        ),
        SeniorButton.ghost(
          fullWidth: true,
          label: collectorLocalizations.cancel,
          onPressed: () => Navigator.pop(context),
        ),
        if (widget.addKeyboardPadding)
          SizedBox(
            height: mediaQuery.viewInsets.bottom + SeniorSpacing.normal,
          ),
      ],
    );
  }
}
