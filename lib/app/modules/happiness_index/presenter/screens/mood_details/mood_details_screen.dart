import 'package:flutter/material.dart';
import 'package:senior_design_system/components/senior_quotes/senior_quotes.dart';
import 'package:senior_design_system/components/senior_text/senior_text.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../core/extension/translate_extension.dart';
import '../../../../../core/helper/date_time_helper.dart';
import '../../../../../core/helper/locale_helper.dart';
import '../../../../../core/widgets/waapi_colorful_header.dart';
import '../../../domain/entities/happiness_index_mood_entity.dart';
import '../../widgets/happiness_index_mood_widget.dart';
import '../../widgets/select_mood/happiness_index_show_reasons_widget.dart';

class MoodDetailsScreen extends StatefulWidget {
  const MoodDetailsScreen({
    super.key,
    required this.mood,
  });

  final HappinessIndexMoodEntity mood;

  @override
  State<MoodDetailsScreen> createState() => _MoodDetailsScreenState();
}

class _MoodDetailsScreenState extends State<MoodDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WaapiColorfulHeader(
        titleLabel: context.translate.moodDiary,
        body: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: SeniorSpacing.normal,
                ),
                SeniorText.h4(
                  DateTimeHelper.formatWithDefaultDatePattern(
                    dateTime: widget.mood.date,
                    locale: LocaleHelper.languageAndCountryCode(
                      locale: Localizations.localeOf(context),
                    ),
                  ),
                ),
                SeniorText.small(
                  DateTimeHelper.getNameWeek(
                    weekDay: widget.mood.date.weekday,
                    appLocalizations: context.translate,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: SeniorSpacing.xsmall,
                  ),
                  child: SeniorText.label(
                    isToday() ? context.translate.yourMoodTodayIs : context.translate.onThisDayYourMoodWas,
                  ),
                ),
                HappinessIndexMoodWidget(
                  mood: widget.mood.happinessIndexMood,
                  isSelected: true,
                  isDefined: true,
                  disabled: false,
                  showBadgeOnMood: true,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(
                      SeniorSpacing.normal,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            SeniorText.labelBold(
                              context.translate.reasons,
                            ),
                          ],
                        ),
                        Offstage(
                          offstage:
                              widget.mood.happinessIndexGroups != null && widget.mood.happinessIndexGroups!.isEmpty,
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemCount: widget.mood.happinessIndexGroups?.length ?? 0,
                            itemBuilder: (_, index) {
                              return HappinessIndexShowReasonsWidget(
                                groupReasons: widget.mood.happinessIndexGroups![index],
                                reasons: const [],
                              );
                            },
                          ),
                        ),
                        Offstage(
                          offstage:
                              widget.mood.happinessIndexGroups != null && widget.mood.happinessIndexGroups!.isNotEmpty,
                          child: SeniorText.label(context.translate.noRecordsThisDay),
                        ),
                        if (widget.mood.note != null && widget.mood.note!.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: SeniorSpacing.normal,
                            ),
                            child: SizedBox(
                              width: double.infinity,
                              child: SeniorQuotes(
                                key: const Key('happiness_index-mood_details_screen-senior_quotes-note'),
                                message: widget.mood.note ?? '',
                                isScrollable: false,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool isToday() {
    return widget.mood.date.day == DateTime.now().day &&
        widget.mood.date.month == DateTime.now().month &&
        widget.mood.date.year == DateTime.now().year;
  }
}
