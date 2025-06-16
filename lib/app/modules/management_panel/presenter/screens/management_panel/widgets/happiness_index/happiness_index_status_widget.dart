import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senior_design_tokens/tokens/senior_colors.dart';

import '../../../../../../happiness_index/enums/happiness_index_mood_enum.dart';
import '../../../../../../happiness_index/presenter/blocs/happiness_index/happiness_index_bloc.dart';
import '../../../../../../happiness_index/presenter/blocs/happiness_index/happiness_index_state.dart';

class HappinessIndexStatusWidget extends StatelessWidget {
  static const double _containerSize = 12.0;
  static const double _borderRadius = _containerSize * 0.5;

  final HappinessIndexBloc _happinessIndexBloc;

  const HappinessIndexStatusWidget({
    Key? key,
    required HappinessIndexBloc happinessIndexBloc,
  })  : _happinessIndexBloc = happinessIndexBloc,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HappinessIndexBloc, HappinessIndexState>(
      bloc: _happinessIndexBloc,
      builder: (_, state) {
        if (state is LoadedHappinessIndexState) {
          return Container(
            height: _containerSize,
            width: _containerSize,
            decoration: BoxDecoration(
              color: _getSelectedColorOfTheMood(
                mood: state.happinessIndexMood.happinessIndexMood,
              ),
              borderRadius: BorderRadius.circular(_borderRadius),
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Color _getSelectedColorOfTheMood({
    required HappinessIndexMoodEnum mood,
  }) {
    switch (mood) {
      case HappinessIndexMoodEnum.great:
        return SeniorColors.manchesterColorGreen200;
      case HappinessIndexMoodEnum.fine:
        return SeniorColors.manchesterColorBlue200;
      case HappinessIndexMoodEnum.upset:
        return SeniorColors.manchesterColorOrange200;
      case HappinessIndexMoodEnum.angry:
        return SeniorColors.manchesterColorRed200;
      case HappinessIndexMoodEnum.neutral:
        return SeniorColors.grayscale40;
    }
  }
}
