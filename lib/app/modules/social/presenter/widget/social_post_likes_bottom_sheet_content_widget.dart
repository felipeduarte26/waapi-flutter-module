import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../core/constants/assets_path.dart';
import '../../../../core/enums/analytics/waapi_loading_size_enum.dart';
import '../../../../core/extension/translate_extension.dart';
import '../../../../core/helper/scroll_helper.dart';
import '../../../../core/pagination/pagination_requirements.dart';
import '../../../../core/widgets/error_state_widget.dart';
import '../../../../core/widgets/waapi_loading_widget.dart';
import '../../domain/usecases/get_profiles_that_liked_post_usecase.dart';
import '../bloc/sociaL_post_likes/social_post_likes_bloc.dart';
import '../bloc/sociaL_post_likes/social_post_likes_event.dart';
import '../bloc/sociaL_post_likes/social_post_likes_state.dart';

class SocialPostLikesBottomSheetContentWidget extends StatefulWidget {
  final String postId;

  const SocialPostLikesBottomSheetContentWidget({
    Key? key,
    required this.postId,
  }) : super(key: key);

  @override
  State<SocialPostLikesBottomSheetContentWidget> createState() {
    return _SocialPostLikesBottomSheetContentWidgetState();
  }
}

class _SocialPostLikesBottomSheetContentWidgetState extends State<SocialPostLikesBottomSheetContentWidget> {
  late ScrollController _scrollController;
  late int _nextPage;
  late SocialPostLikesBloc _socialPostLikesBloc;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    _nextPage = 1;

    _socialPostLikesBloc = SocialPostLikesBloc(
      getProfilesThatLikedPostUsecase: Modular.get<GetProfilesThatLikedPostUsecase>(),
    );
    _socialPostLikesBloc.add(
      GetSocialPostLikesEvent(
        postId: widget.postId,
        paginationRequirements: PaginationRequirements(
          page: _nextPage,
          limit: 10,
        ),
      ),
    );
    _nextPage++;
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _scrollController.removeListener(_onScroll);
    _socialPostLikesBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeRepository>(context).theme;
    bool isDarkColor = Provider.of<ThemeRepository>(context).isDarkTheme();

    return BlocBuilder<SocialPostLikesBloc, SocialPostLikesState>(
      bloc: _socialPostLikesBloc,
        builder: (BuildContext context, SocialPostLikesState state) {
          return Scaffold(
            backgroundColor: theme.colorfulHeaderStructureTheme!.style!.bodyColor,
            body: Padding(
              padding: const EdgeInsets.only(
                top: SeniorSpacing.normal,
              ),
              child: Scrollbar(
                controller: _scrollController,
                child: CustomScrollView(
                  controller: _scrollController,
                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                  slivers: [
                    if (state is LoadingSocialPostLikesState)
                      const SliverFillRemaining(
                        child: Center(
                          child: WaapiLoadingWidget(
                            waapiLoadingSizeEnum: WaapiLoadingSizeEnum.small,
                          ),
                        ),
                      ),
                    if (state is ErrorSocialPostLikesState)
                      SliverFillRemaining(
                        child: ErrorStateWidget(
                          title: context.translate.unableLoadPostLikes,
                          subTitle: context.translate.tryAgain,
                          imagePath: AssetsPath.generalErrorState,
                          onTapTryAgain: () => {
                            _tryAgainLoadPostLikes(),
                          },
                        ),
                      ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        childCount: state.profilesThatLiked!.length + 1,
                        (context, index) {
                          if (index == state.profilesThatLiked!.length) {
                            return Column(
                              children: [
                                Offstage(
                                  offstage: state is! LoadingMoreSocialPostLikesState,
                                  child: const Padding(
                                    padding: EdgeInsets.all(SeniorSpacing.normal),
                                    child: WaapiLoadingWidget(
                                      waapiLoadingSizeEnum: WaapiLoadingSizeEnum.small,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                          return InkWell(
                            child: Padding(
                              padding: const EdgeInsets.all(SeniorSpacing.xsmall),
                              child: Row(
                                children: [
                                  SeniorProfilePicture(
                                    name: state.profilesThatLiked![index].name,
                                    radius: SeniorCircularElements.small,
                                    imageProvider: state.profilesThatLiked![index].avatarUrl != null
                                        ? CachedNetworkImageProvider(
                                            state.profilesThatLiked![index].avatarUrl!,
                                          )
                                        : null,
                                  ),
                                  const SizedBox(
                                    width: SeniorSpacing.small,
                                  ),
                                  SeniorText.label(
                                    state.profilesThatLiked![index].name,
                                    textProperties: const TextProperties(
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    if (state is ErrorLoadingMoreSocialPostLikesState && state.profilesThatLiked!.isNotEmpty)
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: SeniorSpacing.normal),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: '${context.translate.unableLoadNewPostLikes} ',
                                  style: SeniorTypography.body(
                                    color: isDarkColor ? SeniorColors.pureWhite : SeniorColors.grayscale70,
                                  ),
                                ),
                                TextSpan(
                                  text: context.translate.tryAgain,
                                  style: TextStyle(
                                    color: isDarkColor ? SeniorColors.pureWhite : SeniorColors.grayscale70,
                                    fontFamily: 'OpenSans',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    height: 1.42857,
                                    decoration: TextDecoration.underline,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      _loadMorePostLikes();
                                    },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
    );
  }

  void _onScroll() {
    final socialPostLikesState = _socialPostLikesBloc.state;

    if (socialPostLikesState is! LoadingMoreSocialPostLikesState &&
        ScrollHelper.reachedListEnd(scrollController: _scrollController)) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        _loadMorePostLikes();
      });
    }
  }

  void _loadMorePostLikes() {
    final socialPostLikesState = _socialPostLikesBloc.state;

    if (socialPostLikesState is LoadedSocialPostLikesState) {
      _socialPostLikesBloc.add(
        GetSocialPostLikesEvent(
          postId: widget.postId,
          paginationRequirements: PaginationRequirements(
            page: _nextPage,
            limit: 10,
          ),
        ),
      );
      _nextPage++;
    }
  }

  void _tryAgainLoadPostLikes() {
    _nextPage = 1;
    _socialPostLikesBloc.add(
      GetSocialPostLikesEvent(
        postId: widget.postId,
        paginationRequirements: PaginationRequirements(
          page: _nextPage,
          limit: 10,
        ),
      ),
    );
    _nextPage++;
  }
}
