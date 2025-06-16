import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../core/constants/assets_path.dart';
import '../../../../../../core/extension/translate_extension.dart';
import '../../../../../../core/pagination/pagination_requirements.dart';
import '../../../../../../core/theme/waapi_style_theme.dart';
import '../../../../../../core/widgets/employee_bottom_sheet_widget.dart';
import '../../../../../../core/widgets/empty_state_widget.dart';
import '../../../../../../core/widgets/error_state_widget.dart';
import '../../../../../../core/widgets/waapi_loading_widget.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../authorization/presenter/blocs/authorization_bloc/authorization_state.dart';
import '../../../../enums/feedback_analytics_type_enum.dart';
import '../../../blocs/feedback_requests_bloc/feedback_requests_event.dart';
import '../../../blocs/received_feedbacks_bloc/received_feedbacks_event.dart';
import '../../../blocs/received_feedbacks_bloc/received_feedbacks_state.dart';
import '../../../blocs/sent_feedbacks_bloc/sent_feedbacks_event.dart';
import '../bloc/feedbacks_screen_bloc.dart';
import '../bloc/feedbacks_screen_state.dart';
import 'received_feedbacks_listview_widget.dart';

class ReceivedFeedbacksTabContentWidget extends StatefulWidget {
  const ReceivedFeedbacksTabContentWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<ReceivedFeedbacksTabContentWidget> createState() {
    return _ReceivedFeedbacksTabContentWidgetState();
  }
}

class _ReceivedFeedbacksTabContentWidgetState extends State<ReceivedFeedbacksTabContentWidget>
    with AutomaticKeepAliveClientMixin<ReceivedFeedbacksTabContentWidget> {
  @override
  bool get wantKeepAlive {
    return true;
  }

  late ScrollController _scrollController;
  late FeedbacksScreenBloc _feedbacksScreenBloc;

  final listViewKey = GlobalKey(
    debugLabel: 'feedback-feedback_screen-feedbacks_received-list_view_screen',
  );

  var nextPage = 1;

  @override
  void initState() {
    super.initState();
    _feedbacksScreenBloc = Modular.get<FeedbacksScreenBloc>();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        Expanded(
          child: BlocConsumer<FeedbacksScreenBloc, FeedbacksScreenState>(
            bloc: _feedbacksScreenBloc,
            listener: (_, state) {
              final receivedFeedbackState = state.receivedFeedbacksState;

              if (receivedFeedbackState is ReloadListReceivedFeedbacksState) {
                nextPage = 1;
                _feedbacksScreenBloc.receivedFeedbacksBloc.add(
                  GetReceivedFeedbacksEvent(
                    paginationRequirements: PaginationRequirements(
                      page: nextPage,
                    ),
                  ),
                );
              }

              if (receivedFeedbackState is LoadedReceivedFeedbacksState) {
                nextPage++;
              }

              if (receivedFeedbackState is ErrorReceivedFeedbacksState) {
                if (receivedFeedbackState.receivedFeedbacks.isNotEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SeniorSnackBar.error(
                      message: context.translate.feedbackLoadingMoreReceivedFeedbacksError,
                      action: SeniorSnackBarAction(
                        label: context.translate.repeat,
                        onPressed: _getMoreReceivedFeedbacks,
                      ),
                    ),
                  );
                }
              }
            },
            listenWhen: (oldSate, newState) => oldSate.receivedFeedbacksState != newState.receivedFeedbacksState,
            builder: (context, state) {
              if (state.receivedFeedbacksState is LoadingReceivedFeedbacksState) {
                return Container(
                  padding: const EdgeInsets.only(
                    top: SeniorSpacing.normal,
                  ),
                  alignment: Alignment.topCenter,
                  child: const WaapiLoadingWidget(
                    key: Key('feedback-feedback_screen-feedbacks_received-loading_indicator'),
                  ),
                );
              }
              if (state.receivedFeedbacksState is EmptyListReceivedFeedbacksState) {
                final authorizationState = (_feedbacksScreenBloc.authorizationBloc.state as LoadedAuthorizationState);
                final authorizationEntity = authorizationState.authorizationEntity;

                var showRequestFeedbackButton = authorizationEntity.allowToRequestFeedback;
                var showWriteFeedbackButton = authorizationEntity.allowToWriteFeedback;
                var hideBottomSheet = !showRequestFeedbackButton && !showWriteFeedbackButton;

                return EmptyStateWidget(
                  key: const Key('feedback-feedback_screen-feedbacks_received-empty_state_screen'),
                  imagePath: AssetsPath.generalEmptyState,
                  title: context.translate.feedbackReceivedEmptyState,
                  subTitle: context.translate.feedbackInvitationToSendFeedback,
                  actions: hideBottomSheet
                      ? null
                      : [
                          Offstage(
                            offstage: !showWriteFeedbackButton,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                right: SeniorSpacing.normal,
                                left: SeniorSpacing.normal,
                                bottom: SeniorSpacing.normal,
                              ),
                              child: SeniorButton(
                                key: const Key('feedback-feedback_screen-bottom_sheet-button-write_feedback'),
                                fullWidth: true,
                                label: context.translate.writeFeedback,
                                onPressed: _goToWriteFeedback,
                              ),
                            ),
                          ),
                          Offstage(
                            offstage: showRequestFeedbackButton,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                right: SeniorSpacing.normal,
                                left: SeniorSpacing.normal,
                                bottom: SeniorSpacing.normal,
                              ),
                              child: SeniorButton(
                                key: const Key('feedback-feedback_screen-bottom_sheet-button-request_feedback'),
                                fullWidth: true,
                                label: context.translate.requestFeedback,
                                onPressed: _goToRequestFeedback,
                                outlined: showWriteFeedbackButton,
                                /*style: showWriteFeedbackButton
                                    ? WaapiStyleTheme.waapiSeniorButtonGhostOutlinedStyle()
                                    : null,*/
                              ),
                            ),
                          ),
                        ],
                );
              }

              if (state.receivedFeedbacksState is ErrorReceivedFeedbacksState &&
                  state.receivedFeedbacksState.receivedFeedbacks.isEmpty) {
                return ErrorStateWidget(
                  key: const Key('feedback-feedback_screen-feedbacks_received-error_state_screen'),
                  imagePath: AssetsPath.generalErrorState,
                  title: context.translate.feedbackReceivedErrorState,
                  subTitle: context.translate.feedbackReceivedErrorStateDescription,
                  onTapTryAgain: _getMoreReceivedFeedbacks,
                );
              }

              return ReceivedFeedbacksListViewWidget(
                key: listViewKey,
                scrollController: _scrollController,
                onEnableToLoadMore: () {
                  final receivedFeedbacksBloc = _feedbacksScreenBloc.receivedFeedbacksBloc;
                  receivedFeedbacksBloc.add(
                    GetReceivedFeedbacksEvent(
                      paginationRequirements: PaginationRequirements(
                        page: nextPage,
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
        BlocBuilder<FeedbacksScreenBloc, FeedbacksScreenState>(
          bloc: _feedbacksScreenBloc,
          builder: (_, state) {
            final authorizationState = (_feedbacksScreenBloc.authorizationBloc.state as LoadedAuthorizationState);
            final authorizationEntity = authorizationState.authorizationEntity;

            if (state.receivedFeedbacksState is LoadingReceivedFeedbacksState) {
              return const SizedBox.shrink();
            }

            var showRequestFeedbackButton = authorizationEntity.allowToRequestFeedback;
            var showWriteFeedbackButton = authorizationEntity.allowToWriteFeedback;

            var hideBottomSheet = (state.receivedFeedbacksState is ErrorReceivedFeedbacksState &&
                    state.receivedFeedbacksState.receivedFeedbacks.isEmpty) ||
                state.receivedFeedbacksState is EmptyListReceivedFeedbacksState;

            if (hideBottomSheet || (!showRequestFeedbackButton && !showWriteFeedbackButton)) {
              return const SizedBox.shrink();
            }

            return EmployeeBottomSheetWidget(
              horizontalPadding: true,
              key: const Key('feedback-feedback_screen-feedbacks_received-bottom_sheet'),
              seniorButtons: [
                Offstage(
                  offstage: !showWriteFeedbackButton,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      bottom: SeniorSpacing.normal,
                    ),
                    child: SeniorButton(
                      key: const Key('feedback-feedback_screen-bottom_sheet-button-write_feedback'),
                      fullWidth: true,
                      label: context.translate.writeFeedback,
                      onPressed: _goToWriteFeedback,
                    ),
                  ),
                ),
                Offstage(
                  offstage: !showRequestFeedbackButton,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      bottom: SeniorSpacing.normal,
                    ),
                    child: SeniorButton(
                      key: const Key('feedback-feedback_screen-bottom_sheet-button-request_feedback'),
                      fullWidth: true,
                      label: context.translate.requestFeedback,
                      onPressed: _goToRequestFeedback,
                      style: WaapiStyleTheme.waapiSeniorButtonGhostOutlinedStyle(context),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  void _goToRequestFeedback() async {
    final isFeedbackSent = await Modular.to.pushNamed(
      FeedbackRoutes.requestFeedbackScreenInitialRoute,
    );

    if (isFeedbackSent != null) {
      _feedbacksScreenBloc.feedbackRequestsBloc.add(ReloadListFeedbackRequestsEvent());
    }
  }

  void _getMoreReceivedFeedbacks() {
    _feedbacksScreenBloc.receivedFeedbacksBloc.add(
      GetReceivedFeedbacksEvent(
        paginationRequirements: PaginationRequirements(
          page: nextPage,
        ),
        overrideNotAllowedStates: true,
      ),
    );
  }

  void _goToWriteFeedback() async {
    final isFeedbackWrite = await Modular.to.pushNamed(
      FeedbackRoutes.writeFeedbackScreenInitialRoute,
      arguments: {
        'feedbackAnalyticsTypeEnum': FeedbackAnalyticsTypeEnum.organic,
      },
    );

    if (isFeedbackWrite != null) {
      _feedbacksScreenBloc.sentFeedbacksBloc.add(ReloadListSentFeedbacksEvent());
    }
  }
}
