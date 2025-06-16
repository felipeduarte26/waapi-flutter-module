import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../core/extension/media_query_extension.dart';
import '../../../../../../core/helper/scroll_helper.dart';
import '../../../../../../core/widgets/person_list_item_widget.dart';
import '../../../../../../routes/routes.dart';
import '../../../../domain/entities/social_profile_entity.dart';
import '../../../bloc/social_search/social_search_bloc.dart';
import '../../../bloc/social_search/social_search_event.dart';

class SocialSearchPeopleListWidget extends StatefulWidget {
  final int? maxLeanProfile;
  final List<SocialProfileEntity> profiles;
  final SocialSearchBloc? socialSearchBloc;
  final String termToSearch;

  const SocialSearchPeopleListWidget({
    super.key,
    this.maxLeanProfile,
    required this.profiles,
    this.socialSearchBloc,
    this.termToSearch = '',
  });

  @override
  State<SocialSearchPeopleListWidget> createState() => _SocialSearchPeopleListWidgetState();
}

class _SocialSearchPeopleListWidgetState extends State<SocialSearchPeopleListWidget> {
  final ScrollController scrollController = ScrollController();
  bool isLoading = false;
  int countProfiles = 0;

  @override
  void initState() {
    super.initState();
    if (widget.maxLeanProfile == null) {
      scrollController.addListener(_onScroll);
    }
    countProfiles = widget.profiles.length;
  }

  @override
  Widget build(BuildContext context) {
    return GlowingOverscrollIndicator(
      axisDirection: AxisDirection.down,
      color: SeniorColors.primaryColor500,
      child: ListView.builder(
        controller: scrollController,
        shrinkWrap: true,
        physics: widget.maxLeanProfile != null ? const NeverScrollableScrollPhysics() : null,
        padding: EdgeInsets.only(
          bottom: context.bottomSize,
        ),
        itemCount: widget.maxLeanProfile ?? widget.profiles.length,
        itemBuilder: (_, index) {
          return PersonListItemWidget(
            imageProvider: CachedNetworkImageProvider(
              widget.profiles[index].avatarUrl ?? '',
            ),
            personName: widget.profiles[index].name,
            leading: FontAwesomeIcons.solidChevronRight,
            padding: EdgeInsets.symmetric(
              horizontal: widget.maxLeanProfile == null ? SeniorSpacing.normal : 0,
              vertical: SeniorSpacing.xsmall,
            ),
            onTap: () {
              Modular.to.pushNamed(
                SocialRouters.socialProfileInitialRoute,
                arguments: {
                  'permaname': widget.profiles[index].permaname,
                },
              );
            },
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
    if (countProfiles == widget.profiles.length) {
      return;
    }
    widget.socialSearchBloc?.add(
      GetSocialSearchMoreResultEvent(
        query: widget.termToSearch,
        from: widget.profiles.length,
      ),
    );
    await Future.delayed(const Duration(milliseconds: 100));
    if (scrollController.hasClients) {
      scrollController.jumpTo(currentScrollPosition);
    }
    isLoading = false;
    countProfiles = widget.profiles.length;
  }
}
