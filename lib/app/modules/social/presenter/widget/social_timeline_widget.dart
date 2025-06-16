import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/tokens/senior_colors.dart';
import 'package:senior_design_tokens/tokens/senior_spacing.dart';

import '../../../../core/extension/translate_extension.dart';
import '../../../../core/helper/scroll_helper.dart';
import '../../domain/entities/social_post_entity.dart';
import '../../enums/social_space_privacy_enum.dart';
import 'social_list_header_widget.dart';
import 'social_posts_list_widget.dart';

class SocialTimelineWidget extends StatefulWidget {
  final bool isLoading;
  final bool endReached;
  final String name;
  final String? avatarUrl;
  final bool isCorporateProfile;
  final SocialSpacePrivacyEnum? spacePrivacy;
  final int? memberCount;
  final String? administratedBy;
  final List<SocialPostEntity> posts;
  final Function getMorePosts;

  const SocialTimelineWidget({
    super.key,
    required this.isLoading,
    required this.endReached,
    required this.name,
    this.avatarUrl,
    this.spacePrivacy,
    this.memberCount,
    this.administratedBy,
    this.isCorporateProfile = false,
    required this.posts,
    required this.getMorePosts,
  });

  @override
  State<SocialTimelineWidget> createState() => _SocialTimelineWidgetState();
}

class _SocialTimelineWidgetState extends State<SocialTimelineWidget> {
  final ScrollController scrollController = ScrollController();
  String nextCursor = '';
  bool isFirstMoreLoaded = true;
  Set<String> loadedNextCursor = {};
  bool isAlreadyLoading = false;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkColor = Provider.of<ThemeRepository>(context).isDarkTheme();
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      controller: scrollController,
      child: Column(
        children: [
          SocialListHeaderWidget(
            isCorporateProfile: widget.isCorporateProfile,
            name: widget.name,
            avatarUrl: widget.avatarUrl,
            spacePrivacy: widget.spacePrivacy,
            memberCount: widget.memberCount,
            administratedBy: widget.administratedBy,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: SeniorSpacing.normal),
            child: Divider(
              color: isDarkColor ? SeniorColors.grayscale70 : SeniorColors.grayscale10,
              thickness: SeniorSpacing.xsmall,
              height: 0,
            ),
          ),
          SocialPostListWidget(
            posts: widget.posts,
          ),
          if (widget.isLoading)
            const Padding(
              padding: EdgeInsets.symmetric(
                vertical: SeniorSpacing.small,
              ),
              child: SeniorLoading(),
            ),
          if (widget.endReached)
            Padding(
              padding: const EdgeInsets.all(
                SeniorSpacing.small,
              ),
              child: SeniorText.body(
                context.translate.socialPostEmpty,
                darkColor: SeniorColors.pureWhite,
              ),
            ),
        ],
      ),
    );
  }

  void _onScroll() {
    bool canLoadMore = ScrollHelper.reachedListEnd(
      scrollController: scrollController,
    );
    if (!widget.endReached && canLoadMore && !isAlreadyLoading || isFirstMoreLoaded) {
      isAlreadyLoading = true;
      isFirstMoreLoaded = false;
      widget.getMorePosts();
      isAlreadyLoading = false;
    }
  }
}
