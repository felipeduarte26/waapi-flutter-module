import 'dart:io';


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../core/extension/translate_extension.dart';
import '../../../../core/helper/string_helper.dart';
import '../../../../core/services/file/file_service/file_service.dart';
import '../../../authorization/presenter/blocs/authorization_bloc/authorization_state.dart';
import '../../enums/file_origin_enum.dart';
import '../../enums/social_view_key_enum.dart';
import '../bloc/get_short_url_bloc/get_short_url_bloc.dart';
import '../bloc/get_short_url_bloc/get_short_url_event.dart';
import '../bloc/get_short_url_bloc/get_short_url_state.dart';
import '../bloc/social_files/social_get_file_upload_bloc.dart';
import '../bloc/social_files/social_get_file_upload_event.dart';
import '../bloc/social_files/social_get_file_upload_state.dart';
import '../bloc/social_screen/social_screen_bloc.dart';
import '../screen/social_comment_editing_controller.dart';
import 'social_attachment_card_widget.dart';

class SocialCreatePostFooterWidget extends StatefulWidget {
  final SocialScreenBloc socialScreenBloc;
  final SocialCommentEditingController posttextController;
  final bool hasLink;

  const SocialCreatePostFooterWidget({
    super.key,
    required this.socialScreenBloc,
    required this.posttextController,
    required this.hasLink,
  });

  @override
  State<SocialCreatePostFooterWidget> createState() => _SocialCreatePostFooterWidgetState();
}

class _SocialCreatePostFooterWidgetState extends State<SocialCreatePostFooterWidget> {
  final SeniorImageService _imageService = SeniorImageService();
  final _fileService = Modular.get<FileService>();
  var hasAttachment = false;
  var fileOriginEnum = FileOriginEnum.none;
  SocialAttachmentCardWidget? attachmentCardWidget;
  late AuthorizationState authorization;
  bool authorizationAttachment = false;
  bool showMessageShortenedLink = false;

  @override
  void initState() {
    super.initState();
    authorization = widget.socialScreenBloc.authorizationBloc.state;
    if (authorization is LoadedAuthorizationState) {
      authorizationAttachment = (authorization as LoadedAuthorizationState)
          .authorizationEntity
          .socialAuthorizationEntity
          .canDownloadAttachmentsPostComments;
    }

    widget.socialScreenBloc.shortUrlBloc.add(
      ShowMessageShortenLinksEvent(
        showMessageShortenLink: showMessageShortenedLink,
        socialViewKeyEnum: SocialViewKeyEnum.showMessageShortenLinkKey,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkColor = Provider.of<ThemeRepository>(context).isDarkTheme();
    final theme = Provider.of<ThemeRepository>(context);
    return BlocListener<GetShortUrlBloc, GetShortUrlState>(
      bloc: widget.socialScreenBloc.shortUrlBloc,
      listener: (context, state) {
        if (state is ShowMessageShortenLinksState) {
          showMessageShortenedLink = !state.showMessageShortenLinks;
        }
      },
      child: Column(
        children: [
          const Divider(
            color: SeniorColors.grayscale30,
            thickness: 1,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: SeniorSpacing.xxsmall,
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      if (authorizationAttachment) {
                        getMidia(
                          context: context,
                          theme: theme,
                        );
                      }
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SeniorIcon(
                          icon: FontAwesomeIcons.solidPhotoFilm,
                          style: SeniorIconStyle(
                            color: !authorizationAttachment
                                ? SeniorColors.grayscale20
                                : isDarkColor
                                    ? SeniorColors.grayscale40
                                    : SeniorColors.grayscale50,
                          ),
                          size: SeniorSpacing.xmedium,
                        ),
                        const SizedBox(
                          height: SeniorSpacing.xxsmall,
                        ),
                        SeniorText.small(
                          context.translate.media,
                          darkColor: SeniorColors.grayscale10,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      if (authorizationAttachment) {
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

                        setState(() {});
                      }
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SeniorIcon(
                          icon: FontAwesomeIcons.solidFile,
                          style: SeniorIconStyle(
                            color: !authorizationAttachment
                                ? SeniorColors.grayscale20
                                : isDarkColor
                                    ? SeniorColors.grayscale40
                                    : SeniorColors.grayscale50,
                          ),
                          size: SeniorSpacing.xmedium,
                        ),
                        const SizedBox(
                          height: SeniorSpacing.xxsmall,
                        ),
                        SeniorText.small(
                          context.translate.file,
                          darkColor: SeniorColors.grayscale10,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: BlocBuilder<GetShortUrlBloc, GetShortUrlState>(
                    bloc: widget.socialScreenBloc.shortUrlBloc,
                    builder: (context, state) {
                      return GestureDetector(
                        onTap: () async {
                          if (widget.hasLink) {
                            if (showMessageShortenedLink) {
                              await replaceLinks(
                                text: widget.posttextController.text,
                                getShortUrlBloc: widget.socialScreenBloc.shortUrlBloc,
                                context: context,
                              );
                            } else {
                              await _showDialogShortLink(
                                context: context,
                                getShortUrlBloc: widget.socialScreenBloc.shortUrlBloc,
                              );
                            }
                          }
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SeniorIcon(
                              icon: FontAwesomeIcons.solidLink,
                              style: SeniorIconStyle(
                                color: !widget.hasLink
                                    ? SeniorColors.grayscale20
                                    : isDarkColor
                                        ? SeniorColors.grayscale40
                                        : SeniorColors.grayscale50,
                              ),
                              size: SeniorSpacing.xmedium,
                            ),
                            const SizedBox(
                              height: SeniorSpacing.xxsmall,
                            ),
                            SeniorText.small(
                              context.translate.shortener,
                              darkColor: SeniorColors.grayscale10,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> replaceLinks({
    required String text,
    required GetShortUrlBloc getShortUrlBloc,
    required BuildContext context,
  }) async {
    final links = StringHelper.extractLinks(text);

    if (links.isNotEmpty) {
      getShortUrlBloc.add(
        GetShortUrl(
          listUrl: links,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SeniorSnackBar.error(
          message: context.translate.errorPermissionStorage,
        ),
      );
    }
  }

  void getMidia({
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

  Future<void> _showDialogShortLink({
    required BuildContext context,
    required GetShortUrlBloc getShortUrlBloc,
  }) async {
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return BlocBuilder<GetShortUrlBloc, GetShortUrlState>(
          bloc: getShortUrlBloc,
          builder: (context, state) {
            return SeniorModal(
              checkboxdisableLayoutBuilder: true,
              checkboxActionOnTitle: true,
              checkboxVisible: showMessageShortenedLink,
              checkboxValue: showMessageShortenedLink,
              checkboxTitle: context.translate.noShowAgainAction,
              checkboxOnChanged: (value) async {
                getShortUrlBloc.add(
                  SaveDontShowMessageShortenLinkEvent(
                    showMessageShortenLink: value!,
                    socialViewKeyEnum: SocialViewKeyEnum.showMessageShortenLinkKey,
                  ),
                );
                showMessageShortenedLink = value;
              },
              title: context.translate.shortenPublicationLinks,
              content: context.translate.allLinksPublicationAutomaticallyShortened,
              defaultAction: SeniorModalAction(
                label: context.translate.no,
                action: Modular.to.pop,
                busy: state is LoadingSocialGetFileUploadState,
              ),
              otherAction: SeniorModalAction(
                busy: state is LoadingSocialGetFileUploadState,
                label: context.translate.yes,
                action: () async {
                  await replaceLinks(
                    text: widget.posttextController.text,
                    getShortUrlBloc: widget.socialScreenBloc.shortUrlBloc,
                    context: context,
                  );
                  Modular.to.pop();
                },
                danger: true,
              ),
            );
          },
        );
      },
    );
  }

  SeniorMenuListItemStyle _getSeniorMenuListItemStyle({required ThemeRepository theme}) => SeniorMenuListItemStyle(
        pushIconColor: !theme.isDarkTheme() ? SeniorColors.grayscale90 : SeniorColors.grayscale20,
        subtitleColor: !theme.isDarkTheme() ? SeniorColors.grayscale90 : SeniorColors.grayscale30,
        titleColor: !theme.isDarkTheme() ? SeniorColors.grayscale90 : SeniorColors.grayscale30,
        iconColor: !theme.isDarkTheme() ? SeniorColors.grayscale70 : SeniorColors.grayscale20,
      );
}
