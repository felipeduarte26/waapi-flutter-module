import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../core/extension/color_extension.dart';
import '../../../../../core/extension/media_query_extension.dart';
import '../../../../../core/extension/translate_extension.dart';
import '../../../../../core/helper/date_time_helper.dart';
import '../../../../../core/helper/file_helper.dart';
import '../../../../../core/helper/icons_helper.dart';
import '../../../../../core/helper/locale_helper.dart';
import '../../../../../core/theme/waapi_style_theme.dart';
import '../../../../../core/widgets/proficiency_tag_widget.dart';
import '../../../../../core/widgets/waapi_colorful_header.dart';
import '../../../../../core/widgets/waapi_loading_widget.dart';
import '../../../../../routes/routes.dart';
import '../../../../attachment/presenter/blocs/attachment_bloc/attachment_event.dart';
import '../../../../attachment/presenter/blocs/attachment_bloc/attachment_state.dart';
import '../../../../authorization/presenter/blocs/authorization_bloc/authorization_state.dart';
import '../../../domain/entities/feedback_entity.dart';
import '../../../domain/entities/feedback_request_to_me_entity.dart';
import '../../../enums/feedback_analytics_type_enum.dart';
import '../../../enums/feedback_type_enum.dart';
import '../../../helper/screenshot_helper.dart';
import '../../blocs/details_received_feedback_bloc/details_received_feedback_event.dart';
import '../../blocs/details_received_feedback_bloc/details_received_feedback_state.dart';
import '../../widgets/detail_feedback_header_widget.dart';
import '../../widgets/feedback_list_skills_widget.dart';
import '../../widgets/feedback_toggle_widget.dart';
import '../../widgets/feedback_visibility_description_widget.dart';
import 'blocs/details_received_feedback_screen_bloc/details_received_feedback_screen_bloc.dart';
import 'blocs/details_received_feedback_screen_bloc/details_received_feedback_screen_state.dart';
import 'widgets/screenshot_details_received_feedbacks_widget.dart';

class DetailsReceivedFeedbackScreen extends StatefulWidget {
  final DetailsReceivedFeedbackScreenBloc detailsReceivedFeedbacksScreenBloc;
  final String receivedFeedbackId;

  const DetailsReceivedFeedbackScreen({
    Key? key,
    required this.detailsReceivedFeedbacksScreenBloc,
    required this.receivedFeedbackId,
  }) : super(key: key);

  @override
  State<DetailsReceivedFeedbackScreen> createState() {
    return _DetailsReceivedFeedbackScreenState();
  }
}

class _DetailsReceivedFeedbackScreenState
    extends State<DetailsReceivedFeedbackScreen> {
  bool canReloadPreviousPage = false;

  @override
  void initState() {
    super.initState();
    widget.detailsReceivedFeedbacksScreenBloc.detailsReceivedFeedbacksBloc.add(
      GetReceivedFeedbackEvent(
        receivedFeedbackId: widget.receivedFeedbackId,
        feedbackType: FeedbackTypeEnum.received,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (_, __) async =>
          Modular.to.pop(canReloadPreviousPage),
      child: Scaffold(
        body: WaapiColorfulHeader(
          onTapBack: () => Modular.to.pop(
            canReloadPreviousPage,
          ),
          hasTopPadding: false,
          titleLabel: context.translate.feedbackReceived,
          actions: [
            BlocBuilder<DetailsReceivedFeedbackScreenBloc,
                DetailsReceivedFeedbackScreenState>(
              bloc: widget.detailsReceivedFeedbacksScreenBloc,
              builder: (context, state) {
                if (state.detailsReceivedFeedbackState
                    is LoadedDetailsReceivedFeedbackState) {
                  return IconButton(
                    key: const Key(
                        'feedback-details_received_feedbacks-action_button_appbar-search'),
                    icon: const SeniorIcon(
                      icon: FontAwesomeIcons.shareNodes,
                      size: SeniorIconSize.small,
                      style: SeniorIconStyle(
                        color: SeniorColors.pureWhite,
                      ),
                    ),
                    onPressed: () async {
                      final uint8List =
                          await ScreenshotHelper.captureFromWidgetWithSize(
                        ScreenshotDetailsReceivedFeedbacksWidget(
                          receivedFeedbackEntity:
                              (state.detailsReceivedFeedbackState
                                      as LoadedDetailsReceivedFeedbackState)
                                  .receivedFeedbackEntity,
                          languageCode: LocaleHelper.languageAndCountryCode(
                            locale: Localizations.localeOf(context),
                          ),
                        ),
                        context,
                      );

                      final File fileToShare =
                          await FileHelper.createFileFromUint8List(uint8List);

                      widget.detailsReceivedFeedbacksScreenBloc.shareFileBloc
                          .add(
                        ShareFileReceivedEvent(
                          fileToShare: fileToShare.path,
                        ),
                      );
                    },
                    tooltip: context.translate.feedbackShare,
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
          body: BlocConsumer<DetailsReceivedFeedbackScreenBloc,
              DetailsReceivedFeedbackScreenState>(
            bloc: widget.detailsReceivedFeedbacksScreenBloc,
            listener: (_, state) {
              if (state.shareFileState is ErrorNativePermissionStorageState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SeniorSnackBar.error(
                    message: context.translate.errorPermissionStorage,
                  ),
                );
              }

              if (state.shareFileState is ErrorShareDetailsReceivedState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SeniorSnackBar.error(
                    message: context.translate.errorShareFeedback,
                  ),
                );
              }

              if (state.detailsReceivedFeedbackState
                  is ErrorDetailsReceivedFeedbacksState) {
                Modular.to.pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SeniorSnackBar.error(
                    message: context.translate.errorToGetReceivedFeedback,
                    action: SeniorSnackBarAction(
                      label: context.translate.repeat,
                      onPressed: () => Modular.to.pushNamed(
                        FeedbackRoutes.toFeedbacksDetailsReceivedScreenRoute,
                        arguments: {
                          'receivedFeedbackId': widget.receivedFeedbackId,
                        },
                      ),
                    ),
                  ),
                );
              }

              if (state.detailsReceivedFeedbackState
                  is ReceivedFeedbacksNotFoundState) {
                Modular.to.pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SeniorSnackBar.warning(
                    message: context.translate.errorOnReceivedFeedbackNotFound,
                  ),
                );
              }
            },
            builder: (context, state) {
              final authorizationState = widget
                  .detailsReceivedFeedbacksScreenBloc
                  .authorizationBloc
                  .state as LoadedAuthorizationState;
              final authorizationEntity =
                  authorizationState.authorizationEntity;

              if (state.detailsReceivedFeedbackState
                  is LoadingDetailsReceivedFeedbacksState) {
                return Container(
                  key: const Key(
                      'feedbacks-details_received_feedback_screen-loading'),
                  padding: const EdgeInsets.only(
                    top: SeniorSpacing.normal,
                  ),
                  alignment: Alignment.topCenter,
                  child: const WaapiLoadingWidget(),
                );
              }
              if (state.detailsReceivedFeedbackState
                  is LoadedDetailsReceivedFeedbackState) {
                final detailsReceivedFeedbackState =
                    state.detailsReceivedFeedbackState
                        as LoadedDetailsReceivedFeedbackState;
                return Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: SeniorSpacing.normal,
                        right: SeniorSpacing.normal,
                        top: SeniorSpacing.normal,
                      ),
                      child: DetailFeedbackHeaderWidget(
                        imageProvider: CachedNetworkImageProvider(
                          detailsReceivedFeedbackState
                              .receivedFeedbackEntity.fromPhotoUrl,
                        ),
                        employeeName: detailsReceivedFeedbackState
                            .receivedFeedbackEntity.fromName,
                        feedbackFormattedDate:
                            DateTimeHelper.formatWithDefaultDatePattern(
                          dateTime: detailsReceivedFeedbackState
                              .receivedFeedbackEntity.when,
                          locale: LocaleHelper.languageAndCountryCode(
                            locale: Localizations.localeOf(context),
                          ),
                        ),
                        proficiency: detailsReceivedFeedbackState
                                    .receivedFeedbackEntity.proficiency !=
                                null
                            ? ProficiencyTagWidget(
                                key: const Key(
                                    'feedback-proficiency_tag_widget-proficiency_tag'),
                                label: detailsReceivedFeedbackState
                                    .receivedFeedbackEntity.proficiency!.name,
                                color: ColorExtension.fromHex(
                                  hexString: detailsReceivedFeedbackState
                                      .receivedFeedbackEntity
                                      .proficiency!
                                      .color,
                                ),
                                icon: IconsHelper.parseProficiencyIconName(
                                  proficiencyIconName:
                                      detailsReceivedFeedbackState
                                          .receivedFeedbackEntity
                                          .proficiency!
                                          .icon,
                                ),
                              )
                            : SeniorRating(
                                key: const Key(
                                    'feedback-proficiency_tag_widget-senior_rating'),
                                itemCount: 5,
                                initialRating: detailsReceivedFeedbackState
                                    .receivedFeedbackEntity.starCount
                                    .toDouble(),
                                onRatingUpdate: (_) {},
                                ignoreGestures: true,
                              ),
                      ),
                    ),
                    SeniorQuotes(
                      key: const Key('feedback-senior_quotes-quotes'),
                      message: detailsReceivedFeedbackState
                          .receivedFeedbackEntity.message,
                      isScrollable: true,
                    ),
                    detailsReceivedFeedbackState
                                .receivedFeedbackEntity.skills !=
                            null
                        ? FeedbackListSkillsWidget(
                            skills: detailsReceivedFeedbackState
                                .receivedFeedbackEntity.skills!,
                          )
                        : const SizedBox.shrink(),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: SeniorSpacing.normal,
                        right: SeniorSpacing.normal,
                      ),
                      child: FeedbackVisibilityDescriptionWidget(
                        key: const Key(
                            'feedback-feedback_visibility_description-visibility_description'),
                        visibility: detailsReceivedFeedbackState
                            .receivedFeedbackEntity.visibility,
                      ),
                    ),
                    FeedbackToggleWidget(
                      key: const Key(
                          'feedback-feedback_which_widget-which_visible'),
                      receivedFeedbackEntity:
                          detailsReceivedFeedbackState.receivedFeedbackEntity,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: SeniorSpacing.normal,
                        right: SeniorSpacing.normal,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Visibility(
                            visible: detailsReceivedFeedbackState
                                        .receivedFeedbackEntity.attachments !=
                                    null &&
                                detailsReceivedFeedbackState
                                    .receivedFeedbackEntity
                                    .attachments!
                                    .isNotEmpty,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                bottom: SeniorSpacing.normal,
                              ),
                              child: SeniorButton(
                                key: const Key(
                                    'feedback-feedback_screen-bottom_sheet-button-view_attachments'),
                                fullWidth: true,
                                label: context.translate.viewAttachments,
                                onPressed: () => Modular.to.pushNamed(
                                  FeedbackRoutes
                                      .feedbackAttachmentsScreenInitialRoute,
                                  arguments: {
                                    'feedbackEntity':
                                        detailsReceivedFeedbackState
                                            .receivedFeedbackEntity,
                                  },
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: authorizationEntity.allowToWriteFeedback,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                bottom: SeniorSpacing.normal,
                              ),
                              child: SeniorButton(
                                key: const Key(
                                    'feedback-feedback_screen-bottom_sheet-button-request_feedback'),
                                fullWidth: true,
                                label: context.translate.feedbackReopen,
                                onPressed: () => goToWriteFeedbackScreen(
                                  receivedFeedbackEntity:
                                      detailsReceivedFeedbackState
                                          .receivedFeedbackEntity,
                                ),
                                style: detailsReceivedFeedbackState
                                                .receivedFeedbackEntity
                                                .attachments !=
                                            null &&
                                        detailsReceivedFeedbackState
                                            .receivedFeedbackEntity
                                            .attachments!
                                            .isNotEmpty
                                    ? WaapiStyleTheme
                                        .waapiSeniorButtonGhostOutlinedStyle(
                                            context)
                                    : null,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: context.bottomSize,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }

  void goToWriteFeedbackScreen({
    required FeedbackEntity receivedFeedbackEntity,
  }) async {
    final feedbackRequestEntity = FeedbackRequestToMeEntity(
      toPersonId: '',
      fromPersonId: '',
      toUsername: '',
      text: '',
      fromUsername: receivedFeedbackEntity.fromUsername,
      photoLinkFrom: receivedFeedbackEntity.fromPhotoUrl,
      when: receivedFeedbackEntity.when,
      status: null,
      photoLinkTo: '',
      nameTo: '',
      id: '',
      nameFrom: receivedFeedbackEntity.fromName,
    );

    final sentFeedbackIdEntity = await Modular.to.pushNamed(
      FeedbackRoutes.writeFeedbackScreenInitialRoute,
      arguments: {
        'feedbackRequestEntity': feedbackRequestEntity,
        'feedbackAnalyticsTypeEnum': FeedbackAnalyticsTypeEnum.retribution,
      },
    );

    if (sentFeedbackIdEntity != null) {
      canReloadPreviousPage = true;
    }
  }
}
