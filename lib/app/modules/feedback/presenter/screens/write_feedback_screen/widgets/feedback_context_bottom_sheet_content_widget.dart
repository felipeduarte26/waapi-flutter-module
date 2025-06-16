import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../core/extension/translate_extension.dart';
import '../../../../../../core/helper/enum_helper.dart';
import '../../../../../../core/widgets/employee_bottom_sheet_widget.dart';
import '../../../../../ia_assist/presenter/bloc/ia_assist_bloc/ia_assist_bloc.dart';
import '../../../../../ia_assist/presenter/bloc/ia_assist_bloc/ia_assist_event.dart';
import '../../../../enums/feedback_suggestion_tone_enum.dart';
import '../../../../enums/feedback_suggestion_type_enum.dart';

class FeedbackContextBottomSheetContentWidget extends StatefulWidget {
  final IAAssistBloc iaAssistBloc;
  final String name;
  final TextEditingController behaviorTextFieldController;
  final TextEditingController impactTextFieldController;
  final TextEditingController feedbackTypeTextFieldController;
  final TextEditingController improvementTextFieldController;
  final TextEditingController toneTextFieldController;

  const FeedbackContextBottomSheetContentWidget({
    super.key,
    required this.iaAssistBloc,
    required this.name,
    required this.behaviorTextFieldController,
    required this.impactTextFieldController,
    required this.feedbackTypeTextFieldController,
    required this.improvementTextFieldController,
    required this.toneTextFieldController,
  });

  @override
  State<FeedbackContextBottomSheetContentWidget> createState() => _FeedbackContextBottomSheetContentWidgetState();
}

class _FeedbackContextBottomSheetContentWidgetState extends State<FeedbackContextBottomSheetContentWidget> {
  @override
  void initState() {
    super.initState();
    widget.behaviorTextFieldController.addListener(_textFieldListener);
    widget.impactTextFieldController.addListener(_textFieldListener);
    widget.feedbackTypeTextFieldController.addListener(_textFieldListener);
    widget.improvementTextFieldController.addListener(_textFieldListener);
    widget.toneTextFieldController.addListener(_textFieldListener);
  }

  @override
  void dispose() {
    super.dispose();
    widget.feedbackTypeTextFieldController.removeListener(_textFieldListener);
    widget.behaviorTextFieldController.removeListener(_textFieldListener);
    widget.impactTextFieldController.removeListener(_textFieldListener);
    widget.improvementTextFieldController.removeListener(_textFieldListener);
    widget.toneTextFieldController.removeListener(_textFieldListener);
  }

  void _textFieldListener() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Provider.of<ThemeRepository>(context, listen: false).theme.backdropTheme!.style!.bodyColor,
      body: Padding(
        padding: const EdgeInsets.only(
          top: SeniorSpacing.normal,
        ),
        child: Scrollbar(
          child: CustomScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            slivers: [
              SliverToBoxAdapter(
                child: SeniorText.label(
                  context.translate.feedbackSuggestionIAssistHelper,
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(top: SeniorSpacing.normal),
                  child: SeniorText.labelBold(context.translate.feedbackSuggestionFeedbackType),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: SeniorSpacing.xxxsmall,
                  ),
                  child: Wrap(
                    children: [
                      SeniorRadioButton(
                        groupValue: widget.feedbackTypeTextFieldController.text ==
                            EnumHelper().enumToString(enumToParse: FeedbackSuggestionTypeEnum.recognition),
                        onChanged: (_) {
                          widget.feedbackTypeTextFieldController.text =
                              EnumHelper().enumToString(enumToParse: FeedbackSuggestionTypeEnum.recognition);
                          setState(() {});
                        },
                        title: FeedbackSuggestionTypeEnum.recognition.text(context.translate),
                        value: true,
                      ),
                      SeniorRadioButton(
                        groupValue: widget.feedbackTypeTextFieldController.text ==
                            EnumHelper().enumToString(enumToParse: FeedbackSuggestionTypeEnum.improvement),
                        onChanged: (_) {
                          widget.feedbackTypeTextFieldController.text =
                              EnumHelper().enumToString(enumToParse: FeedbackSuggestionTypeEnum.improvement);
                          setState(() {});
                        },
                        title: FeedbackSuggestionTypeEnum.improvement.text(context.translate),
                        value: true,
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SeniorTextField(
                  key: const Key('feedback-write_feedback_screen-senior_text_field-behavior'),
                  controller: widget.behaviorTextFieldController,
                  label: context.translate.feedbackBehavior,
                  helper: context.translate.feedbackBehaviorHelper,
                  style: SeniorTextFieldStyle(
                    textColor: Provider.of<ThemeRepository>(context).isDarkTheme() ? SeniorColors.pureWhite : null,
                  ),
                  textInputAction: TextInputAction.next,
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: SeniorSpacing.xsmall,
                ),
              ),
              SliverToBoxAdapter(
                child: SeniorTextField(
                  key: const Key('feedback-write_feedback_screen-senior_text_field-impact'),
                  controller: widget.impactTextFieldController,
                  label: context.translate.feedbackImpact,
                  helper: context.translate.feedbackImpactHelper,
                  style: SeniorTextFieldStyle(
                    textColor: Provider.of<ThemeRepository>(context).isDarkTheme() ? SeniorColors.pureWhite : null,
                  ),
                  textInputAction: TextInputAction.next,
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: SeniorSpacing.xsmall,
                ),
              ),
              SliverToBoxAdapter(
                child: SeniorTextField(
                  key: const Key('feedback-write_feedback_screen-senior_text_field-improvement'),
                  controller: widget.improvementTextFieldController,
                  label: context.translate.feedbackImprovement,
                  helper: context.translate.feedbackImprovementHelper,
                  style: SeniorTextFieldStyle(
                    textColor: Provider.of<ThemeRepository>(context).isDarkTheme() ? SeniorColors.pureWhite : null,
                  ),
                  textInputAction: TextInputAction.done,
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: SeniorSpacing.xsmall,
                ),
              ),
              SliverToBoxAdapter(
                child: SeniorText.labelBold(context.translate.feedbackSuggestionTone),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: SeniorSpacing.xxxsmall,
                  ),
                  child: Wrap(
                    children: [
                      SeniorRadioButton(
                        groupValue: _selectedFeedbackSuggestionTone(FeedbackSuggestionToneEnum.motivating),
                        onChanged: (_) => _updateFeedbackSuggestionTone(FeedbackSuggestionToneEnum.motivating),
                        title: FeedbackSuggestionToneEnum.motivating.text(context.translate),
                        value: true,
                      ),
                      SeniorRadioButton(
                        groupValue: _selectedFeedbackSuggestionTone(FeedbackSuggestionToneEnum.professional),
                        onChanged: (_) => _updateFeedbackSuggestionTone(FeedbackSuggestionToneEnum.professional),
                        title: FeedbackSuggestionToneEnum.professional.text(context.translate),
                        value: true,
                      ),
                      SeniorRadioButton(
                        groupValue: _selectedFeedbackSuggestionTone(FeedbackSuggestionToneEnum.balanced),
                        onChanged: (_) => _updateFeedbackSuggestionTone(FeedbackSuggestionToneEnum.balanced),
                        title: FeedbackSuggestionToneEnum.balanced.text(context.translate),
                        value: true,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: EmployeeBottomSheetWidget(
        horizontalPadding: false,
        key: const Key('feedback-write_feedback_screen-feedback_context_bottom_sheet'),
        seniorButtons: [
          Padding(
            padding: const EdgeInsets.only(
              top: SeniorSpacing.normal,
            ),
            child: SeniorButton(
              key: const Key('feedback-write_feedback_screen-feedback_context_bottom_sheet-button-generate'),
              fullWidth: true,
              label: context.translate.generateFeedback,
              disabled: widget.behaviorTextFieldController.text.isEmpty ||
                  widget.impactTextFieldController.text.isEmpty ||
                  widget.toneTextFieldController.text.isEmpty ||
                  widget.feedbackTypeTextFieldController.text.isEmpty,
              onPressed: () {
                const openAIDefinedTemperature = 0.7;
                final feedbackTypeText = EnumHelper<FeedbackSuggestionTypeEnum>()
                    .stringToEnum(
                      stringToParse: widget.feedbackTypeTextFieldController.text,
                      values: FeedbackSuggestionTypeEnum.values,
                    )
                    ?.text(context.translate);
                final feedbackToneText = EnumHelper<FeedbackSuggestionToneEnum>()
                    .stringToEnum(
                      stringToParse: widget.toneTextFieldController.text,
                      values: FeedbackSuggestionToneEnum.values,
                    )
                    ?.text(context.translate);
                final prompt = [
                  context.translate.feedbackSuggestionIassist,
                  '${context.translate.feedbackSuggestionEmployee} ${widget.name},',
                  '${context.translate.feedbackSuggestionFeedbackType} $feedbackTypeText',
                  '${context.translate.feedbackSuggestionBehavior} ${widget.behaviorTextFieldController.text}',
                  '${context.translate.feedbackSuggestionImpact} ${widget.impactTextFieldController.text}',
                  '${context.translate.feedbackSuggestionImprovement} ${widget.improvementTextFieldController.text}',
                  '${context.translate.feedbackSuggestionTone} $feedbackToneText.',
                  context.translate.feedbackSuggestionWithoutAssign,
                ].join(' ');

                widget.iaAssistBloc.add(
                  GenerateTextIAAssistEvent(
                    prompt: prompt,
                    temperature: openAIDefinedTemperature,
                  ),
                );
                Modular.to.pop();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: SeniorSpacing.normal,
              top: SeniorSpacing.normal,
            ),
            child: SeniorButton.ghost(
              key: const Key('feedback-write_feedback_screen-bottom_sheet-button-option_cancel'),
              fullWidth: true,
              label: context.translate.optionCancel,
              onPressed: () {
                Modular.to.pop();
              },
            ),
          ),
        ],
      ),
    );
  }

  void _updateFeedbackSuggestionTone(FeedbackSuggestionToneEnum tone) {
    widget.toneTextFieldController.text = EnumHelper().enumToString(enumToParse: tone);
    setState(() {});
  }

  bool _selectedFeedbackSuggestionTone(FeedbackSuggestionToneEnum tone) {
    return widget.toneTextFieldController.text == EnumHelper().enumToString(enumToParse: tone);
  }
}
