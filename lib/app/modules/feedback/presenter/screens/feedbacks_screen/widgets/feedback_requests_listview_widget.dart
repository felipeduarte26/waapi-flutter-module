import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../core/extension/translate_extension.dart';
import '../../../../../../core/helper/date_time_helper.dart';
import '../../../../../../core/helper/locale_helper.dart';
import '../../../../../../routes/routes.dart';
import '../../../../domain/entities/feedback_request_by_me_entity.dart';
import '../../../../domain/entities/feedback_request_entity.dart';
import '../../../../enums/feedback_request_status_enum.dart';
import '../../../blocs/feedback_requests_bloc/feedback_requests_bloc.dart';
import '../../../blocs/feedback_requests_bloc/feedback_requests_event.dart';
import '../../../blocs/sent_feedbacks_bloc/sent_feedbacks_event.dart';
import '../../../widgets/profile_requirement_card_widget.dart';
import '../bloc/feedbacks_screen_bloc.dart';

class FeedbackRequestsListViewWidget extends StatefulWidget {
  const FeedbackRequestsListViewWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<FeedbackRequestsListViewWidget> createState() {
    return _FeedbackRequestsListViewWidgetState();
  }
}

class _FeedbackRequestsListViewWidgetState extends State<FeedbackRequestsListViewWidget> {
  late FeedbacksScreenBloc _feedbacksScreenBloc;
  late FeedbackRequestsBloc _feedbackRequestsBloc;

  @override
  void initState() {
    super.initState();
    _feedbacksScreenBloc = Modular.get<FeedbacksScreenBloc>();
    _feedbackRequestsBloc = _feedbacksScreenBloc.feedbackRequestsBloc;
  }

  @override
  Widget build(BuildContext context) {
    final feedbackRequestsState = _feedbackRequestsBloc.state;

    return Scrollbar(
      child: ListView.separated(
        padding: const EdgeInsets.only(
          bottom: SeniorSpacing.normal,
        ),
        key: const Key('feedback-feedback_screen-feedback_requests-list_view'),
        itemCount: feedbackRequestsState.feedbackRequests.length,
        itemBuilder: (_, index) {
          final feedbackRequest = feedbackRequestsState.feedbackRequests[index];

          if (feedbackRequest is FeedbackRequestByMeEntity) {
            return Container(
              margin: EdgeInsets.only(
                left: SeniorSpacing.normal,
                right: SeniorSpacing.normal,
                top: index == 0 ? SeniorSpacing.normal : 0,
              ),
              child: ProfileRequirementCardWidget(
                imageProvider: CachedNetworkImageProvider(feedbackRequest.photoLinkTo),
                employeeName: feedbackRequest.nameTo,
                chipLabel: feedbackRequest.status == FeedbackRequestStatusEnum.waiting
                    ? context.translate.sent
                    : context.translate.handled,
                feedbackFormattedDate: DateTimeHelper.formatWithDefaultDatePattern(
                  dateTime: feedbackRequest.when,
                  locale: LocaleHelper.languageAndCountryCode(
                    locale: Localizations.localeOf(context),
                  ),
                ),
                status: feedbackRequest.status == FeedbackRequestStatusEnum.waiting
                    ? FeedbackRequestStatusEnum.sent
                    : FeedbackRequestStatusEnum.attended,
                onTap: () => Modular.to.pushNamed(
                  FeedbackRoutes.detailsRequestFeedbackScreenInitialRoute,
                  arguments: {
                    'feedbackRequestId': feedbackRequest.id,
                    'isRequestedByMe': true,
                  },
                ),
                labelTitle: context.translate.sentTo,
              ),
            );
          }

          return Container(
            margin: EdgeInsets.only(
              left: SeniorSpacing.normal,
              right: SeniorSpacing.normal,
              top: index == 0 ? SeniorSpacing.normal : 0,
            ),
            child: ProfileRequirementCardWidget(
              imageProvider: NetworkImage(feedbackRequest.photoLinkFrom),
              employeeName: feedbackRequest.nameFrom,
              chipLabel: feedbackRequest.status == FeedbackRequestStatusEnum.waiting
                  ? context.translate.waiting
                  : context.translate.handled,
              feedbackFormattedDate: DateTimeHelper.formatWithDefaultDatePattern(
                dateTime: feedbackRequest.when,
                locale: LocaleHelper.languageAndCountryCode(
                  locale: Localizations.localeOf(context),
                ),
              ),
              status: feedbackRequest.status == FeedbackRequestStatusEnum.waiting
                  ? FeedbackRequestStatusEnum.waiting
                  : FeedbackRequestStatusEnum.attended,
              onTap: () => _goToRequestFeedback(
                feedbackRequest: feedbackRequest,
              ),
              labelTitle: context.translate.receivedFrom,
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: SeniorSpacing.normal,
          );
        },
      ),
    );
  }

  void _goToRequestFeedback({
    required FeedbackRequestEntity feedbackRequest,
  }) async {
    final isFeedbackWriteSend = await Modular.to.pushNamed<bool>(
      FeedbackRoutes.detailsRequestFeedbackScreenInitialRoute,
      arguments: {
        'feedbackRequestId': feedbackRequest.id,
        'isRequestedByMe': feedbackRequest is FeedbackRequestByMeEntity,
      },
    );

    if (isFeedbackWriteSend == null) {
      return;
    }

    if (isFeedbackWriteSend) {
      _feedbacksScreenBloc.feedbackRequestsBloc.add(ReloadListFeedbackRequestsEvent());
      _feedbacksScreenBloc.sentFeedbacksBloc.add(ReloadListSentFeedbacksEvent());
    }
  }
}
