import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../core/constants/assets_path.dart';
import '../../../../../core/enums/analytics/waapi_loading_size_enum.dart';
import '../../../../../core/extension/translate_extension.dart';
import '../../../../../core/helper/scroll_helper.dart';
import '../../../../../core/pagination/pagination_requirements.dart';
import '../../../../../core/widgets/employee_bottom_sheet_widget.dart';
import '../../../../../core/widgets/empty_state_widget.dart';
import '../../../../../core/widgets/person_list_item_widget.dart';
import '../../../../../core/widgets/waapi_colorful_header.dart';
import '../../../../../core/widgets/waapi_loading_widget.dart';
import '../../../../attachment/presenter/blocs/attachment_bloc/attachment_event.dart';
import '../../../../authorization/domain/entities/social_authorization_entity.dart';
import '../../../../authorization/presenter/blocs/authorization_bloc/authorization_state.dart';
import '../../bloc/social_feed/social_feed_bloc.dart';
import '../../bloc/social_feed/social_feed_event.dart';
import '../../bloc/social_feed/social_feed_state.dart';
import '../../bloc/social_get_url_post/get_url_post_bloc.dart';
import '../../bloc/social_get_url_post/get_url_post_event.dart';
import '../../bloc/social_get_url_post/get_url_post_state.dart';
import '../../bloc/social_list_members/social_list_members_bloc.dart';
import '../../bloc/social_list_members/social_list_members_event.dart';
import '../../bloc/social_list_members/social_list_members_state.dart';
import '../../bloc/social_screen/social_screen_bloc.dart';

class SocialListMembersScreen extends StatefulWidget {
  final SocialScreenBloc socialScreenBloc;
  final String postId;

  const SocialListMembersScreen({
    Key? key,
    required this.socialScreenBloc,
    required this.postId,
  }) : super(key: key);

  @override
  State<SocialListMembersScreen> createState() {
    return _SocialListMembersScreenState();
  }
}

class _SocialListMembersScreenState extends State<SocialListMembersScreen> {
  SocialAuthorizationEntity _socialAuthorizationEntity = const SocialAuthorizationEntity();
  late final GlobalKey<FormState> _formKey;
  late TextEditingController _editingControllerSocialListMembers;
  late ScrollController _scrollControllerListOfPeople;
  late final bool canSharePost;
  int _nextPage = 0;
  String lastTermToSearch = '';
  List<String> selecteds = [];

  @override
  void initState() {
    super.initState();
    if (widget.socialScreenBloc.authorizationBloc.state is LoadedAuthorizationState) {
      _socialAuthorizationEntity = (widget.socialScreenBloc.authorizationBloc.state as LoadedAuthorizationState)
          .authorizationEntity
          .socialAuthorizationEntity;
    }
    canSharePost = _socialAuthorizationEntity.canViewProfiles && _socialAuthorizationEntity.canViewSpacesMembers;
    _editingControllerSocialListMembers = TextEditingController();
    _formKey = GlobalKey<FormState>();
    _scrollControllerListOfPeople = ScrollController();
    _scrollControllerListOfPeople.addListener(_onScroll);
    _searchPersonByTermEvent(
      paginationRequirements: const PaginationRequirements(
        page: 0,
        queryText: '',
      ),
    );

    widget.socialScreenBloc.urlPostBloc.add(
      GetURLPostEvent(
        postId: widget.postId,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (_, __) async => onWillPop(),
      child: Scaffold(
        body: WaapiColorfulHeader(
          onTapBack: onWillPop,
          hasTopPadding: false,
          titleLabel: context.translate.sharePost,
          body: Scrollbar(
            controller: _scrollControllerListOfPeople,
            child: CustomScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              controller: _scrollControllerListOfPeople,
              slivers: [
                SliverToBoxAdapter(
                  child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(SeniorSpacing.normal),
                      child: SeniorTextField(
                        key: const Key('social_list_members-social_list_members_screen-text_field-input_term_search'),
                        controller: _editingControllerSocialListMembers,
                        label: context.translate.peopleSearch,
                        maxLines: 1,
                        textInputAction: TextInputAction.done,
                        onChanged: (termToSearch) {
                          // Condition added because when the user dismisses keyboard
                          // using back button on changed was called and triggering a new event,
                          // and therefore a new search has been made.
                          if (lastTermToSearch != termToSearch) {
                            lastTermToSearch = termToSearch;
                            _searchPersonByTermEvent(
                              paginationRequirements: PaginationRequirements(
                                page: 0,
                                queryText: lastTermToSearch,
                              ),
                            );
                            setState(() {});
                          }
                        },
                        autofocus: true,
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      right: SeniorSpacing.normal,
                      left: SeniorSpacing.normal,
                      bottom: SeniorSpacing.xsmall,
                    ),
                    child: SeniorText.small(context.translate.selectMaxEmployees),
                  ),
                ),
                BlocConsumer<SocialListMembersBloc, SocialListMembersState>(
                  bloc: widget.socialScreenBloc.listMembersBloc,
                  listener: (_, state) {
                    if (state is LoadedSocialListMembersState) {
                      _nextPage++;
                    }

                    if (state is ErrorSocialListMembersState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SeniorSnackBar.error(
                          key: const Key('social_list_members-social_list_members_screen-error_loading_person'),
                          message: context.translate.errorLoadingPeople,
                          action: SeniorSnackBarAction(
                            label: context.translate.repeat,
                            onPressed: () => _searchPersonByTermEvent(
                              paginationRequirements: PaginationRequirements(
                                page: _nextPage,
                                queryText: lastTermToSearch,
                              ),
                            ),
                          ),
                        ),
                      );
                    }

                    if (state is ErrorMoreSocialListMembersState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SeniorSnackBar.error(
                          key: const Key('social_list_members-social_list_members_screen-error_loading_more_person'),
                          message: context.translate.errorLoadingMorePeople,
                          action: SeniorSnackBarAction(
                            label: context.translate.repeat,
                            onPressed: () => _searchPersonByTermEvent(
                              paginationRequirements: PaginationRequirements(
                                page: _nextPage,
                                queryText: lastTermToSearch,
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is LoadingSocialListMembersState) {
                      return SliverFillRemaining(
                        fillOverscroll: false,
                        hasScrollBody: false,
                        child: Container(
                          key: const Key('social_list_members-social_list_members_screen-loading'),
                          padding: const EdgeInsets.only(
                            top: SeniorSpacing.normal,
                          ),
                          alignment: Alignment.center,
                          child: const WaapiLoadingWidget(
                            waapiLoadingSizeEnum: WaapiLoadingSizeEnum.big,
                          ),
                        ),
                      );
                    }

                    if (state is EmptySocialListMembersState) {
                      return SliverFillRemaining(
                        fillOverscroll: false,
                        hasScrollBody: false,
                        child: EmptyStateWidget(
                          key: const Key('social_list_members-social_list_members_screen-person_not_found'),
                          title: context.translate.noPersonFound,
                          imagePath: AssetsPath.searchPersonEmptyState,
                          imageHeight: 120,
                        ),
                      );
                    }

                    if (state is InitialSocialListMembersState || state is CleanSocialListMembersState) {
                      return SliverFillRemaining(
                        fillOverscroll: false,
                        hasScrollBody: false,
                        child: Container(
                          key: const Key('social_list_members-social_list_members_screen-loading'),
                          padding: const EdgeInsets.only(
                            top: SeniorSpacing.normal,
                          ),
                          alignment: Alignment.center,
                          child: const WaapiLoadingWidget(
                            waapiLoadingSizeEnum: WaapiLoadingSizeEnum.big,
                          ),
                        ),
                      );
                    }

                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (_, index) {
                          if (index == state.socialProfiles.length) {
                            return Column(
                              children: [
                                Offstage(
                                  key: const Key(
                                    'social_list_members-social_list_members_screen-circular_progress-load_more',
                                  ),
                                  offstage: state is! LoadingMoreSocialListMembersState,
                                  child: const Center(
                                    child: WaapiLoadingWidget(
                                      waapiLoadingSizeEnum: WaapiLoadingSizeEnum.big,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }

                          return PersonListItemWidget(
                            key: Key(
                              'social_list_members-social_list_members_screen-list_header_widget-item_list$index',
                            ),
                            imageProvider: state.socialProfiles[index].avatarUrl == null ||
                                    state.socialProfiles[index].avatarUrl!.isEmpty
                                ? null
                                : CachedNetworkImageProvider(state.socialProfiles[index].avatarUrl!),
                            personName: state.socialProfiles[index].name,
                            personId: state.socialProfiles[index].id,
                            padding: const EdgeInsets.symmetric(
                              horizontal: SeniorSpacing.normal,
                              vertical: SeniorSpacing.xsmall,
                            ),
                            onTap: () {
                              final selected = state.socialProfiles[index].id;
                              setState(() {
                                if (selecteds.contains(selected)) {
                                  selecteds.remove(selected);
                                } else if (selecteds.length < 5) {
                                  selecteds.add(selected);
                                }
                              });
                            },
                            selected: selecteds.contains(state.socialProfiles[index].id),
                            disabled: selecteds.length > 4 && !selecteds.contains(state.socialProfiles[index].id),
                          );
                        },
                        childCount: state.socialProfiles.length + 1,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BlocConsumer<SocialFeedBloc, SocialFeedState>(
          bloc: widget.socialScreenBloc.socialFeedBloc,
          listener: (context, state) {
            if (state is ErrorSocialSharedPostState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SeniorSnackBar.error(
                  message: context.translate.sharedPostError,
                  action: SeniorSnackBarAction(
                    onPressed: () {
                      _sharePost();
                    },
                    label: context.translate.repeat,
                  ),
                ),
              );
            }

            if (state is LoadedSocialSharedPostState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SeniorSnackBar.success(
                  message: context.translate.postShared,
                ),
              );

              onWillPop();
            }
          },
          builder: (context, state) {
            return EmployeeBottomSheetWidget(
              horizontalPadding: true,
              seniorButtons: [
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: SeniorSpacing.normal,
                  ),
                  child: SeniorButton(
                    icon: FontAwesomeIcons.solidRocket,
                    disabled: selecteds.isEmpty || (state is LoadingSocialSharedPostState) || !canSharePost,
                    busy: (state is LoadingSocialSharedPostState),
                    fullWidth: true,
                    label: context.translate.sendPost,
                    onPressed: () {
                      _sharePost();
                    },
                  ),
                ),
                BlocBuilder<GetURLPostBloc, GetURLPostState>(
                  bloc: widget.socialScreenBloc.urlPostBloc,
                  builder: (context, state) {
                    var url = '';
                    if (state is LoadedGetURLPostState) {
                      url = state.url;
                    }
                    return Padding(
                      padding: const EdgeInsets.only(
                        bottom: SeniorSpacing.normal,
                      ),
                      child: SeniorButton.ghost(
                        icon: FontAwesomeIcons.solidCopy,
                        disabled: (state is! LoadedGetURLPostState),
                        fullWidth: true,
                        label: context.translate.shareLink,
                        onPressed: () {
                          _shareLink(
                            stringToShare: url,
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void onWillPop() {
    Modular.to.pop();
  }

  void _sharePost() {
    widget.socialScreenBloc.socialFeedBloc.add(
      SharePostForMemberEvent(
        membersId: selecteds,
        postId: widget.postId,
      ),
    );
  }

  void _shareLink({required String stringToShare}) {
    widget.socialScreenBloc.shareStringBloc.add(
      ShareStringEvent(
        stringToShare: stringToShare,
      ),
    );
  }

  void _onScroll() {
    final canLoadMore = ScrollHelper.reachedListEnd(
      scrollController: _scrollControllerListOfPeople,
    );

    if (canLoadMore) {
      _searchPersonByTermEvent(
        paginationRequirements: PaginationRequirements(
          page: _nextPage,
          queryText: lastTermToSearch,
        ),
      );
    }
  }

  void _searchPersonByTermEvent({
    required PaginationRequirements paginationRequirements,
  }) {
    widget.socialScreenBloc.listMembersBloc.add(
      GetSocialListMembersEvent(
        paginationRequirements: paginationRequirements,
      ),
    );
  }

  @override
  void dispose() {
    _editingControllerSocialListMembers.dispose();
    _scrollControllerListOfPeople.dispose();
    super.dispose();
  }
}
