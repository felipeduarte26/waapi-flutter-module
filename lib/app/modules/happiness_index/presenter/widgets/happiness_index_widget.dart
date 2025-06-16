import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../core/enums/analytics/waapi_loading_size_enum.dart';
import '../../../../core/extension/media_query_extension.dart';
import '../../../../core/extension/translate_extension.dart';
import '../../../../core/helper/locale_helper.dart';

import '../../../../core/widgets/state_card_widget.dart';
import '../../../../core/widgets/waapi_loading_widget.dart';
import '../../../../routes/happiness_index_routes.dart';
import '../../domain/entities/happiness_index_mood_entity.dart';
import '../../enums/happiness_index_mood_enum.dart';
import '../blocs/happiness_index/happiness_index_bloc.dart';
import '../blocs/happiness_index/happiness_index_event.dart';
import '../blocs/happiness_index/happiness_index_state.dart';
import 'happiness_index_card_widget.dart';
import 'happiness_index_mood_widget.dart';
import 'select_mood/happiness_index_select_mood_bottom_sheet_widget.dart';

class HappinessIndexWidget extends StatefulWidget {
  final String employeeId;
  final bool disabled;
  final VoidCallback? onRefresh;

  const HappinessIndexWidget({
    Key? key,
    required this.employeeId,
    required this.disabled,
    this.onRefresh,
  }) : super(key: key);

  @override
  State<HappinessIndexWidget> createState() {
    return _HappinessIndexWidgetState();
  }
}

class _HappinessIndexWidgetState extends State<HappinessIndexWidget> {
  late HappinessIndexBloc _happinessIndexBloc;

  @override
  void initState() {
    super.initState();
    _happinessIndexBloc = Modular.get<HappinessIndexBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HappinessIndexBloc, HappinessIndexState>(
      bloc: _happinessIndexBloc,
      listener: (context, state) {
        if (state is LoadedHappinessIndexState) {
          widget.onRefresh?.call();
        }
      },
      builder: (_, state) {
        HappinessIndexMoodEntity? selectedMood;

        if (state is EmptyHappinessIndexState) {
          selectedMood = null;
        }

        if (state is LoadedHappinessIndexState) {
          selectedMood = state.happinessIndexMood;

          return HappinessIndexCardWidget(
            disabled: widget.disabled,
            happinessIndexMoodEntity: selectedMood,
            onTap: () {
              if (widget.disabled) {
                return;
              }
              Modular.to.pushNamed(
                HappinessIndexRoutes.moodDetailsScreenInitialRoute,
                arguments: selectedMood,
              );
            },
          );
        }

        if (state is LoadingHappinessIndexState) {
          return const Center(
            key: Key('happiness_index_widget-loading_state'),
            child: WaapiLoadingWidget(
              waapiLoadingSizeEnum: WaapiLoadingSizeEnum.small,
            ),
          );
        }

        if (state is HappinessIndexIsNotEnabledState) {
          return const SizedBox.shrink();
        }

        if (state is ErrorOnGetHappinessIndexState) {
          return StateCardWidget(
            key: const Key('happiness_index_widget-error_state-card'),
            message: state.message ?? context.translate.errorOnGetHappinessIndex,
            textButton: context.translate.tryAgain,
            onTap: () => _happinessIndexBloc.add(
              GetCurrentHappinessIndexEvent(
                language: LocaleHelper.languageAndCountryCode(
                  locale: Localizations.localeOf(context),
                ),
              ),
            ),
            showButton: true,
            iconData: FontAwesomeIcons.solidTriangleExclamation,
            disabled: widget.disabled,
          );
        }

        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: SeniorSpacing.normal,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final mood in HappinessIndexMoodEnum.values)
                HappinessIndexMoodWidget(
                  mood: mood,
                  isSelected: selectedMood != null && selectedMood.happinessIndexMood == mood,
                  isDefined: selectedMood != null,
                  onSelectedMood: (selectedMood) => _happinessIndexSelect(
                    context,
                    selectedMood,
                    widget.disabled,
                  ),
                  disabled: widget.disabled,
                ),
            ],
          ),
        );
      },
    );
  }
}

void _happinessIndexSelect(
  BuildContext context,
  HappinessIndexMoodEnum selectedMood,
  bool disabled,
) {
  if (disabled) {
    return;
  }
  SeniorBottomSheet.showBottomSheet(
    context: context,
    content: [
      HappinessIndexSelectMoodBottomSheetWidget(
        selectedMood: selectedMood,
      ),
    ],
    height: context.bottomSheetSize,
    hasCloseButton: true,
    onTapCloseButton: () {
      Modular.to.pop();
    },
  );
}

Color getSelectedBoxColorOfTheMood({
  required HappinessIndexMoodEnum mood,
}) {
  switch (mood) {
    case HappinessIndexMoodEnum.great:
      return SeniorColors.manchesterColorGreen400;
    case HappinessIndexMoodEnum.fine:
      return SeniorColors.manchesterColorBlue400;
    case HappinessIndexMoodEnum.upset:
      return SeniorColors.manchesterColorOrange400;
    case HappinessIndexMoodEnum.angry:
      return SeniorColors.manchesterColorRed400;
    case HappinessIndexMoodEnum.neutral:
      return SeniorColors.grayscale40;
  }
}
