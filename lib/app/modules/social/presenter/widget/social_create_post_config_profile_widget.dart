import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../core/constants/assets_path.dart';
import '../../../../core/enums/analytics/waapi_loading_size_enum.dart';
import '../../../../core/extension/translate_extension.dart';
import '../../../../core/widgets/error_state_widget.dart';
import '../../../../core/widgets/waapi_loading_widget.dart';
import '../../domain/entities/social_profile_entity.dart';
import '../../enums/social_profile_type_enum.dart';
import '../bloc/social_profiles/social_profiles_bloc.dart';
import '../bloc/social_profiles/social_profiles_event.dart';
import '../bloc/social_profiles/social_profiles_state.dart';

class SocialCreatePostConfigProfileWidget extends StatefulWidget {
  final SocialProfilesBloc socialProfileBloc;
  final ValueChanged<SocialProfileEntity> onProfileChanged;
  final SocialProfileEntity? selectedProfile;
  final List<SocialProfileEntity>? displayedProfilesList;

  const SocialCreatePostConfigProfileWidget({
    super.key,
    required this.socialProfileBloc,
    required this.onProfileChanged,
    this.selectedProfile,
    this.displayedProfilesList,
  });

  @override
  State<SocialCreatePostConfigProfileWidget> createState() => _SocialCreatePostConfigProfileWidgetState();
}

class _SocialCreatePostConfigProfileWidgetState extends State<SocialCreatePostConfigProfileWidget> {
  List<SocialProfileEntity> displayedProfilesList = [];
  SocialProfileEntity? selectedProfile;
  List<SocialProfileEntity> personalProfiles = [];
  List<SocialProfileEntity> corporateProfiles = [];

  @override
  void initState() {
    selectedProfile = widget.selectedProfile;
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getMyProfiles();
    });
  }

  void _getMyProfiles() {
    widget.socialProfileBloc.add(
      GetSocialMyProfilesEvent(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeRepository = Provider.of<ThemeRepository>(context);
    bool isDarkColor = themeRepository.isDarkTheme();
    return BlocConsumer<SocialProfilesBloc, SocialProfilesState>(
      bloc: widget.socialProfileBloc,
      listener: (context, state) {
        if (state is LoadedSocialMyProfilesState) {
          displayedProfilesList = state.profiles;
          personalProfiles = displayedProfilesList
              .where((profile) => profile.profileType == SocialProfileTypeEnum.userProfile)
              .toList();
          corporateProfiles = displayedProfilesList
              .where((profile) => profile.profileType == SocialProfileTypeEnum.corporateProfile)
              .toList();
        }
      },
      builder: (context, state) {
        if (state is LoadingSocialMyProfilesState) {
          return const Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: WaapiLoadingWidget(
                    waapiLoadingSizeEnum: WaapiLoadingSizeEnum.small,
                  ),
                ),
              ],
            ),
          );
        }

        if (state is ErrorSocialMyProfilesState) {
          return ErrorStateWidget(
            title: context.translate.errorStateSearchSocialProfile,
            subTitle: context.translate.tryAgainSubtitleDescription,
            imagePath: AssetsPath.generalErrorState,
            onTapTryAgain: () => _getMyProfiles,
          );
        }

        if (state is LoadedSocialMyProfilesState && displayedProfilesList.isEmpty) {
          return ErrorStateWidget(
            title: context.translate.emptyStateSearchSocialProfile,
            subTitle: context.translate.tryAgainSubtitleDescription,
            imagePath: AssetsPath.generalEmptyState,
            onTapTryAgain: () => _getMyProfiles,
          );
        }

        return ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemCount: personalProfiles.length + corporateProfiles.length + 1 + (corporateProfiles.isNotEmpty ? 1 : 0),
          itemBuilder: (_, index) {
            if (index == 0) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SeniorText.cta(
                    context.translate.chooseProfile,
                  ),
                  const SizedBox(
                    height: SeniorSpacing.small,
                  ),
                  SeniorText.body(
                    context.translate.personalProfile,
                  ),
                  const SizedBox(
                    height: SeniorSpacing.small,
                  ),
                ],
              );
            }

            if (index == personalProfiles.length + 1 && corporateProfiles.isNotEmpty) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: SeniorSpacing.normal,
                  ),
                  SeniorText.body(
                    context.translate.corporateProfile,
                  ),
                  const SizedBox(
                    height: SeniorSpacing.small,
                  ),
                ],
              );
            }

            final profileIndex = index - 1;

            SocialProfileEntity profile;
            if (profileIndex < personalProfiles.length) {
              profile = personalProfiles[profileIndex];
            } else {
              profile =
                  corporateProfiles[profileIndex - personalProfiles.length - (corporateProfiles.isNotEmpty ? 1 : 0)];
            }

            final isSelected = profile == selectedProfile;

            return SeniorCard(
              margin: EdgeInsets.zero,
              onTap: () async {
                selectedProfile = profile;
                widget.onProfileChanged(selectedProfile!);
                setState(() {});
              },
              padding: EdgeInsets.zero,
              rightIcon: FontAwesomeIcons.chevronRight,
              rightIconColor: isDarkColor ? SeniorColors.grayscale40 : SeniorColors.grayscale50,
              style: const SeniorCardStyle(
                backgroundColor: Colors.transparent,
                backgroundColorIfElevated: Colors.transparent,
              ),
              child: Row(
                children: [
                  SeniorIcon(
                    icon: isSelected ? FontAwesomeIcons.circleDot : FontAwesomeIcons.circle,
                    style: SeniorIconStyle(
                      color: isSelected
                          ? themeRepository.isCustomTheme()
                              ? SeniorServiceColor.getContrastAdjustedColorTheme(
                                  color: themeRepository.theme.primaryColor!,
                                )
                              : SeniorColors.primaryColor500
                          : SeniorColors.grayscale40,
                    ),
                    size: SeniorSpacing.normal,
                  ),
                  const SizedBox(
                    width: SeniorSpacing.normal,
                  ),
                  SeniorProfilePicture(
                    radius: SeniorCircularElements.small,
                    name: profile.name,
                    imageProvider: profile.avatarUrl != null && profile.avatarUrl!.isNotEmpty
                        ? CachedNetworkImageProvider(profile.avatarUrl!)
                        : null,
                  ),
                  const SizedBox(
                    width: SeniorSpacing.small,
                  ),
                  SeniorText.cta(
                    profile.name,
                    textProperties: const TextProperties(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  const SizedBox(
                    width: SeniorSpacing.normal,
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
