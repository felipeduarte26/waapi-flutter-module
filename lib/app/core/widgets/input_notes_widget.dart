import 'package:flutter/material.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/tokens/senior_colors.dart';
import 'package:senior_design_tokens/tokens/senior_spacing.dart';

import '../extension/translate_extension.dart';

class InputNotesWidget extends StatefulWidget {
  final TextEditingController notesController;
  final bool trueInformation;
  final ValueChanged<bool?> onChangedTrueInformation;
  final bool disableCheckBox;

  const InputNotesWidget({
    Key? key,
    required this.notesController,
    required this.trueInformation,
    required this.onChangedTrueInformation,
    this.disableCheckBox = false,
  }) : super(key: key);

  @override
  State<InputNotesWidget> createState() {
    return _InputNotesWidgetState();
  }
}

class _InputNotesWidgetState extends State<InputNotesWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: SeniorSpacing.normal,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                bottom: SeniorSpacing.normal,
              ),
              child: SeniorText.h4(
                context.translate.additionalInfo,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: SeniorSpacing.normal,
              ),
              child: SeniorText.body(
                '* ${context.translate.mandatoryItem}',
                color: SeniorColors.neutralColor600,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: SeniorSpacing.normal,
              ),
              child: SeniorTextField(
                controller: widget.notesController,
                label: context.translate.notes,
                counterText: context.translate.characters,
                showCounterText: true,
                maxLength: 255,
                maxLines: 3,
                style: const SeniorTextFieldStyle(
                  hintTextColor: SeniorColors.neutralColor900,
                  textColor: SeniorColors.neutralColor700,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: SeniorSpacing.normal,
              ),
              child: SeniorCheckbox(
                disabled: widget.disableCheckBox,
                onChanged: widget.onChangedTrueInformation,
                actionOnTitle: true,
                value: widget.trueInformation,
                title: '${context.translate.trueInformation}*',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
