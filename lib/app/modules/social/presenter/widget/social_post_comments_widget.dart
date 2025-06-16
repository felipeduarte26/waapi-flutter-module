import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../core/enums/analytics/waapi_loading_size_enum.dart';
import '../../../../core/extension/translate_extension.dart';
import '../../../../core/widgets/waapi_loading_widget.dart';
import '../../../authorization/presenter/blocs/authorization_bloc/authorization_state.dart';
import '../../domain/entities/social_post_entity.dart';
import '../bloc/social_comments/social_comments_bloc.dart';
import '../bloc/social_comments/social_comments_event.dart';
import '../bloc/social_comments/social_comments_state.dart';
import '../bloc/social_screen/social_screen_bloc.dart';
import 'social_post_comment_item_widget.dart';
import 'social_post_empty_comments_widget.dart';

class SocialPostCommentsWidget extends StatefulWidget {
  final SocialPostEntity socialPostEntity;
  final Map<String, dynamic> urls;
  final SocialScreenBloc socialScreenBloc;

  const SocialPostCommentsWidget({
    Key? key,
    required this.socialPostEntity,
    required this.urls,
    required this.socialScreenBloc,
  }) : super(key: key);

  @override
  State<SocialPostCommentsWidget> createState() => _SocialPostCommentsWidgetState();
}

class _SocialPostCommentsWidgetState extends State<SocialPostCommentsWidget> {
  final ScrollController scrollController = ScrollController();
  late bool canReply;

  @override
  void initState() {
    super.initState();
    _getComments();
    canReply = (widget.socialScreenBloc.authorizationBloc.state as LoadedAuthorizationState)
        .authorizationEntity
        .socialAuthorizationEntity
        .canPostComments;
  }

  void _getComments() {
    widget.socialScreenBloc.socialCommentsBloc.add(
      GetSocialCommentsEvent(
        postId: widget.socialPostEntity.id,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SocialCommentsBloc, SocialCommentsState>(
      bloc: widget.socialScreenBloc.socialCommentsBloc,
      builder: (context, state) {
        if (state is LoadingSocialCommentsState) {
          return const Center(
            child: WaapiLoadingWidget(
              waapiLoadingSizeEnum: WaapiLoadingSizeEnum.small,
            ),
          );
        }

        if (state is LoadedSocialCommentsState) {
          return GlowingOverscrollIndicator(
            axisDirection: AxisDirection.down,
            color: SeniorColors.primaryColor500,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: SeniorSpacing.normal,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SeniorText.label(context.translate.commentsTitle),
                  Visibility(
                    visible: state.socialComments.isNotEmpty,
                    replacement: const SocialPostEmptyCommentsWidget(),
                    child: ListView.builder(
                      padding: const EdgeInsets.only(
                        bottom: SeniorSpacing.xmedium,
                      ),
                      controller: scrollController,
                      itemCount: state.socialComments.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return SocialPostCommentItemWidget(
                          comment: state.socialComments[index],
                          isPostAuthor: widget.socialPostEntity.isAuthor,
                          scroll: scrollController,
                          showMoreAnswers: true,
                          urls: widget.urls,
                          socialScreenBloc: widget.socialScreenBloc,
                          postId: widget.socialPostEntity.id,
                        );
                      },
                    ),
                  ),
                  if (canReply)
                    const SizedBox(
                      height: SeniorSpacing.xxhuge,
                    ),
                ],
              ),
            ),
          );
        }

        return const SocialPostEmptyCommentsWidget();
      },
    );
  }
}
