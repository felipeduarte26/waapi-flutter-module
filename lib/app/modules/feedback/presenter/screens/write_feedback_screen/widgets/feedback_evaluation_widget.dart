import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../domain/entities/proficiency_feedback_entity.dart';
import '../../../blocs/proficiency_list_bloc/proficiency_list_bloc.dart';
import '../../../blocs/proficiency_list_bloc/proficiency_list_event.dart';
import '../../../blocs/proficiency_list_bloc/proficiency_list_state.dart';
import '../../../widgets/proficiency_selector_widget.dart';

class FeedbackEvaluationWidget extends StatefulWidget {
  final Function(double) onRatingUpdate;
  final Function(ProficiencyFeedbackEntity) onSelectProficiency;
  final double initialRating;
  final bool disabled;
  final ProficiencyListBloc proficiencyListBloc;

  const FeedbackEvaluationWidget({
    Key? key,
    required this.onRatingUpdate,
    required this.onSelectProficiency,
    required this.initialRating,
    required this.proficiencyListBloc,
    this.disabled = false,
  }) : super(key: key);

  @override
  State<FeedbackEvaluationWidget> createState() {
    return _FeedbackEvaluationWidgetState();
  }
}

class _FeedbackEvaluationWidgetState extends State<FeedbackEvaluationWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProficiencyListBloc, ProficiencyListState>(
      bloc: widget.proficiencyListBloc,
      builder: (context, state) {
        if (state is EmptyProficiencyListState) {
          return Center(
            child: SeniorRating(
              itemCount: 5,
              disabled: widget.disabled,
              initialRating: widget.initialRating,
              itemSize: SeniorSpacing.big,
              itemPadding: const EdgeInsets.symmetric(
                horizontal: SeniorSpacing.normal,
              ),
              onRatingUpdate: (starCount) {
                widget.onRatingUpdate(starCount);
                widget.proficiencyListBloc.add(SelectedStarCountFeedbackEvent());
              },
            ),
          );
        }

        if (state is LoadedProficiencyListState) {
          return ProficiencySelectorWidget(
            disabled: widget.disabled,
            proficiencies: state.proficiencyList,
            onSelect: widget.onSelectProficiency,
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
