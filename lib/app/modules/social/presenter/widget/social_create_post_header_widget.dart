import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../core/extension/translate_extension.dart';
import '../../../authorization/presenter/blocs/authorization_bloc/authorization_state.dart';
import '../../domain/entities/social_attachment_entity.dart';
import '../../domain/entities/social_profile_entity.dart';
import '../../domain/entities/social_space_entity.dart';
import '../bloc/social_files/social_get_file_upload_event.dart';
import '../bloc/social_files/social_get_file_upload_state.dart';
import '../bloc/social_screen/social_screen_bloc.dart';
import 'social_create_post_config_widget.dart';

class SocialCreatePostHeaderWidget extends StatefulWidget {
  final SocialProfileEntity socialProfileEntity;
  final SocialScreenBloc socialScreenBloc;
  final List<SocialAttachmentEntity> listAttachment;
  final TextEditingController dateController;
  final ValueChanged<DateTime> onDateChanged;
  final ValueChanged<String> onHourChanged;
  final ValueChanged<SocialSpaceEntity?> onSpaceChanged;
  final ValueChanged<SocialProfileEntity> onProfileChanged;
  final SocialSpaceEntity? selectedSpace;
  final DateTime? dateSelected;
  final String? hourSelected;
  final ValueChanged<bool?> restrictComments;
  final bool restrictCommentsValue;
  final bool isScheduled;
  final VoidCallback onPostPressed;
  final bool enablePublish;

  const SocialCreatePostHeaderWidget({
    super.key,
    required this.socialProfileEntity,
    required this.socialScreenBloc,
    required this.listAttachment,
    required this.dateController,
    required this.onDateChanged,
    required this.onHourChanged,
    required this.restrictComments,
    this.dateSelected,
    this.hourSelected,
    required this.restrictCommentsValue,
    required this.isScheduled,
    required this.onSpaceChanged,
    this.selectedSpace,
    required this.onProfileChanged,
    required this.onPostPressed,
    required this.enablePublish,
  });

  @override
  State<SocialCreatePostHeaderWidget> createState() => _SocialCreatePostHeaderWidgetState();
}

class _SocialCreatePostHeaderWidgetState extends State<SocialCreatePostHeaderWidget> {
  SocialSpaceEntity? selectedSpace;
  var canPostFeed = false;
  String profileImage = '';
  String profileName = '';

  @override
  void initState() {
    selectedSpace = widget.selectedSpace;
    canPostFeed = (widget.socialScreenBloc.authorizationBloc.state as LoadedAuthorizationState)
        .authorizationEntity
        .socialAuthorizationEntity
        .canPostFeed;
    profileImage = widget.socialProfileEntity.avatarUrl ?? '';
    profileName = widget.socialProfileEntity.name;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkColor = Provider.of<ThemeRepository>(context).isDarkTheme();

    final theme = Provider.of<ThemeRepository>(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: SeniorSpacing.small,
          ),
          child: Row(
            children: [
              SeniorProfilePicture(
                radius: SeniorCircularElements.small,
                imageProvider: (profileImage != '') ? CachedNetworkImageProvider(profileImage) : null,
                name: profileName,
              ),
              const SizedBox(
                width: SeniorSpacing.small,
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    configPost(
                      context: context,
                      theme: theme,
                    );
                  },
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SeniorText.labelBold(
                              color: SeniorColors.grayscale90,
                              darkColor: SeniorColors.grayscale5,
                              textProperties: const TextProperties(
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              widget.socialProfileEntity.name,
                            ),
                            const SizedBox(
                              width: SeniorSpacing.xxsmall,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (selectedSpace == null)
                                  SeniorIcon(
                                    icon: FontAwesomeIcons.solidEarthAmericas,
                                    size: SeniorSpacing.normal,
                                    style: SeniorIconStyle(
                                      color: isDarkColor ? SeniorColors.grayscale40 : SeniorColors.grayscale90,
                                    ),
                                  ),
                                if (selectedSpace == null)
                                  const SizedBox(
                                    width: SeniorSpacing.xxsmall,
                                  ),
                                Expanded(
                                  child: SeniorText.small(
                                    color: SeniorColors.grayscale90,
                                    darkColor: SeniorColors.grayscale5,
                                    selectedSpace != null
                                        ? context.translate.inPlace(selectedSpace!.name)
                                        : canPostFeed
                                            ? context.translate.public
                                            : context.translate.noGroupDefined,
                                    textProperties: const TextProperties(
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                    style: selectedSpace != null && canPostFeed
                                        ? null
                                        : const TextStyle(
                                            fontStyle: FontStyle.italic,
                                          ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SeniorIcon(
                        icon: FontAwesomeIcons.solidChevronDown,
                        size: SeniorSpacing.normal,
                        style: SeniorIconStyle(
                          color: isDarkColor ? SeniorColors.grayscale5 : SeniorColors.grayscale90,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: SeniorSpacing.normal,
              ),
              SeniorButton.primary(
                label: context.translate.publish,
                disabled: widget.enablePublish,
                onPressed: () {
                  final fileUploadBlocState = widget.socialScreenBloc.fileUploadBloc.state;
                  if (fileUploadBlocState is LoadedSocialGetFileUploadState) {
                    widget.socialScreenBloc.fileUploadBloc.add(
                      SendFileUploadEvent(
                        fileOriginEnum: fileUploadBlocState.fileOriginEnum,
                        fileUpload: fileUploadBlocState.file,
                        socialAttachmentEntityList: widget.listAttachment,
                      ),
                    );
                  } else {
                    widget.onPostPressed();
                  }
                },
              ),
            ],
          ),
        ),
        const Divider(
          color: SeniorColors.grayscale30,
          thickness: 1,
        ),
      ],
    );
  }

  void configPost({
    required BuildContext context,
    required ThemeRepository theme,
  }) {
    SeniorBottomSheet.showDynamicBottomSheet(
      context: context,
      hasCloseButton: true,
      onTapCloseButton: Modular.to.pop,
      content: <Widget>[
        SocialPostConfigWidget(
          socialScreenBloc: widget.socialScreenBloc,
          onProfileChanged: (profile) {
            profileImage = profile.avatarUrl ?? '';
            profileName = profile.name;
            widget.onProfileChanged(profile);
            setState(() {});
          },
          onDateChanged: widget.onDateChanged,
          onHourChanged: widget.onHourChanged,
          dateSelected: widget.dateSelected,
          hourSelected: widget.hourSelected,
          selectedSpace: selectedSpace,
          restrictComments: widget.restrictComments,
          restrictCommentsValue: widget.restrictCommentsValue,
          isScheduled: widget.isScheduled,
          onSpaceChanged: (space) {
            selectedSpace = space;
            if (selectedSpace != null) {
              widget.onSpaceChanged(space!);
            }
            setState(() {});
          },
          socialProfileEntity: widget.socialProfileEntity,
        ),
      ],
    );
  }
}
