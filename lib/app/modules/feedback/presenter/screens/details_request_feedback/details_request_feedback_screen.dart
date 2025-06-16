import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../core/enums/analytics/waapi_loading_size_enum.dart';
import '../../../../../core/extension/media_query_extension.dart';
import '../../../../../core/extension/translate_extension.dart';
import '../../../../../core/widgets/waapi_colorful_header.dart';
import '../../../../../core/widgets/waapi_loading_widget.dart';
import '../../../../../routes/routes.dart';
import '../../../../authorization/presenter/blocs/authorization_bloc/authorization_bloc.dart';
import '../../../../authorization/presenter/blocs/authorization_bloc/authorization_state.dart';
import '../../../domain/entities/feedback_request_by_me_entity.dart';
import '../../../domain/entities/feedback_request_entity.dart';
import '../../../enums/feedback_analytics_type_enum.dart';
import '../../../enums/feedback_request_status_enum.dart';
import '../../widgets/feedback_request_details_header_widget.dart';
import 'bloc/details_request_feedback_screen_bloc.dart';
import 'bloc/details_request_feedback_screen_event.dart';
import 'bloc/details_request_feedback_screen_state.dart';

class DetailsRequestFeedbackScreen extends StatefulWidget {
  final String feedbackRequestId;
  final bool isRequestedByMe;

  const DetailsRequestFeedbackScreen({
    Key? key,
    required this.feedbackRequestId,
    required this.isRequestedByMe,
  }) : super(key: key);

  @override
  State<DetailsRequestFeedbackScreen> createState() {
    return _DetailsRequestFeedbackScreenState();
  }
}

class _DetailsRequestFeedbackScreenState extends State<DetailsRequestFeedbackScreen> {
  var updateRequestList = false;
  final bloc = Modular.get<DetailsRequestFeedbackScreenBloc>();

  @override
  void initState() {
    bloc.add(
      GetDetailsRequestFeedbackStateEvent(
        feedbackRequestId: widget.feedbackRequestId,
        isRequestedByMe: widget.isRequestedByMe,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = context.bottomSize;

    return PopScope(
      onPopInvokedWithResult: (_, __) async => Modular.to.pop(updateRequestList),
      child: BlocBuilder<DetailsRequestFeedbackScreenBloc, DetailsRequestFeedbackScreenState>(
        bloc: bloc,
        builder: (context, state) {
          if (state is ErrorDetailsRequestFeedbackState) {
            WidgetsBinding.instance.addPostFrameCallback(
              (_) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SeniorSnackBar.error(
                    message: context.translate.errorDetailsRequestFeedbackState,
                    action: SeniorSnackBarAction(
                      onPressed: () => Modular.to.pushNamed(
                        FeedbackRoutes.detailsRequestFeedbackScreenInitialRoute,
                        arguments: {
                          'feedbackRequest': widget.feedbackRequestId,
                          'isRequestedByMe': widget.isRequestedByMe,
                        },
                      ),
                      label: context.translate.repeat,
                    ),
                  ),
                );
                Modular.to.pop();
              },
            );
          }
          if (state is LoadingDetailsRequestFeedbackState) {
            return Scaffold(
              body: WaapiColorfulHeader(
                hasTopPadding: false,
                onTapBack: () => Modular.to.pop(
                  updateRequestList,
                ),
                titleLabel: context.translate.requestedFeedback,
                body: Padding(
                  padding: EdgeInsets.only(
                    bottom: bottomPadding,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: SeniorRadius.huge,
                      ),
                      Expanded(
                        child: Center(
                          child: Container(
                            padding: const EdgeInsets.only(
                              top: SeniorSpacing.normal,
                            ),
                            alignment: Alignment.topCenter,
                            child: const WaapiLoadingWidget(
                              waapiLoadingSizeEnum: WaapiLoadingSizeEnum.small,
                              key: Key('feedback-details_request_feedback_screen-feedbacks_detail-loading_indicator'),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: SeniorSpacing.normal,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }

          if (state is LoadedDetailsRequestFeedbackState) {
            final requestEntity = state.requestEntity;

            return Scaffold(
              body: WaapiColorfulHeader(
                hasTopPadding: false,
                onTapBack: () => Modular.to.pop(
                  updateRequestList,
                ),
                titleLabel: context.translate.requestedFeedback,
                body: Padding(
                  padding: EdgeInsets.only(
                    bottom: bottomPadding,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: SeniorRadius.huge,
                      ),
                      FeedbackRequestDetailsHeaderWidget(
                        key: const Key('feedback-detail_requests_header_widget'),
                        feedbackRequestEntity: requestEntity,
                      ),
                      const SizedBox(
                        height: SeniorSpacing.normal,
                      ),
                      SeniorQuotes(
                        key: const Key('feedback-detail_requests-description_quotes'),
                        message: requestEntity.text,
                        isScrollable: true,
                      ),
                      Offstage(
                        offstage: mustHideButton(
                          requestEntity: requestEntity,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: SeniorSpacing.normal,
                            right: SeniorSpacing.normal,
                            left: SeniorSpacing.normal,
                          ),
                          child: SeniorButton(
                            key: const Key('feedback-detail_requests-button-write_feedback'),
                            label: context.translate.writeFeedback,
                            onPressed: () => goToWriteFeedbackScreen(
                              requestEntity: requestEntity,
                            ),
                            fullWidth: true,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: SeniorSpacing.normal,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  bool mustHideButton({
    required FeedbackRequestEntity requestEntity,
  }) {
    final statusIsNotWaiting = requestEntity.status != FeedbackRequestStatusEnum.waiting;
    final requestIsByMe = requestEntity is FeedbackRequestByMeEntity;
    final userIsNotAllowedToWriteFeedback =
        !(Modular.get<AuthorizationBloc>().state as LoadedAuthorizationState).authorizationEntity.allowToWriteFeedback;

    return statusIsNotWaiting || requestIsByMe || userIsNotAllowedToWriteFeedback;
  }

  void goToWriteFeedbackScreen({
    required FeedbackRequestEntity requestEntity,
  }) async {
    var isFeedbackWrite = await Modular.to.pushNamed(
      FeedbackRoutes.writeFeedbackScreenInitialRoute,
      arguments: {
        'feedbackRequestEntity': requestEntity,
        'feedbackAnalyticsTypeEnum': FeedbackAnalyticsTypeEnum.request,
      },
    );

    if (isFeedbackWrite != null) {
      updateRequestList = true;
      Modular.to.pop(updateRequestList);
    }
  }
}
