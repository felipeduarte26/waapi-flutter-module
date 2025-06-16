import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../core/extension/translate_extension.dart';
import '../../../../core/services/file/file_service/file_service.dart';
import '../../domain/intput_models/social_create_comment_intput_model.dart';
import '../../enums/file_origin_enum.dart';
import '../bloc/social_comments/social_comments_bloc.dart';
import '../bloc/social_comments/social_comments_event.dart';
import '../bloc/social_comments/social_comments_state.dart';
import '../bloc/social_files/social_get_file_upload_bloc.dart';
import '../bloc/social_files/social_get_file_upload_event.dart';
import '../bloc/social_files/social_get_file_upload_state.dart';
import '../bloc/social_hashtags/social_hashtags_event.dart';
import '../bloc/social_hashtags/social_hashtags_state.dart';
import '../bloc/social_mentions/social_mentions_event.dart';
import '../bloc/social_mentions/social_mentions_state.dart';
import '../bloc/social_screen/social_screen_bloc.dart';
import '../bloc/social_screen/social_screen_state.dart';
import '../screen/social_comment_editing_controller.dart';
import 'social_attachment_card_widget.dart';

class SocialWriteCommentWidget extends StatefulWidget {
  final bool isComment;
  final SocialScreenBloc socialScreenBloc;
  final String postId;
  final String? parentId;
  final bool openWithFocus;

  const SocialWriteCommentWidget({
    super.key,
    required this.isComment,
    required this.socialScreenBloc,
    required this.postId,
    required this.openWithFocus,
    this.parentId,
  });

  @override
  State<SocialWriteCommentWidget> createState() => _SocialWriteCommentWidgetState();
}

class _SocialWriteCommentWidgetState extends State<SocialWriteCommentWidget> {
  SocialCommentEditingController textController = SocialCommentEditingController();
  var commentFocus = FocusNode();
  var selectedTag = false;
  var selectedMention = false;
  final SeniorImageService _imageService = SeniorImageService();
  final _fileService = Modular.get<FileService>();
  var hasAttachment = false;
  var fileOriginEnum = FileOriginEnum.none;
  SocialAttachmentCardWidget? attachmentCardWidget;

  @override
  void initState() {
    super.initState();
    textController.addListener(() {
      setState(() {});
    });

    if (widget.openWithFocus) {
      commentFocus.requestFocus();
    }

    widget.socialScreenBloc.hashtagsBloc.add(
      ClearSocialHashtagsEvent(),
    );

    widget.socialScreenBloc.mentionsBloc.add(
      ClearSocialMentionsEvent(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeRepository = Provider.of<ThemeRepository>(context);
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
            } else {
              hasAttachment = false;
              fileOriginEnum = FileOriginEnum.none;
              if (state is LoadedSocialGetFileUploadState) {
                hasAttachment = true;
                fileOriginEnum = state.fileOriginEnum;
                attachmentCardWidget = SocialAttachmentCardWidget(
                  delete: () async {
                    var hasDeleted = await _showDialogDelete(
                      context: context,
                      socialGetFileUploadBloc: widget.socialScreenBloc.fileUploadBloc,
                    );
                    if (hasDeleted) {
                      hasAttachment = false;
                      attachmentCardWidget = null;
                    }
                    setState(() {});
                  },
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
                );
                setState(() {});
              }

              if (state is LoadedSocialSendFileUploadState) {
                widget.socialScreenBloc.socialCommentsBloc.add(
                  CreateSocialCommentEvent(
                    socialCreateCommentIntputModel: SocialCreateCommentIntputModel(
                      parentId: widget.parentId,
                      postId: widget.postId,
                      text: textController.text,
                      attachmentInptuModel: state.socialAttachmentInputModelList.first,
                    ),
                  ),
                );
                textController.clear();
                commentFocus.unfocus();
                widget.socialScreenBloc.fileUploadBloc.add(
                  DeleteFileUploadEvent(
                    fileOriginEnum: fileOriginEnum,
                    fileUpload: state.socialAttachmentInputModelList.first.file,
                    id: state.socialAttachmentInputModelList.first.objectId,
                  ),
                );
              }
            }
          },
        ),
      ],
      child: BlocBuilder<SocialScreenBloc, SocialScreenState>(
        bloc: widget.socialScreenBloc,
        builder: (context, state) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (state.hashtagsState is LoadedSocialHashtagsState && !selectedTag)
                Container(
                  decoration: BoxDecoration(
                    color: themeRepository.isDarkTheme()
                        ? themeRepository.theme.backdropTheme!.style!.bodyColor
                        : SeniorColors.pureWhite,
                    border: Border.all(
                      color: SeniorColors.grayscale30,
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(
                        SeniorRadius.huge,
                      ),
                      topRight: Radius.circular(
                        SeniorRadius.huge,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: SeniorSpacing.normal,
                    ),
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              selectedTag = true;
                              textController.text = textController.text.replaceRange(
                                textController.text.lastIndexOf(state.hashtagsState.searchTerm),
                                null,
                                state.hashtagsState.tags[index],
                              );
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: SeniorSpacing.small,
                              bottom: SeniorSpacing.small,
                            ),
                            child: Row(
                              children: [
                                SeniorIcon(
                                  icon: FontAwesomeIcons.solidHashtag,
                                  style: SeniorIconStyle(
                                    color: themeRepository.isDarkTheme()
                                        ? SeniorColors.primaryColor300
                                        : themeRepository.theme.primaryColor,
                                  ),
                                  size: SeniorIconSize.medium,
                                ),
                                const SizedBox(
                                  width: SeniorSpacing.xsmall,
                                ),
                                SeniorText.body(state.hashtagsState.tags[index]),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const Divider(
                        height: 0.5,
                      ),
                      itemCount: state.hashtagsState.tags.length,
                    ),
                  ),
                ),
              if (state.mentionsState is LoadedSocialMentionsState && !selectedMention)
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: themeRepository.isDarkTheme()
                        ? themeRepository.theme.backdropTheme!.style!.bodyColor
                        : SeniorColors.pureWhite,
                    border: Border.all(
                      color: SeniorColors.grayscale30,
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(SeniorRadius.huge),
                      topRight: Radius.circular(SeniorRadius.huge),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: SeniorSpacing.normal),
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              selectedMention = true;
                              textController.text = textController.text.replaceRange(
                                textController.text.lastIndexOf(state.mentionsState.searchTerm),
                                null,
                                state.mentionsState.mentions[index].userName,
                              );
                              textController.addMention(
                                mention: state.mentionsState.mentions[index],
                              );
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: SeniorSpacing.small,
                              bottom: SeniorSpacing.small,
                            ),
                            child: Row(
                              children: [
                                SeniorProfilePicture(
                                  name: state.mentionsState.mentions[index].name,
                                  radius: SeniorRadius.huge,
                                  imageProvider: state.mentionsState.mentions[index].avatarUrl == null ||
                                          state.mentionsState.mentions[index].avatarUrl!.isEmpty
                                      ? null
                                      : CachedNetworkImageProvider(state.mentionsState.mentions[index].avatarUrl!),
                                ),
                                const SizedBox(
                                  width: SeniorSpacing.xsmall,
                                ),
                                SeniorText.body(state.mentionsState.mentions[index].name),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const Divider(
                        height: 0.5,
                      ),
                      itemCount: state.mentionsState.mentions.length,
                    ),
                  ),
                ),
              Column(
                children: [
                  Visibility(
                    visible: hasAttachment,
                    child: Container(
                      height: 166,
                      width: double.infinity,
                      padding: EdgeInsets.zero,
                      decoration: BoxDecoration(
                        color: themeRepository.isDarkTheme() ? SeniorColors.pureBlack : SeniorColors.pureWhite,
                        boxShadow: const [
                          BoxShadow(
                            color: SeniorColors.grayscale30,
                            spreadRadius: 0,
                            blurRadius: SeniorSpacing.xxsmall,
                            offset: Offset(0, 5),
                          ),
                        ],
                        border: Border(
                          top: BorderSide(
                            color: themeRepository.isDarkTheme() ? SeniorColors.grayscale60 : SeniorColors.grayscale40,
                            width: 1.0,
                          ),
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(
                            SeniorSpacing.normal,
                          ),
                          topRight: Radius.circular(
                            SeniorSpacing.normal,
                          ),
                        ),
                      ),
                      child: attachmentCardWidget ?? const SizedBox(),
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: themeRepository.isDarkTheme() ? SeniorColors.grayscale70 : SeniorColors.grayscale30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          getFile(
                            context: context,
                            theme: themeRepository,
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(SeniorSpacing.medium),
                          child: SeniorIcon(
                            icon: FontAwesomeIcons.solidCirclePlus,
                            style: SeniorIconStyle(
                              color: themeRepository.isDarkTheme()
                                  ? SeniorColors.primaryColor300
                                  : SeniorServiceColor.getContrastAdjustedColorTheme(
                                      color: SeniorColors.primaryColor,
                                    ),
                            ),
                            size: SeniorIconSize.medium,
                          ),
                        ),
                      ),
                      Expanded(
                        child: SeniorTextField(
                          controller: textController,
                          focusNode: commentFocus,
                          hintText: widget.isComment ? context.translate.writeComment : context.translate.replyComment,
                          minLines: 1,
                          maxLines: 3,
                          onChanged: (text) {
                            if (text.contains('#')) {
                              widget.socialScreenBloc.hashtagsBloc.add(
                                GetSocialHashtagsEvent(
                                  query: text.split('#').last,
                                ),
                              );
                              setState(() {
                                selectedTag = false;
                              });
                            }

                            if (text.contains('@')) {
                              widget.socialScreenBloc.mentionsBloc.add(
                                GetSocialMentionsEvent(
                                  query: text.split('@').last,
                                ),
                              );
                              setState(() {
                                selectedMention = false;
                              });
                            }
                          },
                        ),
                      ),
                      BlocBuilder<SocialCommentsBloc, SocialCommentsState>(
                        bloc: widget.socialScreenBloc.socialCommentsBloc,
                        builder: (context, state) {
                          return InkWell(
                            onTap: textController.text.trim().isNotEmpty
                                ? () async {
                                    final fileUploadBlocState = widget.socialScreenBloc.fileUploadBloc.state;
                                    if (fileUploadBlocState is LoadedSocialGetFileUploadState) {
                                      widget.socialScreenBloc.fileUploadBloc.add(
                                        SendFileUploadEvent(
                                          fileOriginEnum: fileUploadBlocState.fileOriginEnum,
                                          fileUpload: fileUploadBlocState.file,
                                          socialAttachmentEntityList: [
                                            fileUploadBlocState.socialAttachmentEntity,
                                          ],
                                        ),
                                      );
                                    } else {
                                      widget.socialScreenBloc.socialCommentsBloc.add(
                                        CreateSocialCommentEvent(
                                          socialCreateCommentIntputModel: SocialCreateCommentIntputModel(
                                            parentId: widget.parentId,
                                            postId: widget.postId,
                                            text: textController.text,
                                          ),
                                        ),
                                      );
                                      textController.clear();
                                      commentFocus.unfocus();
                                    }
                                  }
                                : null,
                            child: Padding(
                              padding: const EdgeInsets.all(SeniorSpacing.normal),
                              child: SeniorIcon(
                                icon: FontAwesomeIcons.solidPaperPlane,
                                style: SeniorIconStyle(
                                  color: themeRepository.isDarkTheme()
                                      ? SeniorColors.primaryColor300
                                      : SeniorServiceColor.getContrastAdjustedColorTheme(
                                          color: SeniorColors.primaryColor,
                                        ),
                                ),
                                size: SeniorIconSize.small,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Future<bool> _showDialogDelete({
    required BuildContext context,
    required SocialGetFileUploadBloc socialGetFileUploadBloc,
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
                  socialGetFileUploadBloc.add(
                    DeleteFileUploadEvent(
                      fileOriginEnum:
                          state is LoadedSocialGetFileUploadState ? state.fileOriginEnum : FileOriginEnum.file,
                      fileUpload: state is LoadedSocialGetFileUploadState ? state.file : null,
                      id: state is LoadedSocialGetFileUploadState ? state.socialAttachmentEntity.id : '',
                    ),
                  );
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

  void getFile({
    required BuildContext context,
    required ThemeRepository theme,
  }) {
    SeniorBottomSheet.showDynamicBottomSheet(
      context: context,
      hasCloseButton: true,
      onTapCloseButton: Modular.to.pop,
      content: <Widget>[
        BlocBuilder<SocialGetFileUploadBloc, SocialGetFileUploadState>(
          bloc: widget.socialScreenBloc.fileUploadBloc,
          builder: (context, state) {
            return Column(
              children: [
                SeniorMenuItemList(
                  title: context.translate.camera,
                  style: _getSeniorMenuListItemStyle(
                    theme: theme,
                  ),
                  leading: SeniorIcon(
                    icon: FontAwesomeIcons.solidCamera,
                    style: SeniorIconStyle(
                      color: theme.isDarkTheme() ? SeniorColors.grayscale20 : SeniorColors.grayscale90,
                    ),
                    size: SeniorIconSize.medium,
                  ),
                  onTap: () {
                    _imageService.pickImageFromCamera(
                      context: context,
                      onCropImage: (croppedImage) {
                        widget.socialScreenBloc.fileUploadBloc.add(
                          GetFileUploadEvent(
                            fileUpload: File(croppedImage.path),
                            fileOriginEnum: FileOriginEnum.camera,
                          ),
                        );
                      },
                      onPermissionCameraDenied: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SeniorSnackBar.error(
                            message: context.translate.errorPermissionPhoto,
                          ),
                        );
                      },
                      onException: (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SeniorSnackBar.error(
                            message: context.translate.unableAccessFilePleaseAgain,
                          ),
                        );
                        setState(() {
                          Modular.to.pop();
                        });
                      },
                    );
                    setState(() {
                      Modular.to.pop();
                    });
                  },
                ),
                Divider(
                  color: theme.isDarkTheme() ? SeniorColors.grayscale60 : SeniorColors.grayscale30,
                ),
                SeniorMenuItemList(
                  title: context.translate.gallery,
                  style: _getSeniorMenuListItemStyle(
                    theme: theme,
                  ),
                  leading: SeniorIcon(
                    icon: FontAwesomeIcons.solidImage,
                    style: SeniorIconStyle(
                      color: theme.isDarkTheme() ? SeniorColors.grayscale20 : SeniorColors.grayscale90,
                    ),
                    size: SeniorIconSize.medium,
                  ),
                  onTap: () async {
                    await _imageService.pickImageFromGallery(
                      onException: (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SeniorSnackBar.error(
                            message: context.translate.unableAccessFilePleaseAgain,
                          ),
                        );
                        setState(() {
                          Modular.to.pop();
                        });
                      },
                      context: context,
                      onCropImage: (croppedImage) {
                        final fileimage = File(croppedImage.path);
                        widget.socialScreenBloc.fileUploadBloc.add(
                          GetFileUploadEvent(
                            fileUpload: fileimage,
                            fileOriginEnum: FileOriginEnum.gallery,
                          ),
                        );
                      },
                      onPermissionGalleryDenied: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SeniorSnackBar.error(
                            message: context.translate.errorPermissionGallery,
                          ),
                        );
                      },
                    );
                    setState(() {
                      Modular.to.pop();
                    });
                  },
                ),
                Divider(
                  color: theme.isDarkTheme() ? SeniorColors.grayscale60 : SeniorColors.grayscale30,
                ),
                SeniorMenuItemList(
                  style: _getSeniorMenuListItemStyle(
                    theme: theme,
                  ),
                  title: context.translate.file,
                  leading: SeniorIcon(
                    icon: FontAwesomeIcons.solidFileLines,
                    style: SeniorIconStyle(
                      color: theme.isDarkTheme() ? SeniorColors.grayscale20 : SeniorColors.grayscale90,
                    ),
                    size: SeniorIconSize.medium,
                  ),
                  onTap: () async {
                    final file = await _fileService.pickFile(
                      onException: (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SeniorSnackBar.error(
                            message: context.translate.unableAccessFilePleaseAgain,
                          ),
                        );
                        setState(() {
                          Modular.to.pop();
                        });
                      },
                      onPermissionDenied: () => ScaffoldMessenger.of(context).showSnackBar(
                        SeniorSnackBar.error(
                          message: context.translate.errorPermissionGallery,
                        ),
                      ),
                    );
                    widget.socialScreenBloc.fileUploadBloc.add(
                      GetFileUploadEvent(
                        fileOriginEnum: FileOriginEnum.file,
                        fileUpload: file!,
                      ),
                    );

                    setState(() {
                      Modular.to.pop();
                    });
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  SeniorMenuListItemStyle _getSeniorMenuListItemStyle({required ThemeRepository theme}) => SeniorMenuListItemStyle(
        pushIconColor: !theme.isDarkTheme() ? SeniorColors.grayscale90 : SeniorColors.grayscale20,
        subtitleColor: !theme.isDarkTheme() ? SeniorColors.grayscale90 : SeniorColors.grayscale30,
        titleColor: !theme.isDarkTheme() ? SeniorColors.grayscale90 : SeniorColors.grayscale30,
        iconColor: !theme.isDarkTheme() ? SeniorColors.grayscale70 : SeniorColors.grayscale20,
      );
}
