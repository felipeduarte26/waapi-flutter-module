import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../core/extension/media_query_extension.dart';
import '../../../../../core/extension/translate_extension.dart';
import '../../../../../core/helper/enum_helper.dart';
import '../../../../../core/theme/waapi_style_theme.dart';
import '../../../../../core/widgets/waapi_colorful_header.dart';
import '../../../../../core/widgets/waapi_loading_widget.dart';
import '../../../../../routes/app_routes.dart';
import '../../../../ia_assist/presenter/bloc/ia_assist_bloc/ia_assist_bloc.dart';
import '../../../../ia_assist/presenter/bloc/ia_assist_bloc/ia_assist_event.dart';
import '../../../../ia_assist/presenter/bloc/ia_assist_bloc/ia_assist_state.dart';
import '../../../domain/entities/employee_entity.dart';
import '../../../domain/entities/feedback_request_entity.dart';
import '../../../domain/entities/proficiency_feedback_entity.dart';
import '../../../domain/entities/skill_feedback_entity.dart';
import '../../../enums/feedback_analytics_type_enum.dart';
import '../../../enums/feedback_suggestion_tone_enum.dart';
import '../../../enums/feedback_suggestion_type_enum.dart';
import '../../../enums/feedback_visibility_enum.dart';
import '../../blocs/proficiency_list_bloc/proficiency_list_event.dart';
import '../../blocs/proficiency_list_bloc/proficiency_list_state.dart';
import '../../blocs/search_competences_bloc/search_competences_event.dart';
import '../../blocs/search_competences_bloc/search_competences_state.dart';
import '../../blocs/search_employee_bloc/search_employee_event.dart';
import '../../blocs/search_employee_bloc/search_employee_state.dart';
import '../../blocs/send_feedback_bloc/send_feedback_bloc.dart';
import '../../blocs/send_feedback_bloc/send_feedback_event.dart';
import '../../blocs/send_feedback_bloc/send_feedback_state.dart';
import '../../widgets/feedback_selector_card_widget.dart';
import '../../widgets/select_employee_bottom_sheet_content_widget.dart';
import '../../widgets/select_employee_card_widget.dart';
import 'bloc/write_feedback_screen_bloc.dart';
import 'bloc/write_feedback_screen_state.dart';
import 'widgets/drop_down_share_view_widget.dart';
import 'widgets/feedback_context_bottom_sheet_content_widget.dart';
import 'widgets/feedback_evaluation_widget.dart';
import 'widgets/search_competences_bottom_sheet_content_widget.dart';
import 'widgets/selected_competences_card_widget.dart';

class WriteFeedbackScreen extends StatefulWidget {
  final FeedbackRequestEntity? feedbackRequestEntity;
  final String? personId;
  final FeedbackAnalyticsTypeEnum feedbackAnalyticsTypeEnum;

  const WriteFeedbackScreen({
    super.key,
    this.feedbackRequestEntity,
    this.personId,
    this.feedbackAnalyticsTypeEnum = FeedbackAnalyticsTypeEnum.organic,
  });

  @override
  State<WriteFeedbackScreen> createState() {
    return _WriteFeedbackScreenState();
  }
}

class _WriteFeedbackScreenState extends State<WriteFeedbackScreen> {
  late WriteFeedbackScreenBloc writeFeedbackScreenBloc;
  var starCount = 0.0;
  var feedBackMessage = '';
  var toUserName = '';
  var toName = '';
  var skills = <SkillFeedbackEntity>[];
  ProficiencyFeedbackEntity? proficiency;
  FeedbackVisibilityEnum? feedbackVisibility;
  final TextEditingController feedbackMessageController = TextEditingController();
  final TextEditingController behaviorTextFieldController = TextEditingController();
  final TextEditingController impactTextFieldController = TextEditingController();
  final TextEditingController improvementTextFieldController = TextEditingController();
  final TextEditingController feedbackTypeTextFieldController = TextEditingController();
  final TextEditingController toneTextFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();
    writeFeedbackScreenBloc = Modular.get<WriteFeedbackScreenBloc>();
    writeFeedbackScreenBloc.proficiencyListBloc.add(ProficiencyListToWriteFeedbackEvent());

    _configureSelectedEmployee();
  }

  @override
  void dispose() {
    feedbackTypeTextFieldController.dispose();
    behaviorTextFieldController.dispose();
    impactTextFieldController.dispose();
    improvementTextFieldController.dispose();
    toneTextFieldController.dispose();
    feedbackMessageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //TODO: Break it down into smaller listeners MultiBlocListener
    return BlocConsumer<WriteFeedbackScreenBloc, WriteFeedbackScreenState>(
      bloc: writeFeedbackScreenBloc,
      listener: (_, state) async {
        if (state.searchEmployeeState is LoadedSelectEmployeeState) {
          toUserName = state.searchEmployeeState.selectedEmployeeEntity!.username;
          toName = state.searchEmployeeState.selectedEmployeeEntity!.name;
        }

        if (state.searchEmployeeState is InitialSearchEmployeeState) {
          toUserName = '';
          toName = '';
          behaviorTextFieldController.text = '';
          impactTextFieldController.text = '';
          feedbackMessageController.text = '';
          feedbackTypeTextFieldController.text = EnumHelper().enumToString(
            enumToParse: FeedbackSuggestionTypeEnum.recognition,
          );
          toneTextFieldController.text = EnumHelper().enumToString(
            enumToParse: FeedbackSuggestionToneEnum.motivating,
          );
        }

        skills = state.searchCompetencesState is LoadedSearchCompetencesState
            ? state.searchCompetencesState.competencesSelected
            : [];

        if (state.sendFeedbackState is LoadedSendFeedbackState) {
          await Modular.to.popAndPushNamed(
            AppRoutes.successAnimationScreen,
            arguments: {
              'title': context.translate.feedbackSubmitted,
              'subTitle': context.translate.withSuccess,
            },
            result: state.sendFeedbackState.sentFeedbackIdEntity,
          );
          Future.delayed(const Duration(seconds: 3));
        }

        if (state.sendFeedbackState is ErrorSendFeedbackState) {
          if (!context.mounted) return;
          _showDialogError(
            context: context,
            sendFeedbackBloc: writeFeedbackScreenBloc.sendFeedbackBloc,
          );
        }

        if (state.proficiencyListState is ErrorProficiencyListState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SeniorSnackBar.error(
                message: context.translate.errorToOpenFormWriteFeedback,
              ),
            );
            Modular.to.pop();
          });
        }
      },
      builder: (context, state) {
        var searchCompetencesBloc = writeFeedbackScreenBloc.searchCompetencesBloc;
        var searchEmployeeBloc = writeFeedbackScreenBloc.searchEmployeeBloc;

        return PopScope(
          key: const Key('feedback-write_feedback_screen-will_pop_scope-leave_screen'),
          onPopInvokedWithResult: (_, __) async => state.sendFeedbackState is! LoadingSendFeedbackState,
          child: Scaffold(
            body: WaapiColorfulHeader(
              hasTopPadding: false,
              titleLabel: context.translate.writeFeedback,
              onTapBack: () {
                if (state.sendFeedbackState is! LoadingSendFeedbackState) {
                  Modular.to.pop();
                }
              },
              //TODO: Remove duplicated builder
              body: Builder(
                builder: (context) {
                  if (state.proficiencyListState is LoadingProficiencyListState) {
                    return const WaapiLoadingWidget(
                      key: Key('feedback-write_feedback_screen-loading_indicator'),
                    );
                  }

                  return Stack(
                    children: [
                      Scrollbar(
                        child: SingleChildScrollView(
                          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                          padding: const EdgeInsets.only(
                            bottom: SeniorSpacing.normal,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: SeniorRadius.huge,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: SeniorSpacing.normal,
                                ),
                                child: SelectEmployeeCardWidget(
                                  key: const Key('feedback-write_feedback_screen-card-employee_select'),
                                  onTapClearSelection: () {
                                    FocusManager.instance.primaryFocus?.unfocus();
                                    if (state.searchEmployeeState is! LoadingSearchEmployeeState &&
                                        widget.feedbackRequestEntity == null &&
                                        widget.personId == null &&
                                        state.sendFeedbackState is! LoadingSendFeedbackState) {
                                      searchEmployeeBloc.add(UnselectEmployeeFeedbackEvent());
                                    }
                                  },
                                  disabled: state.searchEmployeeState is LoadingSearchEmployeeState ||
                                      state.searchEmployeeState.selectedEmployeeEntity != null ||
                                      state.sendFeedbackState is LoadingSendFeedbackState,
                                  employeeEntity: searchEmployeeBloc.state.selectedEmployeeEntity,
                                  visibleCloseButton: widget.feedbackRequestEntity == null && widget.personId == null,
                                  onTap: () {
                                    FocusManager.instance.primaryFocus?.unfocus();
                                    _selectEmployee(context);
                                  },
                                  descriptionLabel: context.translate.writeSelectEmployeeDescription,
                                  descriptionLabelCoworker: context.translate.sendingFeedbackTo,
                                ),
                              ),
                              const SizedBox(
                                height: SeniorSpacing.normal,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: SeniorSpacing.normal,
                                ),
                                child: SeniorText.label(
                                  context.translate.rateThisFeedback,
                                  key: const Key('feedback-write_feedback_screen-text-rate_this_feedback'),
                                  textProperties: const TextProperties(
                                    textAlign: TextAlign.left,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: SeniorSpacing.normal,
                              ),
                              FeedbackEvaluationWidget(
                                disabled: state.sendFeedbackState is LoadingSendFeedbackState,
                                key: const Key('feedback-write_feedback_screen-buttons-feedback_evaluation'),
                                initialRating: starCount,
                                onRatingUpdate: (value) {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  starCount = value;
                                },
                                onSelectProficiency: (proficiency) {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  this.proficiency = proficiency;
                                  //TODO: This is a workaround to update the screen when the proficiency is selected
                                  _updateScreen();
                                },
                                proficiencyListBloc: writeFeedbackScreenBloc.proficiencyListBloc,
                              ),
                              const SizedBox(
                                height: SeniorSpacing.normal,
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: SeniorSpacing.normal,
                                    ),
                                    child: SeniorText.label(
                                      context.translate.whatDoYouHaveToSayTitle,
                                      key: const Key('feedback-write_feedback_screen-text-what_do_you_have_to_say'),
                                      textProperties: const TextProperties(
                                        textAlign: TextAlign.left,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: SeniorSpacing.normal,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: SeniorSpacing.normal,
                                ),
                                child: BlocBuilder<IAAssistBloc, IAAssistState>(
                                  bloc: writeFeedbackScreenBloc.iaAssistBloc,
                                  builder: (context, iaAssistState) {
                                    if (iaAssistState is LoadedIAAssistState) {
                                      feedBackMessage = iaAssistState.text;
                                      feedbackMessageController.text = iaAssistState.text;
                                    }
                                    return SeniorTextField(
                                      key:
                                          const Key('feedback-write_feedback_screen-text_field-input_feedback_message'),
                                      counterText: context.translate.characters,
                                      showCounterText: true,
                                      label: context.translate.feedBackMessageLabel,
                                      hintText: context.translate.feedBackMessageExample,
                                      maxLines: 6,
                                      maxLength: 4000,
                                      disabled: state.sendFeedbackState is LoadingSendFeedbackState ||
                                          state.iaAssistState is LoadingIAAssistState,
                                      onChanged: (feedBackMessage) {
                                        //TODO: This is a workaround to update the screen when the proficiency is selected
                                        if (this.feedBackMessage.isEmpty && feedBackMessage.isNotEmpty) {
                                          writeFeedbackScreenBloc.iaAssistBloc.add(InitialIAAssistEvent());
                                          _updateScreen();
                                        }

                                        this.feedBackMessage = feedBackMessage;

                                        //TODO: This is a workaround to update the screen when the proficiency is selected
                                        if (feedBackMessage.isEmpty) {
                                          writeFeedbackScreenBloc.iaAssistBloc.add(InitialIAAssistEvent());
                                          _updateScreen();
                                        }
                                      },
                                      controller: feedbackMessageController,
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: SeniorSpacing.normal,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: SeniorSpacing.normal,
                                ),
                                child: SeniorButton(
                                  label: context.translate.generateFeedbackSuggestion,
                                  onPressed: () {
                                    _feedbackContext(context, writeFeedbackScreenBloc.iaAssistBloc);
                                  },
                                  outlined: true,
                                  style: WaapiStyleTheme.waapiSeniorButtonGhostOutlinedStyle(context),
                                  fullWidth: true,
                                  disabled: toUserName.isEmpty,
                                ),
                              ),
                              const SizedBox(
                                height: SeniorSpacing.normal,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: SeniorSpacing.normal,
                                ),
                                child: Offstage(
                                  offstage: state.searchCompetencesState.competencesSelected.isNotEmpty,
                                  child: FeedbackSelectorCardWidget(
                                    key: const Key('feedback-write_feedback_screen-card-feedback_selector'),
                                    onTap: () {
                                      FocusManager.instance.primaryFocus?.unfocus();
                                      if (state.sendFeedbackState is! LoadingSendFeedbackState) {
                                        _selectCompetences(context);
                                      }
                                    },
                                    title: Container(
                                      margin: const EdgeInsets.only(
                                        bottom: SeniorSpacing.xsmall,
                                      ),
                                      child: SeniorText.label(
                                        context.translate.selectSkills,
                                        color: SeniorColors.neutralColor700,
                                        textProperties: const TextProperties(
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                    content: SeniorText.small(
                                      context.translate.selectSkillsToFeedback,
                                      color: SeniorColors.neutralColor700,
                                      textProperties: const TextProperties(
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    icon: SeniorIcon(
                                      icon: FontAwesomeIcons.solidSplotch,
                                      size: IconTheme.of(context).size!,
                                    ),
                                  ),
                                ),
                              ),
                              state.searchCompetencesState.competencesSelected.isNotEmpty
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: SeniorSpacing.small,
                                      ),
                                      child: SelectedCompetencesCardWidget(
                                        key: const Key('feedback-write_feedback_screen-card-selected_competences'),
                                        onPressed: state.sendFeedbackState is LoadingSendFeedbackState
                                            ? null
                                            : () {
                                                FocusManager.instance.primaryFocus?.unfocus();
                                                searchCompetencesBloc.add(ClearCompetencesSelectedListEvent());
                                              },
                                        competences: state.searchCompetencesState.competencesSelected,
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                              const SizedBox(
                                height: SeniorSpacing.normal,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: SeniorSpacing.normal,
                                ),
                                child: DropDownShareViewWidget(
                                  key: const Key('feedback-write_feedback_screen-drop_down_share_view_widget'),
                                  selectedItem: feedbackVisibility,
                                  onChanged: (visibility) {
                                    FocusManager.instance.primaryFocus?.unfocus();
                                    feedbackVisibility = visibility;
                                  },
                                  disabled: state.sendFeedbackState is LoadingSendFeedbackState ||
                                      state.sendFeedbackState is LoadingSendFeedbackState,
                                  authorizationBloc: writeFeedbackScreenBloc.authorizationBloc,
                                ),
                              ),
                              const SizedBox(
                                height: SeniorSpacing.small,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: SeniorSpacing.normal,
                                ),
                                child: SeniorText.small(
                                  context.translate.feedbackConsentMessage,
                                  textProperties: const TextProperties(
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: SeniorSpacing.small,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: SeniorSpacing.normal,
                                ),
                                child: SeniorButton(
                                  key: const Key('feedback-write_feedback_screen-button-send_feedback'),
                                  fullWidth: true,
                                  label: context.translate.sendFeedBackTextButton,
                                  disabled: isDisabled(),
                                  busy: state.sendFeedbackState is LoadingSendFeedbackState,
                                  onPressed: () {
                                    FocusManager.instance.primaryFocus?.unfocus();
                                    writeFeedbackScreenBloc.sendFeedbackBloc.add(
                                      SendWrittenFeedbackEvent(
                                        message: feedBackMessage,
                                        when: DateTime.now().toUtc(),
                                        toUserName: toUserName,
                                        visibility: feedbackVisibility!,
                                        skills: skills,
                                        starCount: starCount.toInt(),
                                        proficiency: proficiency,
                                        requestId: widget.feedbackRequestEntity?.id ?? '',
                                        feedbackAnalyticsTypeEnum: widget.feedbackAnalyticsTypeEnum,
                                      ),
                                    );
                                  },
                                ),
                              ),
                              SizedBox(
                                height: SeniorSpacing.small + context.bottomSize,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  void _configureSelectedEmployee() {
    final receivedFeedbackEntity = widget.feedbackRequestEntity;

    EmployeeEntity? employeeEntity;

    if (receivedFeedbackEntity != null) {
      employeeEntity = EmployeeEntity(
        id: receivedFeedbackEntity.fromPersonId,
        name: receivedFeedbackEntity.nameFrom,
        username: receivedFeedbackEntity.fromUsername,
        nickname: '',
        photoUrl: receivedFeedbackEntity.photoLinkFrom,
      );
    }

    if (employeeEntity != null) {
      writeFeedbackScreenBloc.searchEmployeeBloc.add(
        SelectEmployeeFromEntityToWriteFeedbackEvent(
          employeeEntity: employeeEntity,
        ),
      );
    }
  }

  bool isDisabled() {
    return toUserName.trim().isEmpty ||
        (proficiency == null && starCount == 0) ||
        feedBackMessage.isEmpty ||
        feedbackVisibility == null ||
        writeFeedbackScreenBloc.state.sendFeedbackState is LoadingSendFeedbackState;
  }

  void _updateScreen() {
    setState(() {});
  }

  void _selectEmployee(BuildContext context) {
    SeniorBottomSheet.showBottomSheet(
      title: context.translate.writeFeedbackSearchEmployeeIntro,
      context: context,
      height: context.bottomSheetSize,
      content: [
        Expanded(
          child: SelectEmployeeBottomSheetContentWidget(
            key: const Key('feedback-write_feedback_screen-select_employee_bottom_sheet_content_widget'),
            searchEmployeeBloc: writeFeedbackScreenBloc.searchEmployeeBloc,
            initialTitle: context.translate.writeFeedbackSearchEmployee,
            initialSubtitle: context.translate.writeFeedbackSearchEmployeeDescription,
            noFoundTitle: context.translate.noPersonFound,
            noFoundSubtitle: context.translate.noPersonFoundToFeedbackDescription,
          ),
        ),
      ],
      hasCloseButton: true,
      onTapCloseButton: () {
        writeFeedbackScreenBloc.searchEmployeeBloc.add(ClearSearchEmployeeFeedbackEvent());
        Modular.to.pop();
      },
    );
  }

  void _selectCompetences(BuildContext context) {
    final themeRepository = Provider.of<ThemeRepository>(context, listen: false);
    SeniorBottomSheet.showBottomSheet(
      style: themeRepository.theme.bottomSheetTheme?.style?.copyWith(
        backgroundColor: themeRepository.theme.backdropTheme!.style!.bodyColor,
      ),
      title: context.translate.searchAndSelectSkillsToFeedback,
      height: context.bottomSheetSize,
      context: context,
      hasCloseButton: true,
      onTapCloseButton: Modular.to.pop,
      content: <Widget>[
        Expanded(
          child: SearchCompetencesBottomSheetContentWidget(
            key: const Key('feedback-write_feedback_screen-select_competences_bottom_sheet_content_widget'),
            searchCompetencesBloc: writeFeedbackScreenBloc.searchCompetencesBloc,
          ),
        ),
      ],
    );
  }

  void _feedbackContext(BuildContext context, IAAssistBloc iaAssistBloc) {
    SeniorBottomSheet.showBottomSheet(
      style: SeniorBottomSheetStyle(
        backgroundColor: Provider.of<ThemeRepository>(context, listen: false).theme.backdropTheme!.style!.bodyColor,
      ),
      title: context.translate.feedbackSuggestion,
      height: context.bottomSheetSize,
      context: context,
      hasCloseButton: true,
      onTapCloseButton: Modular.to.pop,
      titlePadding: const EdgeInsets.symmetric(
        horizontal: SeniorSpacing.normal,
      ),
      content: <Widget>[
        Expanded(
          child: FeedbackContextBottomSheetContentWidget(
            key: const Key('feedback-write_feedback_screen-select_competences_bottom_sheet_content_widget'),
            iaAssistBloc: iaAssistBloc,
            name: toName.split(' ').first,
            behaviorTextFieldController: behaviorTextFieldController,
            impactTextFieldController: impactTextFieldController,
            feedbackTypeTextFieldController: feedbackTypeTextFieldController,
            improvementTextFieldController: improvementTextFieldController,
            toneTextFieldController: toneTextFieldController,
          ),
        ),
      ],
    );
  }

  void _showDialogError({
    required BuildContext context,
    required SendFeedbackBloc sendFeedbackBloc,
  }) {
    showDialog(
      barrierDismissible: false,
      useRootNavigator: true,
      context: context,
      builder: (context) {
        return SeniorModal(
          title: context.translate.genericError,
          content: context.translate.errorSendFeedbackDescription,
          defaultAction: SeniorModalAction(
            label: context.translate.optionCancel,
            action: Modular.to.pop,
          ),
          otherAction: SeniorModalAction(
            label: context.translate.tryAgain,
            action: () {
              Modular.to.pop();
              sendFeedbackBloc.add(
                SendWrittenFeedbackEvent(
                  message: feedBackMessage,
                  when: DateTime.now(),
                  toUserName: toUserName,
                  visibility: feedbackVisibility!,
                  skills: skills,
                  starCount: starCount.toInt(),
                  proficiency: proficiency,
                  requestId: widget.feedbackRequestEntity?.id ?? '',
                  feedbackAnalyticsTypeEnum: widget.feedbackAnalyticsTypeEnum,
                ),
              );
            },
          ),
        );
      },
    );
  }
}
