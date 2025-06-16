import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';

import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';
import '../../../../../core/extension/translate_extension.dart';

import '../../../../../core/widgets/waapi_colorful_header.dart';

import '../../../domain/entities/social_search_entity.dart';
import '../../../enums/social_search_item_enum.dart';
import '../../bloc/social_search/social_search_bloc.dart';
import '../../bloc/social_search/social_search_event.dart';
import '../../bloc/social_search/social_search_state.dart';
import 'bloc/social_search_screen_bloc.dart';
import 'widget/social_all_search_widget.dart';
import 'widget/social_base_search_widget.dart';
import 'widget/social_search_badge.dart';
import 'widget/social_search_hashtags_list_widget.dart';
import 'widget/social_search_people_widget.dart';
import 'widget/social_search_post_list_widget.dart';
import 'widget/social_search_space_list_widget.dart';

const maxLean = 5;

class SocialSearchScreen extends StatefulWidget {
  const SocialSearchScreen({super.key});

  @override
  State<SocialSearchScreen> createState() => _SocialSearchScreenState();
}

class _SocialSearchScreenState extends State<SocialSearchScreen> {
  late SocialSearchScreenBloc _socialSearchScreenBloc;
  SocialSearchEntity socialSearchResult = const SocialSearchEntity(
    posts: [],
    tags: [],
    profiles: [],
    spaces: [],
  );
  late final GlobalKey<FormState> _formKey;
  late TextEditingController _editingControllerSocialSearch;
  late PageController _pageController;
  String termToSearch = '';
  String lastTermSearch = '';
  SocialSearchItemEnum searchItemEnum = SocialSearchItemEnum.all;
  int page = 0;

  @override
  void initState() {
    super.initState();
    _socialSearchScreenBloc = Modular.get<SocialSearchScreenBloc>();
    _formKey = GlobalKey<FormState>();
    _editingControllerSocialSearch = TextEditingController();
    _pageController = PageController(
      initialPage: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeRepository = Provider.of<ThemeRepository>(context);
    return MultiBlocListener(
      listeners: [
        BlocListener<SocialSearchBloc, SocialSearchState>(
          bloc: _socialSearchScreenBloc.socialSearchBloc,
          listener: (context, state) {
            if (state is LoadedSocialSearchState && state.socialSearchResult != null) {
              setState(() {
                socialSearchResult = state.socialSearchResult!;
              });
            }
            if (state is LoadedMoreSocialSearchState) {
              setState(() {
                socialSearchResult = state.socialSearchResult!;
              });
            }
          },
        ),
      ],
      child: Scaffold(
        body: WaapiColorfulHeader(
          title: SeniorText.label(
            context.translate.searchPesquise,
            color: themeRepository.isCustomTheme()
                ? SeniorServiceColor.getOptimalContrastColorTheme(color: themeRepository.theme.secondaryColor!)
                : SeniorColors.pureWhite,
            darkColor: SeniorColors.grayscale5,
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(SeniorSpacing.normal),
                child: SeniorText.label(context.translate.search),
              ),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: SeniorSpacing.normal,
                    vertical: SeniorSpacing.normal,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SeniorTextField(
                        key: const Key('search_social-social-search_screen-text_field-input_term_search'),
                        controller: _editingControllerSocialSearch,
                        label: context.translate.search,
                        maxLines: 1,
                        textInputAction: TextInputAction.done,
                        onChanged: (termToSearchValue) {
                          socialSearchResult = const SocialSearchEntity(
                            posts: [],
                            tags: [],
                            profiles: [],
                            spaces: [],
                          );
                          termToSearch = termToSearchValue.trim();
                          socialSearch(
                            searchItemEnum: SocialSearchItemEnum.all,
                          );
                        },
                        autofocus: true,
                        validator: (value) {
                          if (value != null && value.trim().length < 3) {
                            return context.translate.search;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: SeniorSpacing.xsmall),
                      SizedBox(
                        height: SeniorSpacing.xbig,
                        child: SingleChildScrollView(
                          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              SocialSearchBadge(
                                label: context.translate.all,
                                selected: searchItemEnum == SocialSearchItemEnum.all,
                                onSelect: (_) => changePage(SocialSearchItemEnum.all),
                              ),
                              SocialSearchBadge(
                                label: context.translate.people,
                                selected: searchItemEnum == SocialSearchItemEnum.profiles,
                                onSelect: (_) => changePage(SocialSearchItemEnum.profiles),
                              ),
                              SocialSearchBadge(
                                label: context.translate.group,
                                selected: searchItemEnum == SocialSearchItemEnum.space,
                                onSelect: (_) => changePage(SocialSearchItemEnum.space),
                              ),
                              SocialSearchBadge(
                                label: context.translate.hashtags,
                                selected: searchItemEnum == SocialSearchItemEnum.tags,
                                onSelect: (_) => changePage(SocialSearchItemEnum.tags),
                              ),
                              SocialSearchBadge(
                                label: context.translate.posts,
                                selected: searchItemEnum == SocialSearchItemEnum.posts,
                                onSelect: (_) => changePage(SocialSearchItemEnum.posts),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    SocialBaseSearchWidget(
                      onTapTryAgain: () => socialSearch(
                        searchItemEnum: SocialSearchItemEnum.all,
                      ),
                      searchItemEnum: SocialSearchItemEnum.all,
                      socialSearchBloc: _socialSearchScreenBloc.socialSearchBloc,
                      child: SocialAllSearchWidget(
                        onButtonSearchTryAgain: () => socialSearch(
                          searchItemEnum: SocialSearchItemEnum.all,
                        ),
                        socialSearchBloc: _socialSearchScreenBloc.socialSearchBloc,
                        maxLean: maxLean,
                        profiles: socialSearchResult.profiles,
                        posts: socialSearchResult.posts,
                        hashtags: socialSearchResult.tags,
                        spaces: socialSearchResult.spaces,
                        onButtonPressedProfiles: () => changePage(
                          SocialSearchItemEnum.profiles,
                        ),
                        onButtonPressedSpaces: () => changePage(
                          SocialSearchItemEnum.space,
                        ),
                        onButtonPressedTags: () => changePage(
                          SocialSearchItemEnum.tags,
                        ),
                        onButtonPressedPosts: () => changePage(
                          SocialSearchItemEnum.posts,
                        ),
                      ),
                    ),
                    SocialBaseSearchWidget(
                      onTapTryAgain: () => socialSearch(
                        searchItemEnum: SocialSearchItemEnum.profiles,
                      ),
                      termToSearch: termToSearch,
                      searchItemEnum: SocialSearchItemEnum.profiles,
                      isEmpty: socialSearchResult.profiles.isEmpty,
                      socialSearchBloc: _socialSearchScreenBloc.socialSearchBloc,
                      child: SocialSearchPeopleWidget(
                        profiles: socialSearchResult.profiles,
                        socialSearchBloc: _socialSearchScreenBloc.socialSearchBloc,
                        termToSearch: termToSearch,
                      ),
                    ),
                    SocialBaseSearchWidget(
                      onTapTryAgain: () => socialSearch(
                        searchItemEnum: SocialSearchItemEnum.space,
                      ),
                      searchItemEnum: SocialSearchItemEnum.space,
                      isEmpty: socialSearchResult.spaces.isEmpty,
                      socialSearchBloc: _socialSearchScreenBloc.socialSearchBloc,
                      child: SocialSearchSpaceListWidget(
                        spaces: socialSearchResult.spaces,
                      ),
                    ),
                    SocialBaseSearchWidget(
                      onTapTryAgain: () => socialSearch(
                        searchItemEnum: SocialSearchItemEnum.tags,
                      ),
                      searchItemEnum: SocialSearchItemEnum.tags,
                      isEmpty: socialSearchResult.tags.isEmpty,
                      socialSearchBloc: _socialSearchScreenBloc.socialSearchBloc,
                      child: SocialSearchHashtagsListWidget(
                        hashtags: socialSearchResult.tags,
                        socialSearchBloc: _socialSearchScreenBloc.socialSearchBloc,
                        termToSearch: termToSearch,
                      ),
                    ),
                    SocialBaseSearchWidget(
                      onTapTryAgain: () => socialSearch(
                        searchItemEnum: SocialSearchItemEnum.posts,
                      ),
                      searchItemEnum: SocialSearchItemEnum.posts,
                      isEmpty: socialSearchResult.posts.isEmpty,
                      socialSearchBloc: _socialSearchScreenBloc.socialSearchBloc,
                      child: SocialSearchPostListWidget(
                        posts: socialSearchResult.posts,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void changePage(SocialSearchItemEnum searchItemEnum) {
    FocusManager.instance.primaryFocus?.unfocus();

    _pageController.animateToPage(
      searchItemEnum.pageIndex,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    setState(() {
      this.searchItemEnum = searchItemEnum;
    });
  }

  void socialSearch({
    required SocialSearchItemEnum searchItemEnum,
  }) {
    final startingIndex = 0;
    _socialSearchScreenBloc.socialSearchBloc.add(
      GetSocialSearchResultEvent(
        query: termToSearch,
        from: startingIndex,
      ),
    );
    searchItemEnum = searchItemEnum;
  }
}
