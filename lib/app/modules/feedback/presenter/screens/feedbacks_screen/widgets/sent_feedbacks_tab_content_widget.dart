import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/tokens/senior_spacing.dart';

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
import '../../../blocs/sent_feedbacks_bloc/sent_feedbacks_event.dart';
import '../../../blocs/sent_feedbacks_bloc/sent_feedbacks_state.dart';
import '../bloc/feedbacks_screen_bloc.dart';
import '../bloc/feedbacks_screen_state.dart';
import 'sent_feedbacks_listview_widget.dart';

class SentFeedbacksTabContentWidget extends StatefulWidget {
  const SentFeedbacksTabContentWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<SentFeedbacksTabContentWidget> createState() {
    return _SentFeedbacksTabContentWidgetState();
  }
}

class _SentFeedbacksTabContentWidgetState extends State<SentFeedbacksTabContentWidget>
    with AutomaticKeepAliveClientMixin<SentFeedbacksTabContentWidget> {
  @override
  bool get wantKeepAlive {
    return true;
  }

  late ScrollController _scrollController;
  late FeedbacksScreenBloc _feedbacksScreenBloc;

  final listViewKey = GlobalKey(
    debugLabel: 'feedback-feedback_screen-feedbacks_sent-list_view_screen',
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
              final sentFeedbacksState = state.sentFeedbacksState;

              if (sentFeedbacksState is ReloadListSentFeedbacksState) {
                nextPage = 1;
                _feedbacksScreenBloc.sentFeedbacksBloc.add(
                  GetSentFeedbacksEvent(
                    paginationRequirements: PaginationRequirements(
                      page: nextPage,
                    ),
                  ),
                );
              }

              if (sentFeedbacksState is LoadedSentFeedbacksState) {
                nextPage++;
              }

              if (sentFeedbacksState is ErrorSentFeedbacksState) {
                if (sentFeedbacksState.sentFeedbacks.isNotEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SeniorSnackBar.error(
                      message: context.translate.feedbackLoadingMoreSentFeedbacksError,
                      action: SeniorSnackBarAction(
                        label: context.translate.repeat,
                        onPressed: _getMoreSentFeedbacks,
                      ),
                    ),
                  );
                }
              }
            },
            listenWhen: (oldSate, newState) => oldSate.sentFeedbacksState != newState.sentFeedbacksState,
            builder: (_, state) {
              if (state.sentFeedbacksState is LoadingSentFeedbacksState) {
                return Container(
                  padding: const EdgeInsets.only(
                    top: SeniorSpacing.normal,
                  ),
                  alignment: Alignment.topCenter,
                  child: const WaapiLoadingWidget(
                    key: Key('feedback-feedback_screen-feedbacks_sent-loading_indicator'),
                  ),
                );
              }

              if (state.sentFeedbacksState is EmptyListSentFeedbacksState) {
                final authorizationState = (_feedbacksScreenBloc.authorizationBloc.state as LoadedAuthorizationState);
                final authorizationEntity = authorizationState.authorizationEntity;

                var showRequestFeedbackButton = authorizationEntity.allowToRequestFeedback;
                var showWriteFeedbackButton = authorizationEntity.allowToWriteFeedback;
                var hideBottomSheet = !showRequestFeedbackButton && !showWriteFeedbackButton;

                return EmptyStateWidget(
                  key: const Key('feedback-feedback_screen-feedbacks_sent-empty_state_screen'),
                  imagePath: AssetsPath.generalEmptyState,
                  title: context.translate.feedbackSentEmptyState,
                  subTitle: context.translate.feedbackInvitationToSendFeedbackNow,
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
                            offstage: !showRequestFeedbackButton,
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
                                style: WaapiStyleTheme.waapiSeniorButtonGhostOutlinedStyle(context),
                              ),
                            ),
                          ),
                        ],
                );
              }

              if (state.sentFeedbacksState is ErrorSentFeedbacksState &&
                  state.sentFeedbacksState.sentFeedbacks.isEmpty) {
                return ErrorStateWidget(
                  key: const Key('feedback-feedback_screen-feedbacks_sent-error_state_screen'),
                  imagePath: AssetsPath.generalErrorState,
                  title: context.translate.feedbackSentErrorState,
                  subTitle: context.translate.feedbackSentErrorStateDescription,
                  onTapTryAgain: _getMoreSentFeedbacks,
                );
              }

              return SentFeedbacksListViewWidget(
                key: listViewKey,
                scrollController: _scrollController,
                onEnableToLoadMore: () => _feedbacksScreenBloc.sentFeedbacksBloc.add(
                  GetSentFeedbacksEvent(
                    paginationRequirements: PaginationRequirements(
                      page: nextPage,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        BlocBuilder<FeedbacksScreenBloc, FeedbacksScreenState>(
          bloc: _feedbacksScreenBloc,
          builder: (_, state) {
            final authorizationState = (_feedbacksScreenBloc.authorizationBloc.state as LoadedAuthorizationState);
            final authorizationEntity = authorizationState.authorizationEntity;

            if (state.sentFeedbacksState is LoadingSentFeedbacksState ||
                state.sentFeedbacksState is InitialSentFeedbacksState) {
              return const SizedBox.shrink();
            }

            var showRequestFeedbackButton = authorizationEntity.allowToRequestFeedback;
            var showWriteFeedbackButton = authorizationEntity.allowToWriteFeedback;
            var hideBottomSheet = (state.sentFeedbacksState is ErrorSentFeedbacksState &&
                    state.sentFeedbacksState.sentFeedbacks.isEmpty) ||
                state.sentFeedbacksState is EmptyListSentFeedbacksState;

            if (hideBottomSheet || (!showRequestFeedbackButton && !showWriteFeedbackButton)) {
              return const SizedBox.shrink();
            }

            return EmployeeBottomSheetWidget(
              horizontalPadding: true,
              key: const Key('feedback-feedback_screen-feedbacks_sent-bottom_sheet'),
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
    final isFeedbackSent = await Modular.to.pushNamed(FeedbackRoutes.requestFeedbackScreenInitialRoute);

    if (isFeedbackSent != null) {
      _feedbacksScreenBloc.feedbackRequestsBloc.add(ReloadListFeedbackRequestsEvent());
    }
  }

  void _getMoreSentFeedbacks() {
    _feedbacksScreenBloc.sentFeedbacksBloc.add(
      GetSentFeedbacksEvent(
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
