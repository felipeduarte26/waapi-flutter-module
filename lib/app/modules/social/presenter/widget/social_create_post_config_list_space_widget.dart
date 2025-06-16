import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/tokens/senior_colors.dart';
import 'package:senior_design_tokens/tokens/senior_spacing.dart';

import '../../../../core/constants/assets_path.dart';
import '../../../../core/enums/analytics/waapi_loading_size_enum.dart';
import '../../../../core/extension/translate_extension.dart';
import '../../../../core/helper/scroll_helper.dart';
import '../../../../core/pagination/pagination_requirements.dart';
import '../../../../core/widgets/error_state_widget.dart';
import '../../../../core/widgets/waapi_loading_widget.dart';
import '../../domain/entities/social_space_entity.dart';
import '../bloc/social_spaces/social_spaces_bloc.dart';
import '../bloc/social_spaces/social_spaces_event.dart';
import '../bloc/social_spaces/social_spaces_state.dart';

class SocialCreatePostConfigListSpaceWidget extends StatefulWidget {
  final ValueChanged<SocialSpaceEntity> onSpaceChanged;
  final SocialSpaceEntity? selectedSpace;
  final SocialSpacesBloc socialScreenBloc;

  const SocialCreatePostConfigListSpaceWidget({
    Key? key,
    required this.onSpaceChanged,
    required this.socialScreenBloc,
    required this.selectedSpace,
  }) : super(key: key);

  @override
  State<SocialCreatePostConfigListSpaceWidget> createState() => _SocialCreatePostConfigListSpaceWidgetState();
}

class _SocialCreatePostConfigListSpaceWidgetState extends State<SocialCreatePostConfigListSpaceWidget> {
  List<SocialSpaceEntity> displayedSpacesList = [];
  final ScrollController scrollController = ScrollController();
  late bool listEnd;
  SocialSpaceEntity? selectedSpace;
  late PaginationRequirements paginationRequirement;
  var nextPage = 1;

  @override
  void initState() {
    listEnd = false;
    selectedSpace = widget.selectedSpace;
    scrollController.addListener(_onScroll);
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients && scrollController.position.maxScrollExtent == 0) {
        widget.socialScreenBloc.add(
          GetSocialSpacesEvent(
            paginationRequirements: const PaginationRequirements(
              page: 0,
              limit: 20,
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeRepository = Provider.of<ThemeRepository>(context);
    return BlocConsumer<SocialSpacesBloc, SocialSpacesState>(
      listener: (context, state) {
        if (state is LoadedSocialSpacesState) {
          displayedSpacesList = List.from(state.socialSpaces);
          nextPage = nextPage++;
        }
        if (state is LoadedMoreSocialSpacesState) {
          displayedSpacesList = state.socialSpaces;
        }
      },
      bloc: widget.socialScreenBloc,
      builder: (context, state) {
        if ((state is LoadingSocialSpacesState || state is LoadedMoreSocialSpacesState) && !listEnd) {
          return const SizedBox(
            child: Center(
              child: WaapiLoadingWidget(
                waapiLoadingSizeEnum: WaapiLoadingSizeEnum.small,
              ),
            ),
          );
        }

        if (state is LoadedSocialSpacesState && displayedSpacesList.isEmpty) {
          return ErrorStateWidget(
            title: context.translate.emptyStateSearchSocialGroup,
            subTitle: context.translate.tryAgainSubtitleDescription,
            imagePath: AssetsPath.generalErrorState,
            onTapTryAgain: () => getMoreSpaces(),
          );
        }

        if (state is ErrorSocialSpacesState) {
          return ErrorStateWidget(
            title: context.translate.errorStateSearchSocialGroup,
            subTitle: context.translate.tryAgainSubtitleDescription,
            imagePath: AssetsPath.generalErrorState,
            onTapTryAgain: () => getMoreSpaces(),
          );
        }

        return Expanded(
          child: Column(
            children: [
              Expanded(
                child: Scrollbar(
                  controller: scrollController,
                  child: ListView.separated(
                    itemCount: displayedSpacesList.length,
                    controller: scrollController,
                    padding: const EdgeInsets.symmetric(
                      horizontal: SeniorSpacing.xxxsmall,
                    ),
                    itemBuilder: (_, index) {
                      final space = displayedSpacesList[index];
                      final isSelected = selectedSpace == space;

                      if (state is LoadingSocialSpacesState) {
                        return const WaapiLoadingWidget(
                          waapiLoadingSizeEnum: WaapiLoadingSizeEnum.small,
                        );
                      }
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedSpace = space;
                          });
                        },
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SeniorIcon(
                                  icon: isSelected ? FontAwesomeIcons.circleDot : FontAwesomeIcons.circle,
                                  style: SeniorIconStyle(
                                    color: isSelected ? themeRepository.theme.primaryColor : SeniorColors.grayscale40,
                                  ),
                                  size: SeniorSpacing.normal,
                                ),
                                const SizedBox(
                                  width: SeniorSpacing.xsmall,
                                ),
                                Expanded(
                                  child: SizedBox(
                                    child: SeniorText.label(
                                      darkColor: SeniorColors.grayscale30,
                                      color: SeniorColors.grayscale90,
                                      space.name,
                                      textProperties: const TextProperties(
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: SeniorSpacing.xxsmall,
                            ),
                            const Divider(
                              color: SeniorColors.grayscale60,
                              thickness: 1,
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (_, __) => const SizedBox(
                      height: SeniorSpacing.xxsmall,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: SeniorSpacing.small,
              ),
              SeniorButton.primary(
                disabled: selectedSpace == null,
                fullWidth: true,
                label: context.translate.done,
                onPressed: () {
                  Modular.to.pop();
                  if (selectedSpace != null) {
                    widget.onSpaceChanged(selectedSpace!);
                  }
                },
              ),
              const SizedBox(
                height: SeniorSpacing.small,
              ),
            ],
          ),
        );
      },
    );
  }

  void _onScroll() {
    listEnd = ScrollHelper.reachedListEnd(
      scrollController: scrollController,
      maximumScrollExtent: 0.90,
    );
    if (listEnd) {
      getMoreSpaces();
    }
  }

  Future<void> getMoreSpaces() async {
    widget.socialScreenBloc.add(
      GetMoreSocialSpacesEvent(
        socialSpaces: displayedSpacesList,
        paginationRequirements: PaginationRequirements(
          page: nextPage,
          limit: 20,
        ),
      ),
    );
    nextPage = nextPage + 1;
  }
}
