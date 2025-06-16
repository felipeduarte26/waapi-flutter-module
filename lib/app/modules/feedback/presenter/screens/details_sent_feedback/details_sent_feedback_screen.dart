import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../core/extension/color_extension.dart';
import '../../../../../core/extension/media_query_extension.dart';
import '../../../../../core/extension/translate_extension.dart';
import '../../../../../core/helper/date_time_helper.dart';
import '../../../../../core/helper/icons_helper.dart';
import '../../../../../core/helper/locale_helper.dart';
import '../../../../../core/widgets/proficiency_tag_widget.dart';
import '../../../../../core/widgets/waapi_colorful_header.dart';
import '../../../../../core/widgets/waapi_loading_widget.dart';
import '../../../../../routes/routes.dart';
import '../../../domain/entities/feedback_entity.dart';
import '../../../enums/feedback_type_enum.dart';
import '../../../enums/feedback_visibility_enum.dart';
import '../../blocs/details_sent_feedback_bloc/details_sent_feedback_event.dart';
import '../../blocs/details_sent_feedback_bloc/details_sent_feedback_state.dart';
import '../../widgets/detail_feedback_header_widget.dart';
import '../../widgets/feedback_list_skills_widget.dart';
import 'bloc/details_sent_feedback_screen_bloc.dart';
import 'bloc/details_sent_feedback_screen_state.dart';

class DetailsSentFeedbackScreen extends StatefulWidget {
  final String sentFeedbackId;

  const DetailsSentFeedbackScreen({
    Key? key,
    required this.sentFeedbackId,
  }) : super(key: key);

  @override
  State<DetailsSentFeedbackScreen> createState() {
    return _DetailsSentFeedbackScreenState();
  }
}

class _DetailsSentFeedbackScreenState extends State<DetailsSentFeedbackScreen> {
  late DetailsSentFeedbackScreenBloc detailsSentFeedbackScreenBloc;

  @override
  void initState() {
    super.initState();
    detailsSentFeedbackScreenBloc = Modular.get<DetailsSentFeedbackScreenBloc>();
    detailsSentFeedbackScreenBloc.detailsSentFeedbackBloc.add(
      GetSentFeedbackEvent(
        sentFeedbackId: widget.sentFeedbackId,
        feedbackType: FeedbackTypeEnum.sent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = context.bottomSize;

    return Scaffold(
      body: WaapiColorfulHeader(
        hasTopPadding: false,
        titleLabel: context.translate.feedbackSubmitted,
        body: BlocConsumer<DetailsSentFeedbackScreenBloc, DetailsSentFeedbackScreenState>(
          bloc: detailsSentFeedbackScreenBloc,
          listener: (_, state) {
            final detailsSentFeedbackState = state.detailsSentFeedbackState;

            if (detailsSentFeedbackState is ErrorDeleteSentFeedbackState) {
              Modular.to.pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SeniorSnackBar.error(
                  message: context.translate.errorDeleteFeedback,
                ),
              );
            }

            if (detailsSentFeedbackState is ErrorDetailsSentFeedbackState) {
              Modular.to.pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SeniorSnackBar.error(
                  message: context.translate.errorToGetSentFeedback,
                  action: SeniorSnackBarAction(
                    label: context.translate.repeat,
                    onPressed: () => Modular.to.pushNamed(
                      FeedbackRoutes.detailsFeedbackScreenInitialRoute,
                      arguments: {
                        'sentFeedbackId': widget.sentFeedbackId,
                      },
                    ),
                  ),
                ),
              );
            }

            if (detailsSentFeedbackState is FeedbackDeletedDetailsSentFeedbackState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SeniorSnackBar.success(
                  message: context.translate.feedbackDeleted,
                ),
              );
              // The first pop is for modal
              Modular.to.pop(true);
              Modular.to.pop(true);
            }
          },
          builder: (context, state) {
            if (state.detailsSentFeedbackState is LoadingDetailsSentFeedbackState) {
              return Container(
                key: const Key('feedback-sent_feedbacks-details_sent_feedback_screen-loading'),
                padding: const EdgeInsets.only(
                  top: SeniorSpacing.normal,
                ),
                alignment: Alignment.topCenter,
                child: const WaapiLoadingWidget(),
              );
            }

            if (state.detailsSentFeedbackState is LoadedDetailsSentFeedbackState) {
              final sentFeedbackEntity =
                  (state.detailsSentFeedbackState as LoadedDetailsSentFeedbackState).feedbackEntity;

              return Padding(
                padding: EdgeInsets.only(
                  bottom: bottomPadding,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: SeniorSpacing.normal,
                        right: SeniorSpacing.normal,
                        top: SeniorSpacing.normal,
                      ),
                      child: DetailFeedbackHeaderWidget(
                        imageProvider: CachedNetworkImageProvider(sentFeedbackEntity.toPhotoUrl),
                        employeeName: sentFeedbackEntity.toName,
                        feedbackFormattedDate: DateTimeHelper.formatWithDefaultDatePattern(
                          dateTime: sentFeedbackEntity.when,
                          locale: LocaleHelper.languageAndCountryCode(
                            locale: Localizations.localeOf(context),
                          ),
                        ),
                        proficiency: sentFeedbackEntity.proficiency == null
                            ? SeniorRating(
                                key: const Key('feedback-sent_feedbacks_sent_feedback_screen-header-stars_indicator'),
                                itemCount: 5,
                                initialRating: sentFeedbackEntity.starCount.toDouble(),
                                onRatingUpdate: (_) {},
                                ignoreGestures: true,
                              )
                            : ProficiencyTagWidget(
                                key: const Key(
                                  'feedback-sent_feedbacks-details_sent_feedback_screen-header-proficiency_indicator',
                                ),
                                label: sentFeedbackEntity.proficiency!.name,
                                color: ColorExtension.fromHex(
                                  hexString: sentFeedbackEntity.proficiency!.color,
                                ),
                                icon: IconsHelper.parseProficiencyIconName(
                                  proficiencyIconName: sentFeedbackEntity.proficiency!.icon,
                                ),
                              ),
                      ),
                    ),
                    SeniorQuotes(
                      key: const Key('feedback-sent_feedbacks-details_sent_feedback_screen-header-quotes'),
                      message: sentFeedbackEntity.message,
                      isScrollable: true,
                    ),
                    sentFeedbackEntity.skills == null
                        ? const SizedBox.shrink()
                        : FeedbackListSkillsWidget(
                            skills: sentFeedbackEntity.skills!,
                          ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: SeniorSpacing.normal,
                          right: SeniorSpacing.normal,
                          left: SeniorSpacing.normal,
                        ),
                        child: SeniorText.small(
                          _getVisibilityText(
                            sentFeedbackEntity: sentFeedbackEntity,
                          ),
                          textProperties: const TextProperties(
                            textAlign: TextAlign.start,
                          ),
                          color: SeniorColors.neutralColor800,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: SeniorSpacing.normal,
                        right: SeniorSpacing.normal,
                        left: SeniorSpacing.normal,
                      ),
                      child: SeniorButton(
                        label: context.translate.delete,
                        onPressed: () => _showDialogDelete(
                          context: context,
                          detailsSentFeedbackScreenBloc: detailsSentFeedbackScreenBloc,
                          sentFeedbackId: sentFeedbackEntity.id,
                        ),
                        fullWidth: true,
                        danger: true,
                        busy: state.detailsSentFeedbackState is LoadingDetailsSentFeedbackState,
                        disabled: state.detailsSentFeedbackState is LoadingDetailsSentFeedbackState,
                      ),
                    ),
                    Offstage(
                      offstage: sentFeedbackEntity.attachments == null,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: SeniorSpacing.normal,
                          right: SeniorSpacing.normal,
                          left: SeniorSpacing.normal,
                        ),
                        child: SeniorButton.ghost(
                          label: context.translate.viewAttachments,
                          onPressed: () => Modular.to.pushNamed(
                            FeedbackRoutes.feedbackAttachmentsScreenInitialRoute,
                            arguments: {
                              'feedbackEntity': sentFeedbackEntity,
                            },
                          ),
                          fullWidth: true,
                          disabled: state.detailsSentFeedbackState is LoadingDetailsSentFeedbackState,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: SeniorSpacing.normal,
                    ),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  String _getVisibilityText({
    required FeedbackEntity sentFeedbackEntity,
  }) {
    switch (sentFeedbackEntity.visibility) {
      case FeedbackVisibilityEnum.evaluator:
        return context.translate.feedbackVisibilityEvaluator;
      case FeedbackVisibilityEnum.leader:
        return context.translate.feedbackVisibilityLeader;
      case FeedbackVisibilityEnum.employee:
        return context.translate.feedbackVisibilityEmployee;
      case FeedbackVisibilityEnum.onlyEmployee:
      default:
        return context.translate.feedbackVisibilityOnlyEmployee;
    }
  }

  void _showDialogDelete({
    required BuildContext context,
    required DetailsSentFeedbackScreenBloc detailsSentFeedbackScreenBloc,
    required String sentFeedbackId,
  }) {
    showDialog(
      barrierDismissible: false,
      useRootNavigator: true,
      context: context,
      builder: (context) {
        return BlocBuilder<DetailsSentFeedbackScreenBloc, DetailsSentFeedbackScreenState>(
          bloc: detailsSentFeedbackScreenBloc,
          builder: (context, state) {
            return SeniorModal(
              title: context.translate.confirmDeleteFeedback,
              content: context.translate.deleteFeedbackAlert,
              defaultAction: SeniorModalAction(
                label: context.translate.no,
                action: Modular.to.pop,
                busy: state.detailsSentFeedbackState is LoadingDetailsSentFeedbackState,
              ),
              otherAction: SeniorModalAction(
                busy: state.detailsSentFeedbackState is LoadingDetailsSentFeedbackState,
                label: context.translate.yes,
                action: () => detailsSentFeedbackScreenBloc.detailsSentFeedbackBloc.add(
                  DeleteFeedbackDetailsSentFeedbackEvent(
                    idFeedback: sentFeedbackId,
                  ),
                ),
                danger: true,
              ),
            );
          },
        );
      },
    );
  }
}
