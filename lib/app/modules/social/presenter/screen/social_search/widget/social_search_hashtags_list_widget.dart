import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';
import '../../../../../../core/extension/media_query_extension.dart';
import '../../../../../../core/helper/scroll_helper.dart';
import '../../../../../../routes/routes.dart';
import '../../../bloc/social_search/social_search_bloc.dart';
import '../../../bloc/social_search/social_search_event.dart';
import '../../../bloc/social_tag_feed/social_tag_feed_bloc.dart';

class SocialSearchHashtagsListWidget extends StatefulWidget {
  final SocialSearchBloc? socialSearchBloc;
  final String termToSearch;
  final int? maxLeanHashtag;
  final List<String> hashtags;

  const SocialSearchHashtagsListWidget({
    super.key,
    this.maxLeanHashtag,
    required this.hashtags,
    this.socialSearchBloc,
    this.termToSearch = '',
  });

  @override
  State<SocialSearchHashtagsListWidget> createState() => _SocialSearchHashtagsListWidgetState();
}

class _SocialSearchHashtagsListWidgetState extends State<SocialSearchHashtagsListWidget> {
  final ScrollController scrollController = ScrollController();
  bool isLoading = false;
  int countTags = 0;

  @override
  void initState() {
    super.initState();
    if (widget.maxLeanHashtag == null) {
      scrollController.addListener(_onScroll);
    }
    countTags = widget.hashtags.length - 1;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeRepository>(context).isDarkTheme();

    return GlowingOverscrollIndicator(
      axisDirection: AxisDirection.down,
      color: SeniorColors.primaryColor500,
      child: ListView.builder(
        controller: scrollController,
        shrinkWrap: true,
        physics: widget.maxLeanHashtag != null ? const NeverScrollableScrollPhysics() : null,
        padding: EdgeInsets.only(
          bottom: context.bottomSize,
        ),
        itemCount: widget.maxLeanHashtag ?? (widget.hashtags.length),
        itemBuilder: (_, index) {
          return GestureDetector(
            onTap: () {
              Modular.to.pushNamed(
                SocialRouters.socialTagInitialRoute,
                arguments: {
                  'tag': '#${widget.hashtags[index]}',
                  'socialTagFeedBloc': Modular.get<SocialTagFeedBloc>(),
                },
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: widget.maxLeanHashtag == null ? SeniorSpacing.normal : 0,
                    vertical: SeniorSpacing.xsmall,
                  ),
                  child: Row(
                    children: [
                      const SeniorIcon(
                        style: SeniorIconStyle(
                          color: SeniorColors.primaryColor500,
                        ),
                        icon: FontAwesomeIcons.solidHashtag,
                        size: SeniorSpacing.medium,
                      ),
                      const SizedBox(width: SeniorSpacing.xsmall),
                      SeniorText.label(
                        widget.hashtags[index],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(
                    SeniorSpacing.xsmall,
                  ),
                  child: SeniorIcon(
                    style: SeniorIconStyle(
                      color: isDark ? SeniorColors.pureWhite : SeniorColors.grayscale60,
                    ),
                    icon: FontAwesomeIcons.solidChevronRight,
                    size: SeniorSpacing.small,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _onScroll() {
    if (isLoading) return;
    final canLoadMore = ScrollHelper.reachedListEnd(
      scrollController: scrollController,
    );
    if (canLoadMore) {
      _loadMoreTags();
    }
  }

  Future<void> _loadMoreTags() async {
    isLoading = true;
    double currentScrollPosition = scrollController.position.pixels;

    widget.socialSearchBloc?.add(
      GetSocialSearchMoreResultEvent(
        query: widget.termToSearch,
        from: widget.hashtags.length,
      ),
    );
    await Future.delayed(const Duration(milliseconds: 100));
    if (scrollController.hasClients) {
      scrollController.jumpTo(currentScrollPosition);
    }
    isLoading = false;
    countTags = widget.hashtags.length;
  }
}
