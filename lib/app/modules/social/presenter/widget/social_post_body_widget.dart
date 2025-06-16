import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../core/extension/media_query_extension.dart';
import '../../../../core/extension/translate_extension.dart';
import '../../../../routes/social_routers.dart';
import '../../domain/entities/social_post_entity.dart';
import '../bloc/social_like_bloc/social_like_bloc.dart';
import '../bloc/social_like_bloc/social_like_state.dart';
import '../bloc/social_screen/social_screen_bloc.dart';
import 'social_post_attachments_widget.dart';
import 'social_post_body_content_widget.dart';
import 'social_post_likes_bottom_sheet_view_widget.dart';

class SocialPostBodyWidget extends StatefulWidget {
  final SocialPostEntity socialPostEntity;
  final bool openComments;
  final ValueChanged<bool?> onLikeChanged;
  final SocialScreenBloc socialScreenBloc;
  final bool isFiltered;

  const SocialPostBodyWidget({
    super.key,
    required this.socialPostEntity,
    required this.openComments,
    required this.onLikeChanged,
    required this.socialScreenBloc,
    this.isFiltered = false,
  });

  @override
  State<SocialPostBodyWidget> createState() => _SocialPostBodyWidgetState();
}

class _SocialPostBodyWidgetState extends State<SocialPostBodyWidget> {
  @override
  Widget build(BuildContext context) {
    final themeRepository = Provider.of<ThemeRepository>(context);
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.zero,
                child: SocialPostBodyContentWidget(
                  text: widget.socialPostEntity.text,
                  mentions: widget.socialPostEntity.mentions,
                  hasImage: widget.socialPostEntity.attachments?.isNotEmpty ?? false,
                  themeRepository: themeRepository,
                  maxWidth: context.widthSize,
                  isComment: false,
                ),
              ),
            ),
          ],
        ),
        if (widget.socialPostEntity.attachments?.isNotEmpty ?? false)
          SocialPostAttachmentsWidget(
            attachments: widget.socialPostEntity.attachments!,
            authorName: widget.socialPostEntity.author.name,
            fileType:
                widget.socialPostEntity.attachment?.fileType ?? widget.socialPostEntity.attachments!.first.fileType,
          ),
        BlocBuilder<SocialLikeBloc, SocialLikeState>(
          bloc: widget.socialScreenBloc.socialLikeBloc,
          builder: (context, state) {
            final post = state.posts.where((post) => post.id == widget.socialPostEntity.id).firstOrNull ??
                widget.socialPostEntity;

            return Visibility(
              visible: post.likeCount > 0 || post.commentCount > 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: SeniorSpacing.normal,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Visibility(
                          visible: post.likeCount > 0,
                          child: InkWell(
                            onTap: () {
                              setState(() {});
                              SocialPostLikesBottomSheetViewWidget.showLikes(
                                context: context,
                                title: context.translate.peopleLikedPost,
                                postId: widget.socialPostEntity.id,
                              );
                            },
                            child: Row(
                              children: [
                                SeniorIcon(
                                  icon: FontAwesomeIcons.thumbsUp,
                                  style: SeniorIconStyle(
                                    color: themeRepository.isDarkTheme()
                                        ? SeniorColors.grayscale40
                                        : SeniorColors.grayscale50,
                                  ),
                                  size: SeniorSpacing.medium,
                                ),
                                const SizedBox(
                                  width: SeniorSpacing.xsmall,
                                ),
                                SeniorText.body(
                                  post.likeCount.toString(),
                                  darkColor: SeniorColors.grayscale50,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Visibility(
                          visible: post.commentCount > 0,
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(SeniorRadius.huge),
                              onTap: widget.openComments
                                  ? () {
                                      Modular.to.pushNamed(
                                        SocialRouters.socialCommentsScreenInitialRoute,
                                        arguments: {
                                          'post': widget.socialPostEntity,
                                          'onLikeChanged': widget.onLikeChanged,
                                          'socialScreenBloc': widget.socialScreenBloc,
                                          'openWithFocus': false,
                                        },
                                      );
                                    }
                                  : null,
                              child: Padding(
                                padding: const EdgeInsets.all(
                                  SeniorSpacing.xsmall,
                                ),
                                child: SeniorText.body(
                                  '${post.commentCount} ${post.commentCount == 1 ? context.translate.socialComment : context.translate.comments}',
                                  darkColor: SeniorColors.grayscale50,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
