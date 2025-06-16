// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../core/enums/analytics/waapi_loading_size_enum.dart';
import '../../../../../core/extension/translate_extension.dart';
import '../../../../../core/widgets/waapi_colorful_header.dart';
import '../../../../../core/widgets/waapi_loading_widget.dart';
import '../../../../authorization/domain/entities/social_authorization_entity.dart';
import '../../../../authorization/presenter/blocs/authorization_bloc/authorization_state.dart';
import '../../../domain/entities/social_comments_entity.dart';
import '../../../domain/entities/social_post_entity.dart';
import '../../bloc/social_comments/social_comments_bloc.dart';
import '../../bloc/social_comments/social_comments_event.dart';
import '../../bloc/social_comments/social_comments_state.dart';
import '../../bloc/social_feed/social_feed_state.dart';
import '../../bloc/social_profile_photo/read_profile_photo_url_bloc.dart';
import '../../bloc/social_profile_photo/read_profile_photo_url_event.dart';
import '../../bloc/social_profile_photo/read_profile_photo_url_state.dart';
import '../../bloc/social_screen/social_screen_bloc.dart';
import '../../widget/social_post_widget.dart';
import '../../widget/social_write_comment_widget.dart';

class SocialCommentsScreen extends StatefulWidget {
  final SocialPostEntity post;
  final ValueChanged<bool?> onLikeChanged;
  final SocialScreenBloc socialScreenBloc;
  final bool openWithFocus;

  const SocialCommentsScreen({
    super.key,
    required this.post,
    required this.onLikeChanged,
    required this.socialScreenBloc,
    required this.openWithFocus,
  });

  @override
  State<SocialCommentsScreen> createState() => _SocialCommentsScreenState();
}

class _SocialCommentsScreenState extends State<SocialCommentsScreen> {
  List<SocialCommentsEntity> socialComments = [];
  late ReadProfilePhotoURLBloc _readProfilePhotoURLBloc;
  late SocialAuthorizationEntity socialAuthorizationEntity;
  final ScrollController scrollController = ScrollController();
  final Map<String, dynamic> urls = {};

  @override
  void initState() {
    super.initState();
    _readProfilePhotoURLBloc = Modular.get<ReadProfilePhotoURLBloc>();

    _getComments();
    socialAuthorizationEntity = (widget.socialScreenBloc.authorizationBloc.state as LoadedAuthorizationState)
        .authorizationEntity
        .socialAuthorizationEntity;
  }

  void _getComments() {
    widget.socialScreenBloc.socialCommentsBloc.add(
      GetSocialCommentsEvent(
        postId: widget.post.id,
      ),
    );
  }

  Future<void> _refreshData() async {
    _getComments();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final themeRepository = Provider.of<ThemeRepository>(context);
    bool isDarkColor = themeRepository.isDarkTheme();
    return Scaffold(
      backgroundColor: isDarkColor ? SeniorColors.grayscale90 : SeniorColors.grayscale0,
      body: WaapiColorfulHeader(
        style: SeniorColorfulHeaderStructureStyle(
          bodyColor: Colors.white,
        ),
        titleLabel: context.translate.comment,
        body: DecoratedBox(
          decoration: BoxDecoration(
            color: isDarkColor ? SeniorColors.grayscale90 : SeniorColors.grayscale0,
          ),
          child: MultiBlocListener(
            listeners: [
              BlocListener<SocialCommentsBloc, SocialCommentsState>(
                bloc: widget.socialScreenBloc.socialCommentsBloc,
                listener: (context, state) {
                  if ((state is LoadedSocialCommentsState)) {
                    socialComments = state.socialComments;
                    for (var comment in socialComments) {
                      _readProfilePhotoURLBloc.add(
                        GetReadProfilePhotoURLEvent(
                          userId: comment.author.id,
                        ),
                      );
                    }
                  }

                  if (state is ErrorSocialLikeCommentState) {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SeniorSnackBar.error(
                        message: context.translate.socialLikeError,
                        action: SeniorSnackBarAction(
                          onPressed: () {},
                          label: context.translate.repeat,
                        ),
                      ),
                    );
                  }

                  if (state is ErrorSocialCreateCommentState) {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SeniorSnackBar.error(
                        message: context.translate.commentPostError,
                        action: SeniorSnackBarAction(
                          onPressed: () {
                            widget.socialScreenBloc.socialCommentsBloc.add(
                              CreateSocialCommentEvent(
                                socialCreateCommentIntputModel: state.socialCreateCommentIntputModel,
                              ),
                            );
                          },
                          label: context.translate.repeat,
                        ),
                      ),
                    );
                  }

                  if (state is LoadedSocialCreateCommentState) {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SeniorSnackBar.success(
                        message: context.translate.commentPosted,
                      ),
                    );
                  }
                },
              ),
              BlocListener<ReadProfilePhotoURLBloc, ReadProfilePhotoURLState>(
                bloc: _readProfilePhotoURLBloc,
                listener: (context, state) {
                  if (state is LoadedReadProfilePhotoURLState) {
                    urls.addAll({state.userId: state.url});
                    setState(() {});
                  }
                },
              ),
            ],
            child: RefreshIndicator(
              color:
                  themeRepository.isCustomTheme() ? themeRepository.theme.primaryColor : SeniorColors.primaryColor500,
              onRefresh: _refreshData,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Scrollbar(
                      controller: scrollController,
                      child: GlowingOverscrollIndicator(
                        axisDirection: AxisDirection.down,
                        color: themeRepository.isCustomTheme()
                            ? themeRepository.theme.primaryColor!
                            : SeniorColors.primaryColor500,
                        child: SingleChildScrollView(
                          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                          child: Column(
                            children: [
                              SocialPostWidget(
                                socialAuthorizationEntity: socialAuthorizationEntity,
                                socialPostEntity: widget.post,
                                openComments: false,
                                onLikeChanged: widget.onLikeChanged,
                                urls: urls,
                                socialScreenBloc: widget.socialScreenBloc,
                              ),
                              if (widget.socialScreenBloc.state is LoadingMoreSocialFeedState)
                                Center(
                                  child: WaapiLoadingWidget(
                                    waapiLoadingSizeEnum: WaapiLoadingSizeEnum.small,
                                  ),
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
                    SafeArea(
                      top: false,
                      left: false,
                      right: false,
                      child: SocialWriteCommentWidget(
                        isComment: true,
                        socialScreenBloc: widget.socialScreenBloc,
                        postId: widget.post.id,
                        openWithFocus: widget.openWithFocus,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
