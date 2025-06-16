import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../core/extension/media_query_extension.dart';
import '../../../../../core/extension/translate_extension.dart';
import '../../../../../core/widgets/waapi_colorful_header.dart';
import '../../../../authorization/presenter/blocs/authorization_bloc/authorization_state.dart';
import '../../../domain/entities/social_comments_entity.dart';
import '../../bloc/social_comments/social_comments_bloc.dart';
import '../../bloc/social_comments/social_comments_state.dart';
import '../../bloc/social_screen/social_screen_bloc.dart';
import '../../widget/social_post_comment_item_widget.dart';
import '../../widget/social_write_comment_widget.dart';

class SocialAnswersScreen extends StatefulWidget {
  final SocialCommentsEntity comment;
  final Map<String, dynamic> urls;
  final SocialScreenBloc socialScreenBloc;
  final String postId;

  const SocialAnswersScreen({
    super.key,
    required this.comment,
    required this.urls,
    required this.socialScreenBloc,
    required this.postId,
  });

  @override
  State<SocialAnswersScreen> createState() => _SocialAnswersScreenState();
}

class _SocialAnswersScreenState extends State<SocialAnswersScreen> {
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    bool isDarkColor = Provider.of<ThemeRepository>(context).isDarkTheme();
    return WaapiColorfulHeader(
      titleLabel: context.translate.socialCommentReplies,
      body: Scaffold(
        backgroundColor: isDarkColor ? SeniorColors.grayscale90 : SeniorColors.grayscale0,
        body: Column(
          children: [
            Expanded(
              child: Scrollbar(
                controller: scrollController,
                child: SingleChildScrollView(
                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: SeniorSpacing.normal,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: SeniorSpacing.normal,
                          ),
                          child: SeniorText.label(context.translate.commentsTitle),
                        ),
                        BlocBuilder<SocialCommentsBloc, SocialCommentsState>(
                          bloc: widget.socialScreenBloc.socialCommentsBloc,
                          builder: (context, state) {
                            final comment = state.socialComments
                                .where(
                                  (comment) => comment.id == (widget.comment.parent ?? widget.comment.id),
                                )
                                .first;

                            return Column(
                              children: [
                                SocialPostCommentItemWidget(
                                  comment: comment,
                                  isPostAuthor: false,
                                  scroll: scrollController,
                                  showMoreAnswers: false,
                                  urls: widget.urls,
                                  socialScreenBloc: widget.socialScreenBloc,
                                  postId: widget.postId,
                                  canAnswer: false,
                                ),
                                const SizedBox(
                                  height: SeniorSpacing.xxhuge,
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            if ((widget.socialScreenBloc.authorizationBloc.state as LoadedAuthorizationState)
                .authorizationEntity
                .socialAuthorizationEntity
                .canPostComments)
              Padding(
                padding: EdgeInsets.only(bottom: context.bottomSize),
                child: SocialWriteCommentWidget(
                  isComment: false,
                  postId: widget.postId,
                  socialScreenBloc: widget.socialScreenBloc,
                  parentId: widget.comment.parent ?? widget.comment.id,
                  openWithFocus: true,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
