import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../core/enums/analytics/waapi_loading_size_enum.dart';
import '../../../../../../core/extension/color_extension.dart';
import '../../../../../../core/helper/date_time_helper.dart';
import '../../../../../../core/helper/icons_helper.dart';
import '../../../../../../core/helper/locale_helper.dart';
import '../../../../../../core/helper/scroll_helper.dart';
import '../../../../../../core/widgets/feedback_card_widget.dart';
import '../../../../../../core/widgets/proficiency_tag_widget.dart';
import '../../../../../../core/widgets/waapi_loading_widget.dart';
import '../../../../../../routes/routes.dart';
import '../../../blocs/sent_feedbacks_bloc/sent_feedbacks_bloc.dart';
import '../../../blocs/sent_feedbacks_bloc/sent_feedbacks_event.dart';
import '../../../blocs/sent_feedbacks_bloc/sent_feedbacks_state.dart';
import '../bloc/feedbacks_screen_bloc.dart';

class SentFeedbacksListViewWidget extends StatefulWidget {
  final Function onEnableToLoadMore;
  final ScrollController scrollController;

  const SentFeedbacksListViewWidget({
    Key? key,
    required this.onEnableToLoadMore,
    required this.scrollController,
  }) : super(key: key);

  @override
  State<SentFeedbacksListViewWidget> createState() {
    return _SentFeedbacksListViewWidgetState();
  }
}

class _SentFeedbacksListViewWidgetState extends State<SentFeedbacksListViewWidget> {
  late SentFeedbacksBloc _sentFeedbacksBloc;

  @override
  void initState() {
    super.initState();
    _sentFeedbacksBloc = Modular.get<FeedbacksScreenBloc>().sentFeedbacksBloc;
    widget.scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    final sentFeedbacksState = _sentFeedbacksBloc.state;

    return Scrollbar(
      controller: widget.scrollController,
      child: ListView.separated(
        padding: EdgeInsets.zero,
        key: const Key('feedback-feedback_screen-feedbacks_sent-list_view'),
        itemCount: sentFeedbacksState.sentFeedbacks.length + 1,
        controller: widget.scrollController,
        itemBuilder: (_, index) {
          if (index == sentFeedbacksState.sentFeedbacks.length) {
            return Column(
              children: [
                Offstage(
                  key: const Key('feedback-feedback_screen-feedbacks_sent-circular_progress-load_more'),
                  offstage: sentFeedbacksState is! LoadingMoreSentFeedbacksState,
                  child: const WaapiLoadingWidget(
                    waapiLoadingSizeEnum: WaapiLoadingSizeEnum.small,
                  ),
                ),
              ],
            );
          }
          final feedback = sentFeedbacksState.sentFeedbacks[index];
          return Container(
            margin: EdgeInsets.only(
              left: SeniorSpacing.normal,
              right: SeniorSpacing.normal,
              top: index == 0 ? SeniorSpacing.normal : 0,
            ),
            child: FeedbackCardWidget(
              disabled: false,
              onTap: () async {
                final isFeedbackDeleted = await Modular.to.pushNamed(
                  FeedbackRoutes.detailsFeedbackScreenInitialRoute,
                  arguments: {
                    'sentFeedbackId': feedback.id,
                  },
                );

                if (isFeedbackDeleted != null && isFeedbackDeleted as bool) {
                  _sentFeedbacksBloc.add(ReloadListSentFeedbacksEvent());
                }
              },
              key: Key(
                'feedback-feedback_screen-feedbacks_sent-list_view-card-$index',
              ),
              imageUrl: feedback.toPhotoUrl,
              userName: feedback.toName,
              feedbackDate: DateTimeHelper.formatWithDefaultDatePattern(
                dateTime: feedback.when,
                locale: LocaleHelper.languageAndCountryCode(
                  locale: Localizations.localeOf(context),
                ),
              ),
              feedbackMessage: feedback.message,
              seniorRating: feedback.proficiency != null
                  ? null
                  : SeniorRating(
                      key: Key(
                        'feedback-feedback_screen-feedbacks_sent-list_view-card-rating_proficiency-$index-stars_indicator',
                      ),
                      itemCount: 5,
                      initialRating: feedback.starCount.toDouble(),
                      onRatingUpdate: (_) {},
                      ignoreGestures: true,
                    ),
              proficiencyTagWidget: feedback.proficiency == null
                  ? null
                  : ProficiencyTagWidget(
                      key: Key(
                        'feedback-feedback_screen-feedbacks_sent-list_view-card-rating_proficiency-$index-proficiency_indicator',
                      ),
                      label: feedback.proficiency!.name,
                      color: ColorExtension.fromHex(
                        hexString: feedback.proficiency!.color,
                      ),
                      icon: IconsHelper.parseProficiencyIconName(
                        proficiencyIconName: feedback.proficiency!.icon,
                      ),
                    ),
            ),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(
          height: SeniorSpacing.normal,
        ),
      ),
    );
  }

  void _onScroll() {
    final canLoadMore = ScrollHelper.reachedListEnd(
      scrollController: widget.scrollController,
    );

    if (canLoadMore) {
      widget.onEnableToLoadMore();
    }
  }
}
