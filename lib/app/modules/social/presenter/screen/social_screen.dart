import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../core/constants/assets_path.dart';
import '../../../../core/extension/media_query_extension.dart';
import '../../../../core/extension/translate_extension.dart';
import '../../../../core/helper/scroll_helper.dart';
import '../../../../core/pagination/pagination_requirements.dart';
import '../../../../core/widgets/error_state_widget.dart';
import '../../../../core/widgets/waapi_colorful_header.dart';
import '../../../../core/widgets/waapi_loading_widget.dart';
import '../../../../routes/routes.dart';
import '../../../authorization/domain/entities/social_authorization_entity.dart';
import '../../../authorization/presenter/blocs/authorization_bloc/authorization_state.dart';
import '../../domain/entities/social_feed_entity.dart';
import '../../domain/entities/social_post_entity.dart';
import '../bloc/social_create_post/social_create_post_bloc.dart';
import '../bloc/social_create_post/social_create_post_state.dart';
import '../bloc/social_current_profile/social_current_profile_event.dart';
import '../bloc/social_feed/social_feed_bloc.dart';
import '../bloc/social_feed/social_feed_event.dart';
import '../bloc/social_feed/social_feed_state.dart';
import '../bloc/social_like_bloc/social_like_bloc.dart';
import '../bloc/social_like_bloc/social_like_event.dart';
import '../bloc/social_like_bloc/social_like_state.dart';
import '../bloc/social_screen/social_screen_bloc.dart';
import '../widget/social_create_post_widget.dart';
import '../widget/social_feed_empty_state_widget.dart';
import '../widget/social_post_widget.dart';

class SocialScreen extends StatefulWidget {
  final SocialScreenBloc socialScreenBloc;

  const SocialScreen({
    super.key,
    required this.socialScreenBloc,
  });

  @override
  State<SocialScreen> createState() => _SocialScreenState();
}

class _SocialScreenState extends State<SocialScreen> {
  SocialAuthorizationEntity _socialAuthorizationEntity = const SocialAuthorizationEntity();
  final ScrollController scrollController = ScrollController();
  List<SocialPostEntity> posts = [];
  String nextCursor = '';
  SocialFeedEntity socialFeedEntity = const SocialFeedEntity(
    posts: [],
    nextCursor: '',
    fixedPost: null,
  );
  Set<String> loadedNextCursor = {};
  bool isFirstMoreLoaded = true;
  bool isOffline = false;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_onScroll);

    if (widget.socialScreenBloc.authorizationBloc.state is LoadedAuthorizationState) {
      _socialAuthorizationEntity = (widget.socialScreenBloc.authorizationBloc.state as LoadedAuthorizationState)
          .authorizationEntity
          .socialAuthorizationEntity;
    }
    _getFeed();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {});
      widget.socialScreenBloc.socialCurrentProfileBloc.add(
        GetSocialCurrentProfileEvent(),
      );
    });
  }

  void _setSocialLike({
    required List<SocialPostEntity> posts,
    required String postId,
    required bool isLiked,
  }) {
    widget.socialScreenBloc.socialLikeBloc.add(
      SetSocialLikeEvent(
        posts: posts,
        postId: postId,
        isLiked: isLiked,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeRepository = Provider.of<ThemeRepository>(context);
    bool isDarkColor = themeRepository.isDarkTheme();
    var emptyLoadedMoreSocialFeed = false;
    var errorLoadedMoreSocialFeed = false;
    return MultiBlocListener(
      listeners: [
        BlocListener<SocialCreatePostBloc, SocialCreatePostState>(
          bloc: widget.socialScreenBloc.socialCreatePostBloc,
          listener: (context, state) {
            if (state is CreatedSocialCreatePostState) {
              _getFeed();
            }
          },
          child: Container(),
        ),
        BlocListener<SocialLikeBloc, SocialLikeState>(
          bloc: widget.socialScreenBloc.socialLikeBloc,
          listener: (context, state) {
            if (state is LoadedSocialLikeState) {
              final postIndex = posts.indexWhere((post) => post.id == state.likedPost?.id);
              posts[postIndex] = state.likedPost!;
            }

            if (state is ErrorSocialLikeState) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SeniorSnackBar.error(
                  message: context.translate.socialLikeError,
                  action: SeniorSnackBarAction(
                    onPressed: () => _setSocialLike(
                      isLiked: state.likedPost!.gotMyLike,
                      postId: state.likedPost!.id,
                      posts: posts,
                    ),
                    label: context.translate.repeat,
                  ),
                ),
              );
            }
          },
        ),
        BlocListener<SocialFeedBloc, SocialFeedState>(
          bloc: widget.socialScreenBloc.socialFeedBloc,
          listener: (context, state) {
            if (state is EmptyLoadedMoreSocialFeedState) {
              emptyLoadedMoreSocialFeed = true;
            }

            if (state is ErrorLoadedMoreSocialFeedState) {
              errorLoadedMoreSocialFeed = true;
            }

            if ((state is LoadedSocialFeedState)) {
              nextCursor = state.socialFeedEntity.nextCursor;
              socialFeedEntity = state.socialFeedEntity;
              posts = state.socialFeedEntity.posts;
            }

            if (state is LoadedMoreSocialFeedState) {
              nextCursor = state.socialFeedEntity.nextCursor;
              socialFeedEntity = state.socialFeedEntity;
              posts = state.socialFeedEntity.posts;
            }
          },
        ),
      ],
      child: WaapiColorfulHeader(
        notification: isOffline
            ? NotificationMessage(
                icon: FontAwesomeIcons.triangleExclamation,
                message: context.translate.offlineModeNotification,
                messageType: MessageTypes.messageInfo,
                showCloseButton: false,
              )
            : null,
        title: SeniorText.label(
          context.translate.social,
          color: themeRepository.isCustomTheme()
              ? SeniorServiceColor.getOptimalContrastColorTheme(color: themeRepository.theme.secondaryColor!)
              : SeniorColors.pureWhite,
          darkColor: SeniorColors.grayscale5,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Modular.to.pushNamed(SocialRouters.socialSearchScreenInitialRoute);
            },
            icon: Icon(
              Icons.search,
              color: themeRepository.isCustomTheme()
                  ? SeniorServiceColor.getContrastAdjustedColorTheme(
                      color: themeRepository.theme.primaryColor!,
                    )
                  : SeniorColors.pureWhite,
            ),
          ),
        ],
        body: BlocBuilder<SocialFeedBloc, SocialFeedState>(
          bloc: widget.socialScreenBloc.socialFeedBloc,
          builder: (context, state) {
            if (state is EmptySocialFeedState) {
              return const SocialFeedEmptyStateWidget();
            }

            if (state is ErrorSocialFeedState) {
              return Scaffold(
                backgroundColor:
                    Provider.of<ThemeRepository>(context).theme.colorfulHeaderStructureTheme!.style!.bodyColor,
                body: ErrorStateWidget(
                  title: context.translate.socialPostErrorTitle,
                  subTitle: context.translate.socialPostErrorTitle,
                  imagePath: AssetsPath.generalErrorState,
                  onTapTryAgain: () => {
                    isFirstMoreLoaded = true,
                    _getFeed(),
                  },
                ),
              );
            }

            if (state is LoadingSocialFeedState) {
              return Scaffold(
                backgroundColor: isDarkColor ? SeniorColors.grayscale70 : SeniorColors.grayscale10,
                body: const WaapiLoadingWidget(),
              );
            }

            return Scaffold(
              floatingActionButton: Visibility(
                visible: !isOffline && _socialAuthorizationEntity.canCreatePost,
                child: FloatingActionButton(
                  shape: const CircleBorder(),
                  onPressed: () async {
                    await SeniorBottomSheet.showBottomSheet(
                      height: context.bottomSheetSize,
                      padding: EdgeInsets.zero,
                      enableDrag: true,
                      context: context,
                      content: [
                        SocialCreatePostWidget(
                          socialScreenBloc: widget.socialScreenBloc,
                        ),
                      ],
                      hasCloseButton: true,
                      onTapCloseButton: () {
                        Modular.to.pop();
                      },
                    );
                  },
                  backgroundColor: themeRepository.isCustomTheme()
                      ? themeRepository.theme.secondaryColor!
                      : SeniorColors.primaryColor500,
                  child: SeniorIcon(
                    icon: FontAwesomeIcons.solidPenToSquare,
                    style: SeniorIconStyle(
                      color: themeRepository.isCustomTheme()
                          ? SeniorServiceColor.getOptimalContrastColorTheme(
                              color: themeRepository.theme.primaryColor!,
                            )
                          : SeniorColors.pureWhite,
                    ),
                    size: 20,
                  ),
                ),
              ),
              backgroundColor: isDarkColor ? SeniorColors.grayscale70 : SeniorColors.grayscale10,
              body: RefreshIndicator(
                color:
                    themeRepository.isCustomTheme() ? themeRepository.theme.primaryColor : SeniorColors.primaryColor500,
                onRefresh: _refreshData,
                child: Stack(
                  children: [
                    Scrollbar(
                      controller: scrollController,
                      child: GlowingOverscrollIndicator(
                        axisDirection: AxisDirection.down,
                        color: themeRepository.isCustomTheme()
                            ? themeRepository.theme.primaryColor!
                            : SeniorColors.primaryColor500,
                        child: ListView.separated(
                          padding: EdgeInsets.zero,
                          controller: scrollController,
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: SeniorSpacing.xsmall,
                            );
                          },
                          itemCount: posts.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                SocialPostWidget(
                                  socialAuthorizationEntity: _socialAuthorizationEntity,
                                  socialPostEntity: posts[index],
                                  openComments: true,
                                  onLikeChanged: (liked) {
                                    _setSocialLike(
                                      postId: posts[index].id,
                                      isLiked: liked!,
                                      posts: posts,
                                    );
                                  },
                                  urls: const {},
                                  socialScreenBloc: widget.socialScreenBloc,
                                ),
                                Visibility(
                                  visible: emptyLoadedMoreSocialFeed && index == posts.length - 1,
                                  child: Padding(
                                    padding: const EdgeInsets.all(
                                      SeniorSpacing.small,
                                    ),
                                    child: SeniorText.body(
                                      context.translate.socialPostEmpty,
                                      darkColor: SeniorColors.pureWhite,
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: errorLoadedMoreSocialFeed && index == posts.length - 1,
                                  child: Padding(
                                    padding: const EdgeInsets.all(
                                      SeniorSpacing.small,
                                    ),
                                    child: Row(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.all(
                                            SeniorSpacing.xsmall,
                                          ),
                                          child: SeniorIcon(
                                            icon: FontAwesomeIcons.solidCircleExclamation,
                                            style: SeniorIconStyle(
                                              color: SeniorColors.manchesterColorRed,
                                            ),
                                            size: SeniorIconSize.medium,
                                          ),
                                        ),
                                        Expanded(
                                          child: RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: '${context.translate.socialPostErro} ',
                                                  style: SeniorTypography.body(
                                                    color:
                                                        isDarkColor ? SeniorColors.pureWhite : SeniorColors.grayscale70,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: context.translate.tryAgain,
                                                  style: TextStyle(
                                                    color:
                                                        isDarkColor ? SeniorColors.pureWhite : SeniorColors.grayscale70,
                                                    fontFamily: 'OpenSans',
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w700,
                                                    height: 1.42857,
                                                    decoration: TextDecoration.underline,
                                                  ),
                                                  recognizer: TapGestureRecognizer()
                                                    ..onTap = () {
                                                      _getFeed(
                                                        nextCursor: nextCursor,
                                                        socialFeedEntity: state.socialFeedEntity,
                                                      );
                                                    },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                    if (widget.socialScreenBloc.state is LoadingMoreSocialFeedState)
                      const Positioned(
                        bottom: SeniorSpacing.normal,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _refreshData() async {
    if (!isOffline) {
      socialFeedEntity = const SocialFeedEntity(
        posts: [],
        nextCursor: '',
        fixedPost: null,
      );
      loadedNextCursor.clear();
      _getFeed();
      setState(() {});
    }
  }

  void _onScroll() {
    if (!isOffline) {
      final canLoadMore = ScrollHelper.reachedListEnd(
        scrollController: scrollController,
      );
      if (canLoadMore && (!loadedNextCursor.contains(nextCursor) || isFirstMoreLoaded)) {
        isFirstMoreLoaded = false;
        loadedNextCursor.add(nextCursor);

        _getFeed(
          nextCursor: nextCursor,
          socialFeedEntity: socialFeedEntity,
        );
      }
    }
  }

  void _getFeed({String nextCursor = '', SocialFeedEntity? socialFeedEntity}) {
    widget.socialScreenBloc.socialFeedBloc.add(
      GetSocialFeedEvent(
        socialFeedEntity: socialFeedEntity,
        nextCursor: nextCursor,
        since: DateTime.now(),
        paginationRequirements: const PaginationRequirements(
          page: 10,
          limit: 10,
        ),
      ),
    );
  }
}
