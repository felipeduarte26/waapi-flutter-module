import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../domain/entities/social_profile_entity.dart';

class SocialCommentLikesBottomSheetContentWidget extends StatefulWidget {
  final List<SocialProfileEntity> profilesThatLiked;

  const SocialCommentLikesBottomSheetContentWidget({
    Key? key,
    required this.profilesThatLiked,
  }) : super(key: key);

  @override
  State<SocialCommentLikesBottomSheetContentWidget> createState() {
    return _SocialCommentLikesBottomSheetContentWidgetState();
  }
}

class _SocialCommentLikesBottomSheetContentWidgetState extends State<SocialCommentLikesBottomSheetContentWidget> {
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeRepository>(context).theme;

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
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: widget.profilesThatLiked.length,
                  (context, index) {
                    return InkWell(
                      child: Padding(
                        padding: const EdgeInsets.all(SeniorSpacing.xsmall),
                        child: Row(
                          children: [
                            SeniorProfilePicture(
                              name: widget.profilesThatLiked[index].name,
                              radius: SeniorCircularElements.small,
                              imageProvider: widget.profilesThatLiked[index].avatarUrl != null
                                  ? CachedNetworkImageProvider(
                                      widget.profilesThatLiked[index].avatarUrl!,
                                    )
                                  : null,
                            ),
                            const SizedBox(
                              width: SeniorSpacing.small,
                            ),
                            SeniorText.label(
                              widget.profilesThatLiked[index].name,
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
            ],
          ),
        ),
      ),
    );
  }
}
