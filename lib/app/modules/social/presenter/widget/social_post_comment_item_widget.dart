import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../core/extension/media_query_extension.dart';
import '../../../../core/extension/translate_extension.dart';
import '../../../../core/helper/date_time_helper.dart';
import '../../../../core/helper/locale_helper.dart';
import '../../../../core/helper/string_helper.dart';
import '../../../../routes/social_routers.dart';
import '../../../authorization/presenter/blocs/authorization_bloc/authorization_state.dart';
import '../../domain/entities/social_comments_entity.dart';
import '../../domain/entities/social_profile_entity.dart';
import '../bloc/social_comments/social_comments_bloc.dart';
import '../bloc/social_comments/social_comments_event.dart';
import '../bloc/social_comments/social_comments_state.dart';
import '../bloc/social_profile_photo/read_profile_photo_url_bloc.dart';
import '../bloc/social_profile_photo/read_profile_photo_url_state.dart';
import '../bloc/social_screen/social_screen_bloc.dart';
import 'social_comment_likes_bottom_sheet_view_widget.dart';
import 'social_post_attachments_widget.dart';
import 'social_post_body_content_widget.dart';

class SocialPostCommentItemWidget extends StatefulWidget {
  final SocialCommentsEntity comment;
  final bool isPostAuthor;
  final String postId;
  final Map<String, dynamic> urls;
  final ScrollController scroll;
  final bool showMoreAnswers;
  final SocialScreenBloc socialScreenBloc;
  final bool canAnswer;

  const SocialPostCommentItemWidget({
    super.key,
    required this.comment,
    required this.isPostAuthor,
    required this.postId,
    required this.urls,
    required this.scroll,
    required this.showMoreAnswers,
    required this.socialScreenBloc,
    this.canAnswer = true,
  });

  @override
  State<SocialPostCommentItemWidget> createState() => _SocialPostCommentItemWidgetState();
}

class _SocialPostCommentItemWidgetState extends State<SocialPostCommentItemWidget> {
  late bool canLike;
  late bool canReply;
  bool isLiked = false;
  bool likeIsBlocked = false;

  @override
  void initState() {
    super.initState();
    isLiked = widget.comment.gotMyLike;

    canLike = (widget.socialScreenBloc.authorizationBloc.state as LoadedAuthorizationState)
        .authorizationEntity
        .socialAuthorizationEntity
        .canLikeComments;

    canReply = (widget.socialScreenBloc.authorizationBloc.state as LoadedAuthorizationState)
        .authorizationEntity
        .socialAuthorizationEntity
        .canPostComments;
  }

  void _setSocialLikeComment({
    required String commentId,
    required bool isLiked,
    String? answerId,
  }) {
    widget.socialScreenBloc.socialCommentsBloc.add(
      SetSocialLikeCommentEvent(
        commentId: commentId,
        isLiked: isLiked,
        answerId: answerId,
      ),
    );
  }

  void Function() _onTapProfile({required SocialProfileEntity author}) {
    return () {
      Modular.to.pushNamed(
        SocialRouters.socialProfileInitialRoute,
        arguments: {
          'permaname': author.permaname,
        },
      );
    };
  }

  @override
  Widget build(BuildContext context) {
    final themeRepository = Provider.of<ThemeRepository>(context);
    bool isDarkColor = themeRepository.isDarkTheme();
    var url = widget.urls[widget.comment.author.id] ?? '';

    return MultiBlocListener(
      listeners: [
        BlocListener<ReadProfilePhotoURLBloc, ReadProfilePhotoURLState>(
          bloc: widget.socialScreenBloc.readProfilePhotoURLBloc,
          listener: (context, state) {
            if (state is LoadedReadProfilePhotoURLState) {
              url = widget.urls[widget.comment.author.id] ?? '';
              setState(() {});
            }
          },
        ),
        BlocListener<SocialCommentsBloc, SocialCommentsState>(
          bloc: widget.socialScreenBloc.socialCommentsBloc,
          listener: (context, state) {
            if (state is LoadedSocialLikeCommentState) {
              isLiked =
                  state.socialComments.where((comment) => comment.id == widget.comment.id).firstOrNull?.gotMyLike ??
                      widget.comment.gotMyLike;
              likeIsBlocked = false;
            }
          },
        ),
      ],
      child: Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: InkWell(
              onTap: _onTapProfile(
                author: widget.comment.author,
              ),
              child: SeniorProfilePicture(
                radius: SeniorCircularElements.small,
                imageProvider: url != ''
                    ? CachedNetworkImageProvider(
                        url,
                      )
                    : null,
                name: widget.comment.author.name,
              ),
            ),
            title: Container(
              color: isDarkColor ? SeniorColors.grayscale80 : SeniorColors.grayscale10,
              padding: const EdgeInsets.only(
                top: SeniorSpacing.xsmall,
                left: SeniorSpacing.xsmall,
                right: SeniorSpacing.xsmall,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: _onTapProfile(
                            author: widget.comment.author,
                          ),
                          child: SeniorText.bodyBold(
                            textProperties: const TextProperties(
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            widget.comment.author.name,
                            darkColor: SeniorColors.grayscale30,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: SeniorSpacing.xxsmall,
                      ),
                      Visibility(
                        visible: widget.comment.isAuthor,
                        child: SeniorText.small(
                          '(${context.translate.you})',
                          darkColor: SeniorColors.grayscale40,
                        ),
                      ),
                      Visibility(
                        visible: widget.isPostAuthor && !widget.comment.isAuthor,
                        child: SeniorText.small(
                          '(${context.translate.author})',
                          darkColor: SeniorColors.grayscale40,
                        ),
                      ),
                    ],
                  ),
                  SeniorText.small(
                    DateTimeHelper.formatElapsedTime(
                      appLocalizations: context.translate,
                      compareDate: widget.comment.when,
                      locale: LocaleHelper.languageAndCountryCode(
                        locale: Localizations.localeOf(context),
                      ),
                    ),
                    color: SeniorColors.grayscale70,
                    darkColor: SeniorColors.grayscale20,
                  ),
                  const SizedBox(
                    height: SeniorSpacing.xxsmall,
                  ),
                  if (widget.comment.edited)
                    Row(
                      children: [
                        SeniorBadge(
                          backgroundColor: isDarkColor ? SeniorColors.grayscale5 : SeniorColors.grayscale60,
                          fontColor: isDarkColor ? SeniorColors.grayscale90 : SeniorColors.grayscale0,
                          label: context.translate.edited,
                        ),
                      ],
                    ),
                  const SizedBox(
                    height: SeniorSpacing.xsmall,
                  ),
                ],
              ),
            ),
            subtitle: Container(
              color: isDarkColor ? SeniorColors.grayscale80 : SeniorColors.grayscale10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SocialPostBodyContentWidget(
                    text: widget.comment.text,
                    mentions: widget.comment.mentions,
                    hasImage: widget.comment.attachment != null,
                    themeRepository: themeRepository,
                    maxWidth: context.widthSize,
                    isComment: true,
                  ),
                  if (widget.comment.attachment != null)
                    SocialPostAttachmentsWidget(
                      attachments: [widget.comment.attachment!],
                      authorName: widget.comment.author.name,
                      fileType: widget.comment.attachment!.fileType,
                    ),
                ],
              ),
            ),
            isThreeLine: true,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: SeniorSpacing.huge,
            ),
            child: Row(
              children: [
                if (canLike)
                  Row(
                    children: [
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          splashColor: likeIsBlocked ? Colors.transparent : null,
                          hoverColor: likeIsBlocked ? Colors.transparent : null,
                          highlightColor: likeIsBlocked ? Colors.transparent : null,
                          borderRadius: BorderRadius.circular(SeniorRadius.huge),
                          onTap: () {
                            if (!likeIsBlocked) {
                              likeIsBlocked = true;
                              _setSocialLikeComment(
                                commentId: widget.comment.parent ?? widget.comment.id,
                                isLiked: !isLiked,
                                answerId: widget.comment.parent != null ? widget.comment.id : null,
                              );
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: SeniorSpacing.xsmall,
                            ),
                            child: SeniorText.small(
                              widget.comment.gotMyLike ? context.translate.liked : context.translate.like,
                              color: widget.comment.gotMyLike
                                  ? themeRepository.isCustomTheme()
                                      ? SeniorServiceColor.getContrastAdjustedColorTheme(
                                          color: themeRepository.theme.primaryColor!,
                                        )
                                      : SeniorColors.primaryColor500
                                  : SeniorColors.grayscale50,
                              darkColor:
                                  widget.comment.gotMyLike ? SeniorColors.primaryColor400 : SeniorColors.grayscale40,
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: widget.comment.likeCount > 0,
                        child: InkWell(
                          onTap: () => SocialCommentLikesBottomSheetViewWidget.showLikes(
                            context: context,
                            title: context.translate.peopleLikedComment,
                            profilesThatLiked: widget.comment.profilesThatLiked!,
                          ),
                          child: Row(
                            children: [
                              SeniorIcon(
                                icon: widget.comment.gotMyLike
                                    ? FontAwesomeIcons.solidThumbsUp
                                    : FontAwesomeIcons.thumbsUp,
                                style: SeniorIconStyle(
                                  color: widget.comment.gotMyLike
                                      ? isDarkColor
                                          ? SeniorColors.primaryColor400
                                          : themeRepository.theme.primaryColor!
                                      : isDarkColor
                                          ? SeniorColors.grayscale40
                                          : SeniorColors.grayscale50,
                                ),
                                size: SeniorSpacing.small,
                              ),
                              const SizedBox(
                                width: SeniorSpacing.xxsmall,
                              ),
                              SeniorText.small(
                                widget.comment.likeCount.toString(),
                                darkColor: SeniorColors.grayscale50,
                              ),
                              const SizedBox(
                                width: SeniorSpacing.xxsmall,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          right: SeniorSpacing.xsmall,
                        ),
                        child: SeniorText.small(
                          '|',
                          darkColor: SeniorColors.grayscale50,
                        ),
                      ),
                    ],
                  ),
                if (canReply)
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(SeniorRadius.huge),
                      onTap: widget.canAnswer
                          ? () {
                              Modular.to.pushNamed(
                                SocialRouters.socialAnswersScreenInitialRoute,
                                arguments: {
                                  'comment': widget.comment,
                                  'urls': widget.urls,
                                  'socialScreenBloc': widget.socialScreenBloc,
                                  'postId': widget.postId,
                                },
                              );
                            }
                          : null,
                      child: SeniorText.small(context.translate.socialCommentReply),
                    ),
                  ),
                Visibility(
                  visible: canReply && widget.comment.children != null && widget.comment.children!.isNotEmpty,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: SeniorSpacing.xsmall,
                    ),
                    child: Row(
                      children: [
                        SeniorText.small(
                          StringHelper.bulletPoint(),
                          darkColor: SeniorColors.grayscale50,
                        ),
                        const SizedBox(
                          width: SeniorSpacing.xxsmall,
                        ),
                        if (widget.comment.children != null && widget.comment.children!.isNotEmpty)
                          Row(
                            children: [
                              SeniorText.small(
                                widget.comment.children!.length.toString(),
                                darkColor: SeniorColors.grayscale50,
                              ),
                              const SizedBox(
                                width: SeniorSpacing.xxsmall,
                              ),
                            ],
                          ),
                        SeniorText.small(
                          widget.comment.children?.length == 1
                              ? context.translate.socialAnswer
                              : context.translate.socialAnswers,
                          darkColor: SeniorColors.grayscale50,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (widget.comment.children != null && widget.comment.children!.isNotEmpty)
            Column(
              children: [
                Visibility(
                  visible: widget.showMoreAnswers,
                  replacement: ListView.builder(
                    padding: EdgeInsets.zero,
                    controller: widget.scroll,
                    itemCount: widget.comment.children!.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                          top: SeniorSpacing.small,
                          left: SeniorSpacing.xxhuge + SeniorSpacing.xxsmall,
                        ),
                        child: SocialPostCommentItemWidget(
                          comment: widget.comment.children![index],
                          isPostAuthor: widget.comment.children![index].isAuthor,
                          urls: widget.urls,
                          scroll: widget.scroll,
                          showMoreAnswers: false,
                          socialScreenBloc: widget.socialScreenBloc,
                          postId: widget.postId,
                          canAnswer: widget.canAnswer,
                        ),
                      );
                    },
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: SeniorSpacing.small,
                      left: SeniorSpacing.xxhuge + SeniorSpacing.xxsmall,
                    ),
                    child: SocialPostCommentItemWidget(
                      comment: widget.comment.children!.first,
                      isPostAuthor: widget.comment.children!.first.isAuthor,
                      urls: widget.urls,
                      scroll: widget.scroll,
                      showMoreAnswers: false,
                      socialScreenBloc: widget.socialScreenBloc,
                      postId: widget.postId,
                      canAnswer: widget.canAnswer,
                    ),
                  ),
                ),
                if (widget.showMoreAnswers && widget.comment.children!.length > 1)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(SeniorRadius.huge),
                          child: Padding(
                            padding: const EdgeInsets.all(
                              SeniorSpacing.xsmall,
                            ),
                            child: SeniorText.bodyBold(
                              context.translate.socialShowMoreAnswers,
                              color: SeniorColors.primaryColor500,
                              darkColor: SeniorColors.primaryColor500,
                            ),
                          ),
                          onTap: () {
                            Modular.to.pushNamed(
                              SocialRouters.socialAnswersScreenInitialRoute,
                              arguments: {
                                'comment': widget.comment,
                                'urls': widget.urls,
                                'socialScreenBloc': widget.socialScreenBloc,
                                'postId': widget.postId,
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
              ],
            ),
        ],
      ),
    );
  }
}
