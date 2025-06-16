// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/components/senior_text/senior_text.dart';
import 'package:senior_design_system/repositories/theme_repository.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../core/extension/media_query_extension.dart';
import '../../../../../core/extension/translate_extension.dart';
import '../../../../../core/helper/locale_helper.dart';
import '../../../domain/entities/happiness_index_mood_entity.dart';
import '../../../enums/happiness_index_mood_enum.dart';
import '../../../infra/models/happiness_index_line_chart_model.dart';
import '../happiness_index_mood_widget.dart';
import 'happiness_index_line_chart_widget.dart';

class HappinessIndexSwingMoodsChartWidget extends StatefulWidget {
  final List<HappinessIndexMoodEntity> moods;
  final DateTime startDate;
  final DateTime endDate;

  const HappinessIndexSwingMoodsChartWidget({
    Key? key,
    required this.moods,
    required this.startDate,
    required this.endDate,
  }) : super(key: key);

  @override
  State<HappinessIndexSwingMoodsChartWidget> createState() => _HappinessIndexSwingMoodsChartWidgetState();
}

class _HappinessIndexSwingMoodsChartWidgetState extends State<HappinessIndexSwingMoodsChartWidget> {
  List<HappinessIndexLineChartModel> data = [];
  final referenceWidthChart = 328.0;
  final referenceWidthLine = 296.0;
  final referenceWidthWidgetChart = 360.0;
  final maxHeightChart = 154.0;
  final heightChartWidget = 176.0;
  final strokeWidth = 4.0;
  final maxHeightLineChart = 122.0;
  final referenceWidthLineChart = 274;

  @override
  void initState() {
    super.initState();
    loadMoods();
  }

  @override
  Widget build(BuildContext context) {
    final proportion = context.widthSize / referenceWidthWidgetChart;

    Paint circlePaint = Paint()
      ..color = SeniorColors.primaryColor400
      ..strokeWidth = strokeWidth;

    Paint insideCirclePaint = Paint()
      ..color = Provider.of<ThemeRepository>(context).theme.backdropTheme!.style!.bodyColor!;

    Paint linePaint = Paint()
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..color = SeniorColors.primaryColor400;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: SeniorSpacing.normal,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SeniorText.label(
            context.translate.moodSwings,
            color: SeniorColors.grayscale90,
            darkColor: SeniorColors.grayscale30,
          ),
          SizedBox(
            height: heightChartWidget,
            width: referenceWidthChart * proportion,
            child: Row(
              children: [
                SizedBox(
                  height: maxHeightChart,
                  width: SeniorSpacing.xmedium,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: SeniorSpacing.xxxsmall,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        for (var mood in HappinessIndexMoodEnum.values)
                          HappinessIndexMoodWidget(
                            mood: mood,
                            disabled: false,
                            isSelected: false,
                            isDefined: false,
                            size: SeniorSpacing.xmedium,
                            iconSize: SeniorSpacing.medium,
                          ),
                        const SizedBox(
                          height: SeniorSpacing.xxxsmall,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: SeniorSpacing.xsmall,
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    height: maxHeightChart,
                    width: referenceWidthLine * proportion,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HappinessIndexLineChartWidget(
                          height: maxHeightLineChart,
                          width: referenceWidthLineChart * proportion,
                          data: data,
                          linePaint: linePaint,
                          circlePaint: circlePaint,
                          circleRadiusValue: 6,
                          showPointer: true,
                          showCircles: true,
                          insideCirclePaint: insideCirclePaint,
                          padding: SeniorSpacing.xmedium,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              const SizedBox(
                width: 36,
              ),
              SizedBox(
                width: 256 * proportion,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    for (var d in data)
                      SeniorText.small(
                        DateFormat.E(
                          LocaleHelper.languageAndCountryCode(
                            locale: Localizations.localeOf(context),
                          ),
                        ).format(d.date!).toUpperCase(),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void loadMoods() {
    DateTime currentDate = widget.startDate;

    DateTime lastDate = widget.endDate.add(
      const Duration(
        days: 1,
      ),
    );

    while (currentDate.isBefore(lastDate)) {
      final mood = widget.moods.where((moodDay) => DateUtils.isSameDay(moodDay.date, currentDate));

      data.add(
        HappinessIndexLineChartModel(
          amount: mood.isNotEmpty ? mood.first.happinessIndexMood.valueOfChartLine() : 0,
          date: currentDate,
        ),
      );

      currentDate = currentDate.add(
        const Duration(
          days: 1,
        ),
      );
    }
  }
}
