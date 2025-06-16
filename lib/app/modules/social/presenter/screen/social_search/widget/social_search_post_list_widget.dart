import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';
import '../../../../../../core/helper/scroll_helper.dart';
import '../../../../../authorization/domain/entities/social_authorization_entity.dart';
import '../../../../../authorization/presenter/blocs/authorization_bloc/authorization_state.dart';
import '../../../../domain/entities/social_post_entity.dart';
import '../../../../domain/extensions/social_search_extension.dart';
import '../../../bloc/social_like_bloc/social_like_event.dart';
import '../../../bloc/social_screen/social_screen_bloc.dart';
import '../../../bloc/social_search/social_search_bloc.dart';
import '../../../bloc/social_search/social_search_event.dart';
import '../../../widget/social_post_widget.dart';

class SocialSearchPostListWidget extends StatefulWidget {
  final int? maxLeanPosts;
  final String termToSearch;
  final SocialSearchBloc? socialSearchBloc;
  final List<SocialPostEntity> posts;
  const SocialSearchPostListWidget({
    required this.posts,
    this.socialSearchBloc,
    this.maxLeanPosts,
    this.termToSearch = '',
    super.key,
  });

  @override
  State<SocialSearchPostListWidget> createState() => _SocialSearchPostListWidgetState();
}

class _SocialSearchPostListWidgetState extends State<SocialSearchPostListWidget> {
  late SocialScreenBloc _socialScreenBloc;
  late SocialAuthorizationEntity _socialAuthorizationEntity;
  final ScrollController scrollController = ScrollController();
  bool isLoading = false;
  int countPosts = 0;

  @override
  void initState() {
    super.initState();
    _socialScreenBloc = Modular.get<SocialScreenBloc>();
    if (_socialScreenBloc.authorizationBloc.state is LoadedAuthorizationState) {
      _socialAuthorizationEntity = (_socialScreenBloc.authorizationBloc.state as LoadedAuthorizationState)
          .authorizationEntity
          .socialAuthorizationEntity;
    }
    if (widget.maxLeanPosts == null) {
      scrollController.addListener(_onScroll);
    }
    countPosts = widget.posts.length;
  }

  @override
  Widget build(BuildContext context) {
    return GlowingOverscrollIndicator(
      axisDirection: AxisDirection.down,
      color: SeniorColors.primaryColor500,
      child: ListView.separated(
        padding: EdgeInsets.zero,
        controller: scrollController,
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: SeniorSpacing.normal,
          );
        },
        shrinkWrap: true,
        physics: widget.maxLeanPosts != null ? const NeverScrollableScrollPhysics() : null,
        itemCount: widget.posts.length.getMaxItemCount(widget.maxLeanPosts),
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: SeniorColors.grayscale30,
              ),
            ),
            child: SocialPostWidget(
              socialPostEntity: widget.posts[index],
              socialAuthorizationEntity: _socialAuthorizationEntity,
              onLikeChanged: (liked) {
                _socialScreenBloc.socialLikeBloc.add(
                  SetSocialLikeEvent(
                    posts: widget.posts,
                    postId: widget.posts[index].id,
                    isLiked: liked!,
                  ),
                );
              },
              openComments: true,
              socialScreenBloc: _socialScreenBloc,
              urls: const {},
            ),
          );
        },
      ),
    );
  }

  void _onScroll() {
    if (isLoading) return;
    final canLoadMore = ScrollHelper.reachedListEnd(scrollController: scrollController);
    if (canLoadMore) {
      _loadMoreProfiles();
    }
  }

  Future<void> _loadMoreProfiles() async {
    isLoading = true;
    double currentScrollPosition = scrollController.position.pixels;
    if (countPosts == widget.posts.length) {
      return;
    }
    widget.socialSearchBloc?.add(
      GetSocialSearchMoreResultEvent(
        query: widget.termToSearch,
        from: widget.posts.length,
      ),
    );
    await Future.delayed(const Duration(milliseconds: 100));
    if (scrollController.hasClients) {
      scrollController.jumpTo(currentScrollPosition);
    }
    isLoading = false;
    countPosts = widget.posts.length;
  }
}
