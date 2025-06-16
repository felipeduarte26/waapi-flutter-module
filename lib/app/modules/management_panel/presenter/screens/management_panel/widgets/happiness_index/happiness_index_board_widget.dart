import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';
import 'package:senior_design_tokens/tokens/senior_spacing.dart';

import '../../../../../../../core/extension/translate_extension.dart';
import '../../../../../../../core/widgets/icon_header_widget.dart';
import '../../../../../../happiness_index/presenter/blocs/happiness_index/happiness_index_bloc.dart';
import '../../../../../../happiness_index/presenter/blocs/happiness_index/happiness_index_state.dart';
import '../../../../../../happiness_index/presenter/widgets/happiness_index_widget.dart';
import 'happiness_index_information_widget.dart';

class HappinessIndexBoardWidget extends StatelessWidget {
  final String employeeId;

  final HappinessIndexBloc happinessIndexBloc;
  final bool disabled;

  const HappinessIndexBoardWidget({
    Key? key,
    required this.employeeId,
    required this.happinessIndexBloc,
    required this.disabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HappinessIndexBloc, HappinessIndexState>(
      bloc: happinessIndexBloc,
      builder: (context, state) {
        if (state is HappinessIndexIsNotEnabledState) {
          return const SizedBox.shrink();
        }
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconHeaderWidget(
              key: const Key('happiness_index-happiness_index_board'),
              removeBottomPadding: state is LoadedHappinessIndexState,
              title: state is LoadedHappinessIndexState
                  ? context.translate.yourMoodTodayWas
                  : context.translate.howsYourMoodToday,
              icon: FontAwesomeIcons.solidHandHoldingHeart,
              enableInfoButton: true,
              onInfoButtonPressed: () {
                _happinesIndexInformation(context);
              },
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: SeniorSpacing.normal,
              ),
              child: HappinessIndexWidget(
                employeeId: employeeId,
                disabled: disabled,
              ),
            ),
          ],
        );
      },
    );
  }

  void _happinesIndexInformation(BuildContext context) {
    SeniorBottomSheet.showDynamicBottomSheet(
      title: context.translate.moodDiary,
      context: context,
      content: [
        const HappinessIndexInformationWidget(),
      ],
      hasCloseButton: true,
      onTapCloseButton: () {
        Modular.to.pop();
      },
    );
  }
}
