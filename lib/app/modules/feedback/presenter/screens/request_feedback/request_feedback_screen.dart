import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../core/extension/media_query_extension.dart';
import '../../../../../core/extension/translate_extension.dart';
import '../../../../../core/widgets/waapi_colorful_header.dart';
import '../../../../../routes/app_routes.dart';
import '../../blocs/feedback_person_bloc/feedback_person_bloc.dart';
import '../../blocs/feedback_person_bloc/feedback_person_state.dart';
import '../../blocs/request_feedback_bloc/request_feedback_bloc.dart';
import '../../blocs/request_feedback_bloc/request_feedback_event.dart';
import '../../blocs/request_feedback_bloc/request_feedback_state.dart';
import '../../blocs/search_employee_bloc/search_employee_event.dart';
import '../../widgets/select_employee_bottom_sheet_content_widget.dart';
import '../../widgets/select_employee_card_widget.dart';
import 'bloc/request_feedback_screen_bloc.dart';
import 'bloc/request_feedback_screen_state.dart';

class RequestFeedbackScreen extends StatefulWidget {
  const RequestFeedbackScreen({super.key});

  @override
  State<RequestFeedbackScreen> createState() {
    return _RequestFeedbackScreenState();
  }
}

class _RequestFeedbackScreenState extends State<RequestFeedbackScreen> {
  final messageController = TextEditingController();
  late final RequestFeedbackScreenBloc _requestFeedbackScreenBloc;
  var personId = '';

  @override
  void initState() {
    super.initState();
    _requestFeedbackScreenBloc = Modular.get<RequestFeedbackScreenBloc>();
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<RequestFeedbackBloc, RequestFeedbackState>(
          bloc: _requestFeedbackScreenBloc.requestFeedbackBloc,
          listener: (context, state) async {
            if (state is SentRequestFeedbackState) {
              await Modular.to.popAndPushNamed(
                AppRoutes.successAnimationScreen,
                arguments: {
                  'title': context.translate.successRequest,
                  'subTitle': context.translate.withSuccess,
                },
                result: true,
              );
              Future.delayed(const Duration(seconds: 3));
            }

            if (state is ErrorRequestFeedbackState) {
              if (!context.mounted) return;
              _showDialogError(
                context: context,
                requestFeedbackScreenBloc: _requestFeedbackScreenBloc,
              );
            }
          },
        ),
        BlocListener<FeedbackPersonBloc, FeedbackPersonState>(
          bloc: _requestFeedbackScreenBloc.feedbackPersonBloc,
          listener: (context, state) {
            if (state is LoadedFeedbackPersonState) {
              setState(() {
                personId = state.personId;
              });
            }
          },
        ),
      ],
      child: BlocBuilder<RequestFeedbackScreenBloc, RequestFeedbackScreenState>(
        bloc: _requestFeedbackScreenBloc,
        builder: (context, state) {
          return PopScope(
            onPopInvokedWithResult: (_, __) async => state.requestFeedbackState is! LoadingRequestFeedbackState,
            child: Scaffold(
              body: WaapiColorfulHeader(
                hasTopPadding: false,
                onTapBack: () {
                  if (state.requestFeedbackState is! LoadingRequestFeedbackState) {
                    Modular.to.pop();
                  }
                },
                titleLabel: context.translate.requestFeedback,
                body: Scrollbar(
                  child: SingleChildScrollView(
                    keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: context.widthSize,
                        minHeight: context.seniorColorfulHeaderBodySize,
                      ),
                      child: IntrinsicHeight(
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: SeniorSpacing.normal,
                            right: SeniorSpacing.normal,
                            bottom: context.bottomSize + SeniorSpacing.normal,
                            top: SeniorSpacing.normal,
                          ),
                          child: Column(
                            children: [
                              SelectEmployeeCardWidget(
                                key: const Key('feedback-request_feedback_screen-employee_select-card'),
                                onTapClearSelection: () {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  if (state.requestFeedbackState is! LoadingRequestFeedbackState) {
                                    _requestFeedbackScreenBloc.searchEmployeeBloc.add(
                                      UnselectEmployeeFeedbackEvent(),
                                    );
                                  }
                                },
                                visibleCloseButton: personId.isEmpty,
                                disabled: state.requestFeedbackState is LoadingRequestFeedbackState ||
                                    state.searchEmployeeState.selectedEmployeeEntity != null,
                                employeeEntity:
                                    _requestFeedbackScreenBloc.searchEmployeeBloc.state.selectedEmployeeEntity,
                                onTap: () {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  _selectEmployee(context);
                                },
                                descriptionLabel: context.translate.selectEmployeeDescription,
                                descriptionLabelCoworker: context.translate.requestingFeedbackFrom,
                              ),
                              const SizedBox(
                                height: SeniorSpacing.medium,
                              ),
                              SeniorTextField(
                                key: const Key('feedback-request_feedback_screen-input_message-text_field'),
                                counterText: context.translate.characters,
                                showCounterText: true,
                                disabled: state.requestFeedbackState is LoadingRequestFeedbackState,
                                label: context.translate.requestMessageLabel,
                                hintText: context.translate.requestMessageHint,
                                maxLines: 9,
                                maxLength: 255,
                                controller: messageController,
                                onChanged: (_) => setState(() {}),
                              ),
                              const SizedBox(
                                height: SeniorSpacing.normal,
                              ),
                              const Spacer(),
                              SeniorButton(
                                key: const Key('feedback-request_feedback_screen-button-send_request'),
                                label: context.translate.sendRequest,
                                onPressed: () {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  _requestFeedbackScreenBloc.requestFeedbackBloc.add(
                                    SendRequestFeedbackRequestEvent(
                                      message: messageController.text.trim(),
                                      receiverId: personId,
                                    ),
                                  );
                                },
                                disabled: messageController.text.isEmpty ||
                                    personId.isEmpty ||
                                    state.searchEmployeeState.selectedEmployeeEntity == null ||
                                    state.requestFeedbackState is LoadingRequestFeedbackState,
                                fullWidth: true,
                                busy: state.requestFeedbackState is LoadingRequestFeedbackState,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _selectEmployee(BuildContext context) {
    SeniorBottomSheet.showBottomSheet(
      title: context.translate.writeFeedbackSearchEmployeeIntro,
      context: context,
      height: context.bottomSheetSize,
      content: [
        Expanded(
          child: SelectEmployeeBottomSheetContentWidget(
            key: const Key('feedback-request_feedback_bottom_sheet_content_widget'),
            searchEmployeeBloc: _requestFeedbackScreenBloc.searchEmployeeBloc,
            initialTitle: context.translate.requestFeedbackSearchEmployee,
            initialSubtitle: context.translate.requestFeedbackSearchEmployeeDescription,
            noFoundTitle: context.translate.noPersonFound,
            noFoundSubtitle: context.translate.noPersonFoundToFeedbackDescription,
          ),
        ),
      ],
      hasCloseButton: true,
      onTapCloseButton: () {
        _requestFeedbackScreenBloc.searchEmployeeBloc.add(ClearSearchEmployeeFeedbackEvent());
        Modular.to.pop();
      },
    );
  }

  void _showDialogError({
    required BuildContext context,
    required RequestFeedbackScreenBloc requestFeedbackScreenBloc,
  }) {
    showDialog(
      barrierDismissible: false,
      useRootNavigator: true,
      context: context,
      builder: (context) {
        return SeniorModal(
          title: context.translate.genericError,
          content: context.translate.errorRequestFeedbackDescription,
          defaultAction: SeniorModalAction(
            label: context.translate.optionCancel,
            action: Modular.to.pop,
          ),
          otherAction: SeniorModalAction(
            label: context.translate.tryAgain,
            action: () {
              Modular.to.pop();
              requestFeedbackScreenBloc.requestFeedbackBloc.add(
                SendRequestFeedbackRequestEvent(
                  message: messageController.text.trim(),
                  receiverId: requestFeedbackScreenBloc.searchEmployeeBloc.state.selectedEmployeeEntity!.id,
                ),
              );
            },
            danger: true,
          ),
        );
      },
    );
  }
}
