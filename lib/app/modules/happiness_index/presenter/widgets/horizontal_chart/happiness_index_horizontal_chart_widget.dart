import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../core/extension/translate_extension.dart';
import '../../../enums/happiness_index_mood_enum.dart';
import '../happiness_index_mood_widget.dart';
import 'happiness_index_chart_line_widget.dart';

const _hundredPerCent = 100;

const _milliSecondsAnimationInit = 400;
const _screenWidthRemovePadding = 32;

class HappinessIndexHorizontalChartWidget extends StatefulWidget {
  final List<HappinessIndexMoodEnum> moods;

  const HappinessIndexHorizontalChartWidget({
    Key? key,
    required this.moods,
  }) : super(key: key);

  @override
  State<HappinessIndexHorizontalChartWidget> createState() => _HappinessIndexHorizontalChartWidgetState();
}

class _HappinessIndexHorizontalChartWidgetState extends State<HappinessIndexHorizontalChartWidget> {
  List<HappinessIndexMoodEnum> selectedMoods = [];

  var moodGreatInitAnimation = false;
  var moodFineInitAnimation = false;
  var moodNeutralInitAnimation = false;
  var moodUpsetInitAnimation = false;
  var moodAngryInitAnimation = false;

  late double percentageGreat;
  late double percentageFine;
  late double percentageNeutral;
  late double percentageUpset;
  late double percentageAngry;
  late double screenWidthWithoutPadding;

  HappinessIndexMoodEnum? happinessIndexMoodEnum;

  int? selectedMoodIndex;

  @override
  void initState() {
    calculatePercentages();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initAnimation();
    });
  }

  @override
  Widget build(BuildContext context) {
    screenWidthWithoutPadding = MediaQuery.of(context).size.width - _screenWidthRemovePadding;
    final isDarkMode = Provider.of<ThemeRepository>(context).isDarkTheme();
    return Builder(
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: SeniorSpacing.normal,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SeniorText.label(
                context.translate.moodCount,
                color: SeniorColors.grayscale90,
                darkColor: SeniorColors.grayscale30,
              ),
              const SizedBox(
                height: SeniorSpacing.small,
              ),
              Container(
                width: screenWidthWithoutPadding,
                decoration: BoxDecoration(
                  color: isDarkMode ? SeniorColors.pureBlack : SeniorColors.pureWhite,
                  borderRadius: BorderRadius.circular(
                    SeniorSpacing.xsmall,
                  ),
                ),
                height: SeniorSpacing.xmedium,
                child: Row(
                  children: [
                    HappinessIndexChartLineWidget(
                      onTap: () {
                        selectMoodAndMoodWidget(HappinessIndexMoodEnum.great);
                      },
                      animatedContainerWidth: moodGreatInitAnimation
                          ? getWidthAnimatedContainer(
                              moodEnum: HappinessIndexMoodEnum.great,
                            )
                          : 0,
                      color: getMoodColor(
                        moodEnum: HappinessIndexMoodEnum.great,
                      ),
                      borderRadius: getBorderRadius(
                        moodEnum: HappinessIndexMoodEnum.great,
                      ),
                      moodEnum: HappinessIndexMoodEnum.great,
                      border: getBorderAnimatedContainer(
                        moodEnum: HappinessIndexMoodEnum.great,
                        isDarkMode: isDarkMode,
                      ),
                    ),
                    HappinessIndexChartLineWidget(
                      onTap: () {
                        selectMoodAndMoodWidget(HappinessIndexMoodEnum.fine);
                      },
                      animatedContainerWidth: moodFineInitAnimation
                          ? getWidthAnimatedContainer(
                              moodEnum: HappinessIndexMoodEnum.fine,
                            )
                          : 0,
                      color: getMoodColor(
                        moodEnum: HappinessIndexMoodEnum.fine,
                      ),
                      borderRadius: getBorderRadius(
                        moodEnum: HappinessIndexMoodEnum.fine,
                      ),
                      moodEnum: HappinessIndexMoodEnum.fine,
                      border: getBorderAnimatedContainer(
                        moodEnum: HappinessIndexMoodEnum.fine,
                        isDarkMode: isDarkMode,
                      ),
                    ),
                    HappinessIndexChartLineWidget(
                      onTap: () {
                        selectMoodAndMoodWidget(HappinessIndexMoodEnum.neutral);
                      },
                      animatedContainerWidth: moodNeutralInitAnimation
                          ? getWidthAnimatedContainer(
                              moodEnum: HappinessIndexMoodEnum.neutral,
                            )
                          : 0,
                      color: getMoodColor(
                        moodEnum: HappinessIndexMoodEnum.neutral,
                      ),
                      borderRadius: getBorderRadius(
                        moodEnum: HappinessIndexMoodEnum.neutral,
                      ),
                      moodEnum: HappinessIndexMoodEnum.neutral,
                      border: getBorderAnimatedContainer(
                        moodEnum: HappinessIndexMoodEnum.neutral,
                        isDarkMode: isDarkMode,
                      ),
                    ),
                    HappinessIndexChartLineWidget(
                      onTap: () {
                        selectMoodAndMoodWidget(HappinessIndexMoodEnum.upset);
                      },
                      animatedContainerWidth: moodUpsetInitAnimation
                          ? getWidthAnimatedContainer(
                              moodEnum: HappinessIndexMoodEnum.upset,
                            )
                          : 0,
                      color: getMoodColor(
                        moodEnum: HappinessIndexMoodEnum.upset,
                      ),
                      borderRadius: getBorderRadius(
                        moodEnum: HappinessIndexMoodEnum.upset,
                      ),
                      moodEnum: HappinessIndexMoodEnum.upset,
                      border: getBorderAnimatedContainer(
                        moodEnum: HappinessIndexMoodEnum.upset,
                        isDarkMode: isDarkMode,
                      ),
                    ),
                    HappinessIndexChartLineWidget(
                      onTap: () {
                        selectMoodAndMoodWidget(HappinessIndexMoodEnum.angry);
                      },
                      animatedContainerWidth: moodAngryInitAnimation
                          ? getWidthAnimatedContainer(
                              moodEnum: HappinessIndexMoodEnum.angry,
                            )
                          : 0,
                      color: getMoodColor(
                        moodEnum: HappinessIndexMoodEnum.angry,
                      ),
                      borderRadius: getBorderRadius(
                        moodEnum: HappinessIndexMoodEnum.angry,
                      ),
                      moodEnum: HappinessIndexMoodEnum.angry,
                      border: getBorderAnimatedContainer(
                        moodEnum: HappinessIndexMoodEnum.angry,
                        isDarkMode: isDarkMode,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(
                  SeniorSpacing.normal,
                ),
                child: SizedBox(
                  height: happinessIndexMoodEnum == null ? SeniorSpacing.xxhuge : 100,
                  child: Center(
                    child: ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: selectedMoods.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final mood = selectedMoods[index];
                        final isSelected = index == selectedMoodIndex;
                        final isDefined = isSelected || moodSelected(happinessIndexMoodEnum);
                        const isDisabled = false;

                        return Center(
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                width: SeniorSpacing.xbig,
                                height: SeniorSpacing.medium,
                                decoration: BoxDecoration(
                                  color: getMoodColor(
                                    moodEnum: mood,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    SeniorSpacing.xbig,
                                  ),
                                ),
                                child: ColorFiltered(
                                  colorFilter: ColorFilter.mode(
                                    getColorFilter(moodEnum: mood),
                                    BlendMode.srcIn,
                                  ),
                                  child: Center(
                                    child: SeniorText.small(
                                      '${getMoodPorcentageSelected(moodEnum: mood)}%',
                                      color: SeniorColors.pureBlack,
                                      darkColor: SeniorColors.pureBlack,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: SeniorSpacing.xsmall,
                              ),
                              HappinessIndexMoodWidget(
                                size: SeniorIconSize.big,
                                iconSize: SeniorIconSize.large,
                                mood: mood,
                                isSelected: isSelected,
                                isDefined: isDefined,
                                onSelectedMood: (mood) {
                                  setState(() {
                                    if (happinessIndexMoodEnum == mood) {
                                      happinessIndexMoodEnum = null;
                                      selectedMoodIndex = -2;
                                    } else {
                                      selectedMoodIndex = index;
                                      happinessIndexMoodEnum = mood;
                                    }
                                  });
                                },
                                disabled: isDisabled,
                                showBadgeOnMood: !isDisabled,
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          width: SeniorSpacing.normal,
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void selectMoodAndMoodWidget(HappinessIndexMoodEnum moodEnum) {
    setState(() {
      if (happinessIndexMoodEnum == moodEnum) {
        happinessIndexMoodEnum = null;
        selectedMoodIndex = -2;
      } else {
        happinessIndexMoodEnum = moodEnum;
        selectedMoodIndex = selectedMoods.indexOf(moodEnum);
      }
    });
  }

  bool moodSelected(HappinessIndexMoodEnum? moodEnum) {
    return moodEnum != null;
  }

  BorderSide? getBorderAnimatedContainer({
    HappinessIndexMoodEnum? moodEnum,
    required bool isDarkMode,
  }) {
    if (moodEnum == null || happinessIndexMoodEnum == null) {
      return null;
    }
    Color borderColor;

    switch (moodEnum) {
      case HappinessIndexMoodEnum.great:
        borderColor = isDarkMode ? SeniorColors.primaryColor100 : SeniorColors.primaryColor700;
        break;
      case HappinessIndexMoodEnum.fine:
        borderColor = isDarkMode ? SeniorColors.manchesterColorBlue100 : SeniorColors.manchesterColorBlue700;
        break;
      case HappinessIndexMoodEnum.neutral:
        borderColor = isDarkMode ? SeniorColors.grayscale10 : SeniorColors.grayscale70;
        break;
      case HappinessIndexMoodEnum.upset:
        borderColor = isDarkMode ? SeniorColors.manchesterColorOrange100 : SeniorColors.manchesterColorOrange700;
        break;
      case HappinessIndexMoodEnum.angry:
        borderColor = isDarkMode ? SeniorColors.manchesterColorRed100 : SeniorColors.manchesterColorRed700;
        break;
    }

    return moodEnum == happinessIndexMoodEnum
        ? BorderSide(
            color: borderColor,
            width: 2,
          )
        : BorderSide.none;
  }

  Color getMoodColor({
    required HappinessIndexMoodEnum moodEnum,
  }) {
    double opacity = 1.0;

    if (moodEnum != happinessIndexMoodEnum && moodSelected(happinessIndexMoodEnum)) {
      opacity = 0.7;
    }

    switch (moodEnum) {
      case HappinessIndexMoodEnum.great:
        return SeniorColors.primaryColor300.withOpacity(
          opacity,
        );
      case HappinessIndexMoodEnum.fine:
        return SeniorColors.manchesterColorBlue300.withOpacity(
          opacity,
        );
      case HappinessIndexMoodEnum.neutral:
        return SeniorColors.grayscale30.withOpacity(
          opacity,
        );
      case HappinessIndexMoodEnum.upset:
        return SeniorColors.manchesterColorOrange300.withOpacity(
          opacity,
        );
      case HappinessIndexMoodEnum.angry:
        return SeniorColors.manchesterColorRed300.withOpacity(
          opacity,
        );
    }
  }

  BorderRadius getBorderRadius({
    required HappinessIndexMoodEnum moodEnum,
  }) {
    bool isFirstMood = selectedMoods.first == moodEnum;
    bool lastMood = selectedMoods.last == moodEnum;
    bool onlyOneMood = selectedMoods.length == 1;

    if (onlyOneMood) {
      return BorderRadius.circular(
        SeniorSpacing.xsmall,
      );
    } else if (isFirstMood) {
      return const BorderRadius.only(
        topLeft: Radius.circular(
          SeniorSpacing.xsmall,
        ),
        bottomLeft: Radius.circular(
          SeniorSpacing.xsmall,
        ),
      );
    } else if (lastMood) {
      return const BorderRadius.only(
        topRight: Radius.circular(
          SeniorSpacing.xsmall,
        ),
        bottomRight: Radius.circular(
          SeniorSpacing.xsmall,
        ),
      );
    } else {
      return BorderRadius.zero;
    }
  }

  Future<void> animation({
    required VoidCallback setStateCallback,
  }) async {
    if (!mounted) return;
    setState(() {
      setStateCallback();
    });
    await Future.delayed(
      const Duration(
        milliseconds: _milliSecondsAnimationInit,
      ),
    );
  }

  void initAnimation() async {
    if (percentageGreat > 0) {
      await animation(
        setStateCallback: () {
          moodGreatInitAnimation = true;
        },
      );
    }
    if (percentageFine > 0) {
      await animation(
        setStateCallback: () {
          moodFineInitAnimation = true;
        },
      );
    }
    if (percentageNeutral > 0) {
      await animation(
        setStateCallback: () {
          moodNeutralInitAnimation = true;
        },
      );
    }
    if (percentageUpset > 0) {
      await animation(
        setStateCallback: () {
          moodUpsetInitAnimation = true;
        },
      );
    }
    if (percentageAngry > 0) {
      await animation(
        setStateCallback: () {
          moodAngryInitAnimation = true;
        },
      );
    }
  }

  Color getColorFilter({
    required HappinessIndexMoodEnum moodEnum,
  }) {
    return moodEnum != happinessIndexMoodEnum && moodSelected(happinessIndexMoodEnum)
        ? SeniorColors.pureBlack.withOpacity(0.25)
        : SeniorColors.pureBlack.withOpacity(1.0);
  }

  int getMoodPorcentageSelected({
    required HappinessIndexMoodEnum moodEnum,
  }) {
    switch (moodEnum) {
      case HappinessIndexMoodEnum.great:
        return percentageGreat.toInt();
      case HappinessIndexMoodEnum.fine:
        return percentageFine.toInt();
      case HappinessIndexMoodEnum.neutral:
        return percentageNeutral.toInt();
      case HappinessIndexMoodEnum.upset:
        return percentageUpset.toInt();
      case HappinessIndexMoodEnum.angry:
        return percentageAngry.toInt();
    }
  }

  void calculatePercentages() {
    final great = widget.moods.where((element) => element == HappinessIndexMoodEnum.great).length;
    final fine = widget.moods.where((element) => element == HappinessIndexMoodEnum.fine).length;
    final neutral = widget.moods.where((element) => element == HappinessIndexMoodEnum.neutral).length;
    final upset = widget.moods.where((element) => element == HappinessIndexMoodEnum.upset).length;
    final angry = widget.moods.where((element) => element == HappinessIndexMoodEnum.angry).length;

    if (great > 0) {
      selectedMoods.add(
        HappinessIndexMoodEnum.great,
      );
    }
    if (fine > 0) {
      selectedMoods.add(
        HappinessIndexMoodEnum.fine,
      );
    }
    if (neutral > 0) {
      selectedMoods.add(
        HappinessIndexMoodEnum.neutral,
      );
    }
    if (upset > 0) {
      selectedMoods.add(
        HappinessIndexMoodEnum.upset,
      );
    }
    if (angry > 0) {
      selectedMoods.add(
        HappinessIndexMoodEnum.angry,
      );
    }

    percentageGreat = calculateMoodPercentage(great);
    percentageFine = calculateMoodPercentage(fine);
    percentageNeutral = calculateMoodPercentage(neutral);
    percentageUpset = calculateMoodPercentage(upset);
    percentageAngry = calculateMoodPercentage(angry);
  }

  double calculateMoodPercentage(int count) {
    return double.parse(((count / widget.moods.length) * _hundredPerCent).toStringAsFixed(2)).roundToDouble();
  }

  double getWidthAnimatedContainer({
    required HappinessIndexMoodEnum moodEnum,
  }) {
    double totalPercentage = percentageGreat + percentageFine + percentageNeutral + percentageUpset + percentageAngry;

    double difference = totalPercentage - 100;
    double adjustedPercentage;
    double adjustedTotalPercentage = 100;
    int moodCount = selectedMoods.length;

    switch (moodEnum) {
      case HappinessIndexMoodEnum.great:
        {
          if (difference < 0) {
            adjustedPercentage = percentageGreat + (difference.abs()) / moodCount;
          } else if (difference > 0) {
            adjustedPercentage = percentageGreat - difference.abs() / moodCount;
          } else {
            adjustedPercentage = percentageGreat;
          }

          break;
        }
      case HappinessIndexMoodEnum.fine:
        {
          if (difference < 0) {
            adjustedPercentage = percentageFine + (difference.abs()) / moodCount;
          } else if (difference > 0) {
            adjustedPercentage = percentageFine - difference.abs() / moodCount;
          } else {
            adjustedPercentage = percentageFine;
          }

          break;
        }
      case HappinessIndexMoodEnum.neutral:
        {
          if (difference < 0) {
            adjustedPercentage = percentageNeutral + (difference.abs()) / moodCount;
          } else if (difference > 0) {
            adjustedPercentage = percentageNeutral - difference.abs() / moodCount;
          } else {
            adjustedPercentage = percentageNeutral;
          }

          break;
        }
      case HappinessIndexMoodEnum.upset:
        if (difference < 0) {
          adjustedPercentage = percentageUpset + (difference.abs()) / moodCount;
        } else if (difference > 0) {
          adjustedPercentage = percentageUpset - difference.abs() / moodCount;
        } else {
          adjustedPercentage = percentageUpset;
        }

        break;
      case HappinessIndexMoodEnum.angry:
        if (difference < 0) {
          adjustedPercentage = percentageAngry + (difference.abs()) / moodCount;
        } else if (difference > 0) {
          adjustedPercentage = percentageAngry - difference.abs() / moodCount;
        } else {
          adjustedPercentage = percentageAngry;
        }
    }

    return screenWidthWithoutPadding * (adjustedPercentage / adjustedTotalPercentage);
  }
}
