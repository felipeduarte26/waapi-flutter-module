import 'package:flutter/material.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../domain/entities/proficiency_feedback_entity.dart';
import 'proficiency_item_widget.dart';

class ProficiencySelectorWidget extends StatefulWidget {
  final List<ProficiencyFeedbackEntity> proficiencies;
  final ProficiencyFeedbackEntity? selectedProficiency;
  final Function(ProficiencyFeedbackEntity) onSelect;
  final bool disabled;

  const ProficiencySelectorWidget({
    Key? key,
    required this.proficiencies,
    required this.onSelect,
    this.selectedProficiency,
    this.disabled = false,
  }) : super(key: key);

  @override
  State<ProficiencySelectorWidget> createState() {
    return _ProficiencySelectorWidgetState();
  }
}

class _ProficiencySelectorWidgetState extends State<ProficiencySelectorWidget> {
  late ProficiencyFeedbackEntity? _selectedProficiency;

  @override
  void initState() {
    super.initState();
    _selectedProficiency = widget.selectedProficiency;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 37,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(
          vertical: SeniorSpacing.xxsmall,
          horizontal: SeniorSpacing.normal,
        ),
        itemBuilder: (_, index) {
          var isSelected = false;
          if (_selectedProficiency != null) {
            isSelected = widget.proficiencies[index].id == _selectedProficiency!.id;
          }

          return ProficiencyItemWidget(
            proficiency: widget.proficiencies[index],
            disabled: widget.disabled,
            onTap: (proficiency) {
              setState(() {
                _selectedProficiency = proficiency;
              });
              widget.onSelect(proficiency);
            },
            selected: isSelected,
          );
        },
        itemCount: widget.proficiencies.length,
        separatorBuilder: (_, __) => const SizedBox(
          width: SeniorSpacing.xsmall,
        ),
      ),
    );
  }
}
