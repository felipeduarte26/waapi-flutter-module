import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../core/extension/color_extension.dart';
import '../../../../../core/extension/translate_extension.dart';
import '../../../../../core/helper/date_time_helper.dart';
import '../../../../../core/helper/file_helper.dart';
import '../../../../../core/helper/icons_helper.dart';
import '../../../../../core/helper/locale_helper.dart';
import '../../../../../core/widgets/proficiency_tag_widget.dart';
import '../../../../../core/widgets/waapi_colorful_header.dart';
import '../../../../attachment/presenter/blocs/attachment_bloc/attachment_event.dart';
import '../../../../attachment/presenter/blocs/attachment_bloc/attachment_state.dart';
import '../../../domain/entities/feedback_entity.dart';
import '../../../enums/feedback_type_enum.dart';
import '../../widgets/detail_feedback_header_widget.dart';
import 'bloc/feedback_attachments_screen_bloc.dart';
import 'bloc/feedback_attachments_screen_state.dart';

class FeedbackAttachmentsScreen extends StatefulWidget {
  final FeedbackEntity feedbackEntity;

  const FeedbackAttachmentsScreen({
    Key? key,
    required this.feedbackEntity,
  }) : super(key: key);

  @override
  State<FeedbackAttachmentsScreen> createState() {
    return _FeedbackAttachmentsScreenState();
  }
}

class _FeedbackAttachmentsScreenState extends State<FeedbackAttachmentsScreen> {
  late FeedbackAttachmentsScreenBloc _feedbackAttachmentsScreenBloc;

  @override
  void initState() {
    super.initState();
    _feedbackAttachmentsScreenBloc = Modular.get<FeedbackAttachmentsScreenBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WaapiColorfulHeader(
        hasTopPadding: false,
        titleLabel: context.translate.feedbackSubmitted,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: SeniorSpacing.normal,
                right: SeniorSpacing.normal,
                top: SeniorSpacing.normal,
              ),
              child: DetailFeedbackHeaderWidget(
                imageProvider: CachedNetworkImageProvider(_getPhotoUrl()),
                employeeName: _getName(),
                feedbackFormattedDate: DateTimeHelper.formatWithDefaultDatePattern(
                  dateTime: widget.feedbackEntity.when,
                  locale: LocaleHelper.languageAndCountryCode(
                    locale: Localizations.localeOf(context),
                  ),
                ),
                proficiency: widget.feedbackEntity.proficiency == null
                    ? SeniorRating(
                        key: const Key(
                          'feedback-details_sent_feedback_screen-header-stars_indicator',
                        ),
                        itemCount: 5,
                        initialRating: widget.feedbackEntity.starCount.toDouble(),
                        onRatingUpdate: (_) {},
                        ignoreGestures: true,
                      )
                    : ProficiencyTagWidget(
                        key: const Key('feedback-details_sent_feedback_screen-header-proficiency_indicator'),
                        label: widget.feedbackEntity.proficiency!.name,
                        color: ColorExtension.fromHex(
                          hexString: widget.feedbackEntity.proficiency!.color,
                        ),
                        icon: IconsHelper.parseProficiencyIconName(
                          proficiencyIconName: widget.feedbackEntity.proficiency!.icon,
                        ),
                      ),
              ),
            ),
            Expanded(
              child: BlocConsumer<FeedbackAttachmentsScreenBloc, FeedbackAttachmentsScreenState>(
                bloc: _feedbackAttachmentsScreenBloc,
                listener: (context, state) async {
                  final feedbackAttachmentsState = state.attachmentState;

                  if (feedbackAttachmentsState is ErrorAttachmentsState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SeniorSnackBar.error(
                        message: context.translate.errorDownloadAttachment,
                      ),
                    );
                  }

                  if (feedbackAttachmentsState is ErrorNativePermissionStorageState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SeniorSnackBar.error(
                        message: context.translate.errorPermissionStorage,
                      ),
                    );
                  }

                  if (feedbackAttachmentsState is LoadedAttachmentsState) {
                    final fileToShare = await FileHelper.bytesToFile(
                      bytes: feedbackAttachmentsState.fileBytes,
                      fileName: feedbackAttachmentsState.fileName,
                    );

                    _feedbackAttachmentsScreenBloc.attachmentsBloc.add(
                      ShareAttachmentEvent(
                        file: fileToShare.path,
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  return Scrollbar(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: widget.feedbackEntity.attachments!.length,
                      itemBuilder: (_, index) {
                        return SeniorMenuItemList(
                          leftPadding: SeniorSpacing.normal,
                          rightPadding: SeniorSpacing.normal,
                          leading: const SeniorIcon(
                            icon: FontAwesomeIcons.fileArrowDown,
                            size: SeniorSpacing.medium,
                          ),
                          title: widget.feedbackEntity.attachments![index].name,
                          enabled: true,
                          onTap: () => _feedbackAttachmentsScreenBloc.attachmentsBloc.add(
                            DownloadAttachmentEvent(
                              attachmentEntity: widget.feedbackEntity.attachments![index],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getName() {
    if (widget.feedbackEntity.feedbackType == FeedbackTypeEnum.received) {
      return widget.feedbackEntity.fromName;
    }

    return widget.feedbackEntity.toName;
  }

  String _getPhotoUrl() {
    if (widget.feedbackEntity.feedbackType == FeedbackTypeEnum.received) {
      return widget.feedbackEntity.fromPhotoUrl;
    }

    return widget.feedbackEntity.toPhotoUrl;
  }
}
