import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../core/constants/assets_path.dart';
import '../../../../../../core/enums/analytics/waapi_loading_size_enum.dart';
import '../../../../../../core/extension/translate_extension.dart';
import '../../../../../../core/theme/waapi_style_theme.dart';
import '../../../../../../core/widgets/employee_bottom_sheet_widget.dart';
import '../../../../../../core/widgets/empty_state_widget.dart';
import '../../../../../../core/widgets/error_state_widget.dart';
import '../../../../../../core/widgets/waapi_loading_widget.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../authorization/presenter/blocs/authorization_bloc/authorization_state.dart';
import '../../../blocs/feedback_requests_bloc/feedback_requests_event.dart';
import '../../../blocs/feedback_requests_bloc/feedback_requests_state.dart';
import '../bloc/feedbacks_screen_bloc.dart';
import '../bloc/feedbacks_screen_state.dart';
import 'feedback_requests_listview_widget.dart';

class FeedbackRequestsTabContentWidget extends StatefulWidget {
  const FeedbackRequestsTabContentWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<FeedbackRequestsTabContentWidget> createState() {
    return _FeedbackRequestsTabContentWidgetState();
  }
}

class _FeedbackRequestsTabContentWidgetState extends State<FeedbackRequestsTabContentWidget>
    with AutomaticKeepAliveClientMixin<FeedbackRequestsTabContentWidget> {
  late final FeedbacksScreenBloc _feedbacksScreenBloc;

  final listViewKey = GlobalKey(
    debugLabel: 'feedback-feedback_screen-feedback_requests_list_view_screen',
  );

  @override
  void initState() {
    super.initState();
    _feedbacksScreenBloc = Modular.get<FeedbacksScreenBloc>();
  }

  @override
  bool get wantKeepAlive {
    return true;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        Expanded(
          child: BlocBuilder<FeedbacksScreenBloc, FeedbacksScreenState>(
            bloc: _feedbacksScreenBloc,
            builder: (context, state) {
              if (state.feedbackRequestsState is ReloadListFeedbackRequestsState) {
                _feedbacksScreenBloc.feedbackRequestsBloc.add(GetFeedbackRequestsEvent());
              }

              if (state.feedbackRequestsState is LoadingFeedbackRequestsState) {
                return Container(
                  padding: const EdgeInsets.only(
                    top: SeniorSpacing.normal,
                  ),
                  alignment: Alignment.topCenter,
                  child: const WaapiLoadingWidget(
                    waapiLoadingSizeEnum: WaapiLoadingSizeEnum.small,
                    key: Key('feedback-feedback_screen-feedback_requests-loading_indicator'),
                  ),
                );
              }

              if (state.feedbackRequestsState is EmptyListFeedbackRequestsState) {
                final authorizationState = (_feedbacksScreenBloc.authorizationBloc.state as LoadedAuthorizationState);
                final authorizationEntity = authorizationState.authorizationEntity;

                var showRequestFeedbackButton = authorizationEntity.allowToRequestFeedback;
                bool hideBottomSheet = !showRequestFeedbackButton;

                return EmptyStateWidget(
                  key: const Key('feedback-feedback_screen-feedback_requests-empty_state_screen'),
                  imagePath: AssetsPath.generalEmptyState,
                  title: context.translate.feedbackRequestsEmptyState,
                  subTitle: context.translate.feedbackInvitationToRequestFeedback,
                  actions: hideBottomSheet
                      ? null
                      : [
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
                                style: showRequestFeedbackButton
                                    ? null
                                    : WaapiStyleTheme.waapiSeniorButtonGhostOutlinedStyle(context),
                              ),
                            ),
                          ),
                        ],
                );
              }

              if (state.feedbackRequestsState is ErrorFeedbackRequestsState &&
                  state.feedbackRequestsState.feedbackRequests.isEmpty) {
                return ErrorStateWidget(
                  key: const Key('feedback-feedback_screen-feedback_requests-error_state_screen'),
                  imagePath: AssetsPath.generalErrorState,
                  title: context.translate.feedbackRequestsErrorState,
                  subTitle: context.translate.feedbackRequestsErrorStateDescription,
                  onTapTryAgain: () => _feedbacksScreenBloc.feedbackRequestsBloc.add(GetFeedbackRequestsEvent()),
                );
              }
              if (state.feedbackRequestsState is LoadedFeedbackRequestsState) {
                return FeedbackRequestsListViewWidget(
                  key: listViewKey,
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
        BlocBuilder<FeedbacksScreenBloc, FeedbacksScreenState>(
          bloc: _feedbacksScreenBloc,
          builder: (_, state) {
            final authorizationState = (_feedbacksScreenBloc.authorizationBloc.state as LoadedAuthorizationState);
            final authorizationEntity = authorizationState.authorizationEntity;

            if (state.feedbackRequestsState is LoadingFeedbackRequestsState ||
                state.feedbackRequestsState is InitialFeedbackRequestsState) {
              return const SizedBox.shrink();
            }

            var showRequestFeedbackButton = authorizationEntity.allowToRequestFeedback;

            bool hideBottomSheet = (state.feedbackRequestsState is ErrorFeedbackRequestsState &&
                    state.feedbackRequestsState.feedbackRequests.isEmpty) ||
                state.feedbackRequestsState is EmptyListFeedbackRequestsState;

            if (hideBottomSheet || (!showRequestFeedbackButton)) {
              return const SizedBox.shrink();
            }
            return EmployeeBottomSheetWidget(
              horizontalPadding: true,
              key: const Key('feedback-feedback_screen-feedback_requests-bottom_sheet'),
              seniorButtons: [
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
                      style: showRequestFeedbackButton
                          ? null
                          : WaapiStyleTheme.waapiSeniorButtonGhostOutlinedStyle(context),
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
}
