import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../core/extension/translate_extension.dart';
import '../../../../core/helper/string_helper.dart';
import '../bloc/social_hashtags/social_hashtags_event.dart';
import '../bloc/social_hashtags/social_hashtags_state.dart';
import '../bloc/social_mentions/social_mentions_event.dart';
import '../bloc/social_mentions/social_mentions_state.dart';
import '../bloc/social_screen/social_screen_bloc.dart';
import '../bloc/social_screen/social_screen_state.dart';
import '../screen/social_comment_editing_controller.dart';
import 'social_attachment_card_widget.dart';

const sizeWithAttachment = 0.54;
const sizeWithoutAttachment = 0.72;

class SocialCreatePostBodyWidget extends StatefulWidget {
  final SocialScreenBloc socialScreenBloc;
  final List<SocialAttachmentCardWidget> listAttachment;
  final SocialCommentEditingController postTextController;
  final ValueChanged<bool> onTextChanged;

  const SocialCreatePostBodyWidget({
    super.key,
    required this.socialScreenBloc,
    required this.listAttachment,
    required this.postTextController,
    required this.onTextChanged,
  });

  @override
  State<SocialCreatePostBodyWidget> createState() => _SocialCreatePostBodyWidgetState();
}

class _SocialCreatePostBodyWidgetState extends State<SocialCreatePostBodyWidget> {
  var commentFocus = FocusNode();
  var selectedTag = false;
  var selectedMention = false;

  @override
  void initState() {
    super.initState();

    widget.postTextController.addListener(() {
      setState(() {});
    });

    widget.socialScreenBloc.hashtagsBloc.add(
      ClearSocialHashtagsEvent(),
    );

    widget.socialScreenBloc.mentionsBloc.add(
      ClearSocialMentionsEvent(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeRepository>(context);

    return BlocBuilder<SocialScreenBloc, SocialScreenState>(
      bloc: widget.socialScreenBloc,
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (state.hashtagsState is LoadedSocialHashtagsState && !selectedTag)
                Container(
                  decoration: BoxDecoration(
                    color: theme.isDarkTheme() ? theme.theme.backdropTheme!.style!.bodyColor : SeniorColors.pureWhite,
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
                        return Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                selectedTag = true;
                                widget.postTextController.text = widget.postTextController.text.replaceRange(
                                  widget.postTextController.text.lastIndexOf(state.hashtagsState.searchTerm),
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
                                    style: theme.theme.themeType != ThemeType.custom
                                        ? SeniorIconStyle(
                                            color: theme.isDarkTheme()
                                                ? SeniorColors.primaryColor300
                                                : SeniorColors.primaryColor,
                                          )
                                        : null,
                                    size: SeniorIconSize.medium,
                                  ),
                                  const SizedBox(
                                    width: SeniorSpacing.xsmall,
                                  ),
                                  SeniorText.body(state.hashtagsState.tags[index]),
                                ],
                              ),
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: SeniorSpacing.normal),
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              selectedMention = true;
                              widget.postTextController.text = widget.postTextController.text.replaceRange(
                                widget.postTextController.text.lastIndexOf(state.mentionsState.searchTerm),
                                null,
                                state.mentionsState.mentions[index].userName,
                              );
                              widget.postTextController.addMention(
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
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const Divider(
                      height: 0.5,
                    ),
                    itemCount: state.mentionsState.mentions.length,
                  ),
                ),
              SeniorTextField(
                border: InputBorder.none,
                style: SeniorTextFieldStyle(
                  fillColor: theme.isDarkTheme() ? theme.theme.backdropTheme!.style!.bodyColor : SeniorColors.pureWhite,
                ),
                controller: widget.postTextController,
                focusNode: commentFocus,
                hintText: context.translate.writeAboutWhatyoupublish,
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
                  setState(() {
                    widget.onTextChanged(StringHelper.extractLinks(text).isNotEmpty);
                  });
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
