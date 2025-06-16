import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../core/enums/analytics/waapi_loading_size_enum.dart';
import '../../../../core/extension/translate_extension.dart';
import '../../../../core/helper/date_time_helper.dart';
import '../../../../core/widgets/waapi_loading_widget.dart';
import '../../../authorization/presenter/blocs/authorization_bloc/authorization_state.dart';
import '../../domain/entities/social_attachment_entity.dart';
import '../../domain/entities/social_profile_entity.dart';
import '../../domain/entities/social_space_entity.dart';
import '../../domain/intput_models/social_attachment_input_model.dart';
import '../../domain/intput_models/social_create_post_input_model.dart';
import '../../enums/file_origin_enum.dart';
import '../bloc/get_short_url_bloc/get_short_url_bloc.dart';
import '../bloc/get_short_url_bloc/get_short_url_state.dart';
import '../bloc/social_create_post/social_create_post_bloc.dart';
import '../bloc/social_create_post/social_create_post_event.dart';
import '../bloc/social_create_post/social_create_post_state.dart';
import '../bloc/social_current_profile/social_current_profile_bloc.dart';
import '../bloc/social_current_profile/social_current_profile_event.dart';
import '../bloc/social_current_profile/social_current_profile_state.dart';
import '../bloc/social_files/social_get_file_upload_bloc.dart';
import '../bloc/social_files/social_get_file_upload_event.dart';
import '../bloc/social_files/social_get_file_upload_state.dart';
import '../bloc/social_screen/social_screen_bloc.dart';
import '../screen/social_comment_editing_controller.dart';
import 'social_attachment_card_widget.dart';
import 'social_create_post_body_widget.dart';
import 'social_create_post_footer_widget.dart';
import 'social_create_post_header_widget.dart';

class SocialCreatePostWidget extends StatefulWidget {
  final SocialScreenBloc socialScreenBloc;
  final SocialSpaceEntity? spaceSelected;

  const SocialCreatePostWidget({
    super.key,
    required this.socialScreenBloc,
    this.spaceSelected,
  });

  @override
  State<SocialCreatePostWidget> createState() => _SocialCreatePostWidgetState();
}

class _SocialCreatePostWidgetState extends State<SocialCreatePostWidget> {
  final List<SocialAttachmentCardWidget> listAttachment = [];
  List<SocialAttachmentEntity> listAttachmentEntity = [];
  SocialCommentEditingController postTextController = SocialCommentEditingController();
  final TextEditingController dateController = TextEditingController();
  DateTime? dateSelected;
  String? hourSelected;
  SocialSpaceEntity? spaceSelected;
  bool restrictComments = false;
  bool isTextEmpty = true;

  bool hasLink = false;
  SocialProfileEntity? selectedSocialProfileEntity;

  @override
  void initState() {
    super.initState();
    postTextController.addListener(_validateText);
    spaceSelected = widget.spaceSelected;
    final profileState = widget.socialScreenBloc.socialCurrentProfileBloc.state;
    if (profileState is LoadedSocialCurrentProfileState && selectedSocialProfileEntity == null) {
      selectedSocialProfileEntity = profileState.profile;
    } else {
      widget.socialScreenBloc.socialCurrentProfileBloc.add(
        GetSocialCurrentProfileEvent(),
      );
    }
  }

  void _validateText() {
    setState(() {
      isTextEmpty = postTextController.text.isEmpty;
    });
  }

  @override
  void dispose() {
    postTextController.removeListener(_validateText);
    postTextController.dispose();
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeRepository>(context);
    return MultiBlocListener(
      listeners: [
        BlocListener<SocialGetFileUploadBloc, SocialGetFileUploadState>(
          bloc: widget.socialScreenBloc.fileUploadBloc,
          listener: (context, state) {
            if (state is ErrorSocialSendFileUploadState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SeniorSnackBar.error(
                  message: context.translate.errorPermissionStorage,
                ),
              );
            }
            if (state is LoadedSocialGetFileUploadState) {
              listAttachmentEntity.add(
                state.socialAttachmentEntity,
              );
              listAttachment.add(
                SocialAttachmentCardWidget(
                  delete: () async {},
                  width: 152,
                  height: 148,
                  file: state.socialAttachmentEntity.file!,
                  reading: false,
                  extension: state.socialAttachmentEntity.fileName.split('.').last,
                  fileName: state.socialAttachmentEntity.fileName,
                  fileSize: state.socialAttachmentEntity.fileSize,
                  imageProvider: FileImage(
                    state.socialAttachmentEntity.file!,
                    scale: 0.5,
                  ),
                ),
              );
              setState(() {});
            }
            if (state is DeleteSocialFileUploadState) {
              listAttachmentEntity.removeWhere(
                (element) => element.id == state.id,
              );
              setState(() {});
            }

            if (state is LoadedSocialSendFileUploadState) {
              getPostInputModel(
                listAttachment: state.socialAttachmentInputModelList,
              );
              widget.socialScreenBloc.socialCreatePostBloc.add(
                CreateSocialPostEvent(
                  socialCreatePostInputModel: getPostInputModel(
                    listAttachment: state.socialAttachmentInputModelList,
                  ),
                ),
              );
            }
          },
        ),
        BlocListener<SocialCurrentProfileBloc, SocialCurrentProfileState>(
          bloc: widget.socialScreenBloc.socialCurrentProfileBloc,
          listener: (context, state) {
            if (state is LoadedSocialCurrentProfileState && selectedSocialProfileEntity == null) {
              selectedSocialProfileEntity = state.profile;
            }
          },
        ),
        BlocListener<GetShortUrlBloc, GetShortUrlState>(
          bloc: widget.socialScreenBloc.shortUrlBloc,
          listener: (context, state) {
            if (state is SuccessGetShortUrlState) {
              for (var item in state.mapUrlShorterner.entries) {
                postTextController.text = postTextController.text.replaceAll(
                  item.key,
                  item.value,
                );
              }
            }
          },
        ),
        BlocListener<SocialCreatePostBloc, SocialCreatePostState>(
          bloc: widget.socialScreenBloc.socialCreatePostBloc,
          listener: (context, state) {
            if (state is CreatedSocialCreatePostState) {
              Modular.to.pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SeniorSnackBar.success(
                  message: context.translate.publicationCompletedMessage,
                ),
              );
            }

            if (state is ErrorSocialCreatePostState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SeniorSnackBar.error(
                  action: SeniorSnackBarAction(
                    label: context.translate.repeat,
                    onPressed: () => widget.socialScreenBloc.socialCreatePostBloc.add(
                      CreateSocialPostEvent(
                        socialCreatePostInputModel: getPostInputModel(),
                      ),
                    ),
                  ),
                  message: context.translate.publicationErroMessage,
                ),
              );
            }
          },
        ),
      ],
      child: BlocBuilder<SocialCurrentProfileBloc, SocialCurrentProfileState>(
        bloc: widget.socialScreenBloc.socialCurrentProfileBloc,
        builder: (context, state) {
          if (state is! LoadedSocialCurrentProfileState) {
            return WaapiLoadingWidget(
              waapiLoadingSizeEnum: WaapiLoadingSizeEnum.small,
            );
          }

          return BlocBuilder<SocialCreatePostBloc, SocialCreatePostState>(
            bloc: widget.socialScreenBloc.socialCreatePostBloc,
            builder: (context, state) {
              if (state is LoadingSocialCreatePostState) {
                return const Expanded(
                  child: Center(
                    child: WaapiLoadingWidget(
                      waapiLoadingSizeEnum: WaapiLoadingSizeEnum.small,
                    ),
                  ),
                );
              }

              final canPostFeed = (widget.socialScreenBloc.authorizationBloc.state as LoadedAuthorizationState)
                  .authorizationEntity
                  .socialAuthorizationEntity
                  .canPostFeed;

              return Expanded(
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SocialCreatePostHeaderWidget(
                        enablePublish: isTextEmpty || (spaceSelected == null && !canPostFeed),
                        restrictCommentsValue: restrictComments,
                        restrictComments: (bool? value) {
                          setState(() {
                            restrictComments = value ?? false;
                          });
                        },
                        onDateChanged: (DateTime date) {
                          setState(() {
                            dateSelected = date;
                          });
                        },
                        onHourChanged: (String hour) {
                          setState(() {
                            hourSelected = hour;
                          });
                        },
                        onSpaceChanged: (SocialSpaceEntity? space) {
                          setState(() {
                            spaceSelected = space;
                          });
                        },
                        onProfileChanged: (SocialProfileEntity profile) {
                          selectedSocialProfileEntity = profile;
                          setState(() {});
                        },
                        onPostPressed: () {
                          widget.socialScreenBloc.socialCreatePostBloc.add(
                            CreateSocialPostEvent(
                              socialCreatePostInputModel: getPostInputModel(),
                            ),
                          );
                        },
                        dateSelected: dateSelected,
                        hourSelected: hourSelected,
                        socialProfileEntity: selectedSocialProfileEntity!,
                        listAttachment: listAttachmentEntity,
                        socialScreenBloc: widget.socialScreenBloc,
                        dateController: dateController,
                        selectedSpace: spaceSelected,
                        isScheduled: isScheduled(),
                      ),
                      Expanded(
                        child: SocialCreatePostBodyWidget(
                          socialScreenBloc: widget.socialScreenBloc,
                          listAttachment: listAttachment,
                          postTextController: postTextController,
                          onTextChanged: (bool value) {
                            hasLink = value;
                            setState(() {});
                          },
                        ),
                      ),
                      Visibility(
                        visible: listAttachment.isNotEmpty,
                        child: Container(
                          height: 160,
                          width: double.infinity,
                          padding: EdgeInsets.zero,
                          decoration: BoxDecoration(
                            color: theme.isDarkTheme()
                                ? theme.theme.backdropTheme!.style!.bodyColor
                                : SeniorColors.pureWhite,
                          ),
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            scrollDirection: Axis.horizontal,
                            itemCount: listAttachment.length,
                            itemBuilder: (context, index) {
                              return SocialAttachmentCardWidget(
                                delete: () async {
                                  _showDialogDelete(
                                    context: context,
                                    socialGetFileUploadBloc: widget.socialScreenBloc.fileUploadBloc,
                                    index: index,
                                  );
                                },
                                width: 152,
                                height: 148,
                                file: listAttachment[index].file!,
                                reading: false,
                                extension: listAttachment[index].fileName.split('.').last,
                                fileName: listAttachment[index].fileName,
                                fileSize: listAttachment[index].fileSize,
                                imageProvider: FileImage(
                                  listAttachment[index].file!,
                                  scale: 0.5,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Center(
                        child: SocialCreatePostFooterWidget(
                          hasLink: hasLink,
                          socialScreenBloc: widget.socialScreenBloc,
                          posttextController: postTextController,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  bool isScheduled() {
    return hourSelected != null && hourSelected!.isNotEmpty && dateSelected != null;
  }

  Future<bool> _showDialogDelete({
    required BuildContext context,
    required SocialGetFileUploadBloc socialGetFileUploadBloc,
    required int index,
  }) async {
    var hasDeleted = false;
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return BlocBuilder<SocialGetFileUploadBloc, SocialGetFileUploadState>(
          bloc: socialGetFileUploadBloc,
          builder: (context, state) {
            return SeniorModal(
              title: context.translate.deleteAttachment,
              content: context.translate.uploadAgain,
              defaultAction: SeniorModalAction(
                label: context.translate.no,
                action: Modular.to.pop,
                busy: state is LoadingSocialGetFileUploadState,
              ),
              otherAction: SeniorModalAction(
                busy: state is LoadingSocialGetFileUploadState,
                label: context.translate.yes,
                action: () async {
                  hasDeleted = true;
                  Modular.to.pop();
                  var id = '';
                  if (state is LoadedSocialGetFileUploadState) {
                    id = state.socialAttachmentEntity.id;
                  }
                  socialGetFileUploadBloc.add(
                    DeleteFileUploadEvent(
                      fileOriginEnum:
                          state is LoadedSocialGetFileUploadState ? state.fileOriginEnum : FileOriginEnum.file,
                      fileUpload: state is LoadedSocialGetFileUploadState ? state.file : null,
                      id: id,
                    ),
                  );
                  listAttachment.removeAt(index);
                  setState(() {});
                },
                danger: true,
              ),
            );
          },
        );
      },
    );
    return hasDeleted;
  }

  SocialCreatePostInputModel getPostInputModel({List<SocialAttachmentInputModel> listAttachment = const []}) {
    return SocialCreatePostInputModel(
      profileId: selectedSocialProfileEntity!.id,
      text: postTextController.text,
      when: DateTimeHelper.formatDateTimeToIso8601(
        dateTime: (hourSelected != null && hourSelected!.isNotEmpty)
            ? DateTime(
                dateSelected!.year,
                dateSelected!.month,
                dateSelected!.day,
                int.parse(hourSelected!.split(':')[0]),
                int.parse(hourSelected!.split(':')[1]),
              )
            : DateTime.now(),
      ),
      space: spaceSelected?.permaname,
      blockedComment: restrictComments,
      attachments: listAttachment.isEmpty ? null : listAttachment,
      groups: const [],
    );
  }
}
