import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../core/constants/assets_path.dart';
import '../../../../core/enums/analytics/waapi_loading_size_enum.dart';
import '../../../../core/extension/media_query_extension.dart';
import '../../../../core/extension/translate_extension.dart';
import '../../../../core/helper/date_time_helper.dart';
import '../../../../core/helper/locale_helper.dart';
import '../../../../core/pagination/pagination_requirements.dart';
import '../../../../core/widgets/error_state_widget.dart';
import '../../../../core/widgets/waapi_loading_widget.dart';
import '../../../authorization/presenter/blocs/authorization_bloc/authorization_state.dart';
import '../../domain/entities/social_profile_entity.dart';
import '../../domain/entities/social_space_entity.dart';
import '../bloc/social_current_profile/social_current_profile_bloc.dart';
import '../bloc/social_current_profile/social_current_profile_event.dart';
import '../bloc/social_current_profile/social_current_profile_state.dart';
import '../bloc/social_profiles/social_profiles_event.dart';
import '../bloc/social_profiles/social_profiles_state.dart';
import '../bloc/social_screen/social_screen_bloc.dart';
import '../bloc/social_spaces/social_spaces_event.dart';
import 'social_create_post_config_list_space_widget.dart';
import 'social_create_post_config_profile_widget.dart';
import 'social_create_post_config_schedule_widget.dart';

class SocialPostConfigWidget extends StatefulWidget {
  final ValueChanged<DateTime> onDateChanged;
  final ValueChanged<String> onHourChanged;
  final ValueChanged<SocialSpaceEntity?> onSpaceChanged;
  final ValueChanged<SocialProfileEntity> onProfileChanged;
  final ValueChanged<bool?> restrictComments;
  final DateTime? dateSelected;
  final String? hourSelected;
  final bool restrictCommentsValue;
  final bool isScheduled;
  final SocialScreenBloc socialScreenBloc;
  final SocialSpaceEntity? selectedSpace;
  final SocialProfileEntity socialProfileEntity;

  const SocialPostConfigWidget({
    Key? key,
    required this.onDateChanged,
    required this.onHourChanged,
    required this.onSpaceChanged,
    required this.onProfileChanged,
    required this.restrictComments,
    this.dateSelected,
    this.hourSelected,
    required this.restrictCommentsValue,
    required this.isScheduled,
    required this.socialScreenBloc,
    this.selectedSpace,
    required this.socialProfileEntity,
  }) : super(key: key);

  @override
  State<SocialPostConfigWidget> createState() => _SocialPostConfigWidgetState();
}

class _SocialPostConfigWidgetState extends State<SocialPostConfigWidget> {
  bool restrictCommentsValue = false;
  bool isPublic = false;
  DateTime? selectedDate;
  String? selectedHour;
  SocialSpaceEntity? selectedSpace;
  bool isScheduled = false;
  List<SocialSpaceEntity> spacesList = [];
  SocialProfileEntity? selectedProfile;
  List<SocialProfileEntity> displayedProfilesList = [];
  List<SocialProfileEntity> personalProfiles = [];
  List<SocialProfileEntity> corporateProfiles = [];
  var paginationRequirements = const PaginationRequirements(
    page: 0,
    limit: 20,
  );

  @override
  void initState() {
    super.initState();
    restrictCommentsValue = widget.restrictCommentsValue;
    isScheduled = widget.hourSelected != null && widget.hourSelected!.isNotEmpty;
    selectedDate = widget.dateSelected;
    selectedHour = widget.hourSelected;
    selectedSpace = widget.selectedSpace;
    isPublic = selectedSpace == null;
    selectedProfile = widget.socialProfileEntity;
  }

  void _getProfiles() {
    widget.socialScreenBloc.socialCurrentProfileBloc.add(GetSocialCurrentProfileEvent());
  }

  @override
  Widget build(BuildContext context) {
    final themeRepository = Provider.of<ThemeRepository>(context);
    bool isDarkColor = themeRepository.isDarkTheme();

    return BlocConsumer<SocialCurrentProfileBloc, SocialCurrentProfileState>(
      bloc: widget.socialScreenBloc.socialCurrentProfileBloc,
      listener: (context, state) {
        if (state is LoadedSocialCurrentProfileState) {
          selectedProfile = state.profile;
        }
      },
      builder: (context, state) {
        if (state is LoadingSocialCurrentProfileState || selectedProfile == null) {
          return const Center(
            child: WaapiLoadingWidget(
              waapiLoadingSizeEnum: WaapiLoadingSizeEnum.small,
            ),
          );
        }

        if (state is ErrorSocialMyProfilesState) {
          return ErrorStateWidget(
            title: context.translate.errorStateSearchSocialProfile,
            subTitle: context.translate.tryAgainSubtitleDescription,
            imagePath: AssetsPath.generalErrorState,
            onTapTryAgain: () => _getProfiles(),
          );
        }

        if (state is LoadedSocialMyProfilesState && displayedProfilesList.isEmpty) {
          return ErrorStateWidget(
            title: context.translate.emptyStateSearchSocialProfile,
            subTitle: context.translate.tryAgainSubtitleDescription,
            imagePath: AssetsPath.generalEmptyState,
            onTapTryAgain: () => _getProfiles(),
          );
        }

        return Padding(
          padding: const EdgeInsets.only(
            bottom: SeniorSpacing.medium,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SeniorText.cta(
                context.translate.publicationSettings,
              ),
              const SizedBox(
                height: SeniorSpacing.normal,
              ),
              SeniorText.body(
                context.translate.chooseProfile,
              ),
              SeniorCard(
                onTap: () async {
                  _pickPerfil();
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
                    SeniorProfilePicture(
                      radius: SeniorCircularElements.small,
                      name: selectedProfile!.name,
                      imageProvider: selectedProfile!.avatarUrl != null && selectedProfile!.avatarUrl!.isNotEmpty
                          ? CachedNetworkImageProvider(selectedProfile!.avatarUrl!)
                          : null,
                    ),
                    const SizedBox(
                      width: SeniorSpacing.small,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SeniorText.cta(
                          selectedProfile!.name,
                          textProperties: const TextProperties(
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        SeniorText.body(
                          selectedProfile!.profileType!.translate(context.translate),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: SeniorSpacing.normal,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: SeniorSpacing.normal,
              ),
              (widget.socialScreenBloc.authorizationBloc.state as LoadedAuthorizationState)
                      .authorizationEntity
                      .socialAuthorizationEntity
                      .canPostFeed
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SeniorText.body(
                          context.translate.publicationLocation,
                        ),
                        const SizedBox(
                          height: SeniorSpacing.medium,
                        ),
                        GestureDetector(
                          onTap: () async {
                            isPublic = true;
                            selectedSpace = null;
                            widget.onSpaceChanged(null);
                            setState(() {});
                          },
                          child: Row(
                            children: [
                              SeniorIcon(
                                icon: isPublic ? FontAwesomeIcons.circleDot : FontAwesomeIcons.circle,
                                style: SeniorIconStyle(
                                  color: isPublic
                                      ? themeRepository.isCustomTheme()
                                          ? SeniorServiceColor.getContrastAdjustedColorTheme(
                                              color: themeRepository.theme.primaryColor!,
                                            )
                                          : SeniorColors.primaryColor
                                      : SeniorColors.grayscale40,
                                ),
                                size: SeniorSpacing.normal,
                              ),
                              const SizedBox(
                                width: SeniorSpacing.small,
                              ),
                              SeniorIcon(
                                icon: FontAwesomeIcons.solidEarthAmericas,
                                style: SeniorIconStyle(
                                  color: isDarkColor ? SeniorColors.grayscale40 : SeniorColors.grayscale50,
                                ),
                                size: SeniorSpacing.normal,
                              ),
                              const SizedBox(
                                width: SeniorSpacing.normal,
                              ),
                              SeniorText.body(context.translate.public),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: SeniorSpacing.xmedium,
                        ),
                        GestureDetector(
                          onTap: () async {
                            _pickGroup(context);
                          },
                          child: Row(
                            children: [
                              SeniorIcon(
                                icon: !isPublic ? FontAwesomeIcons.circleDot : FontAwesomeIcons.circle,
                                style: SeniorIconStyle(
                                  color: !isPublic
                                      ? themeRepository.isCustomTheme()
                                          ? SeniorServiceColor.getContrastAdjustedColorTheme(
                                              color: themeRepository.theme.primaryColor!,
                                            )
                                          : SeniorColors.primaryColor
                                      : SeniorColors.grayscale40,
                                ),
                                size: SeniorSpacing.normal,
                              ),
                              const SizedBox(
                                width: SeniorSpacing.small,
                              ),
                              SeniorIcon(
                                icon: FontAwesomeIcons.solidUserGroup,
                                style: SeniorIconStyle(
                                  color: isDarkColor ? SeniorColors.grayscale40 : SeniorColors.grayscale50,
                                ),
                                size: SeniorSpacing.normal,
                              ),
                              const SizedBox(
                                width: SeniorSpacing.normal,
                              ),
                              Expanded(
                                child: SizedBox(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SeniorText.body(
                                        context.translate.group,
                                      ),
                                      selectedSpace != null
                                          ? SeniorText.small(
                                              selectedSpace!.name,
                                              color: SeniorColors.grayscale90,
                                              textProperties: const TextProperties(
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                              ),
                                            )
                                          : const SizedBox.shrink(),
                                    ],
                                  ),
                                ),
                              ),
                              SeniorIcon(
                                icon: FontAwesomeIcons.solidChevronRight,
                                size: SeniorSpacing.normal,
                                style: SeniorIconStyle(
                                  color: isDarkColor ? SeniorColors.grayscale40 : SeniorColors.grayscale50,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SeniorIcon(
                              icon: FontAwesomeIcons.solidEarthAmericas,
                              size: SeniorSpacing.medium,
                              style: SeniorIconStyle(
                                color: isDarkColor ? SeniorColors.grayscale40 : SeniorColors.grayscale50,
                              ),
                            ),
                            const SizedBox(
                              width: SeniorSpacing.xsmall,
                            ),
                            SeniorText.body(context.translate.group),
                          ],
                        ),
                        const SizedBox(
                          height: SeniorSpacing.small,
                        ),
                        selectedSpace != null
                            ? GestureDetector(
                                onTap: () async {
                                  _pickGroup(context);
                                },
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: SeniorText.labelBold(
                                        selectedSpace != null ? selectedSpace!.name : context.translate.noGroupDefined,
                                        color: SeniorColors.grayscale90,
                                        textProperties: const TextProperties(
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ),
                                    ),
                                    SeniorIcon(
                                      icon: FontAwesomeIcons.solidChevronRight,
                                      size: SeniorSpacing.normal,
                                      style: SeniorIconStyle(
                                        color: isDarkColor ? SeniorColors.grayscale40 : SeniorColors.grayscale50,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: SeniorSpacing.xsmall,
                                  horizontal: SeniorSpacing.normal,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18),
                                  border: Border.all(
                                    width: 1,
                                    color: SeniorColors.grayscale20,
                                  ),
                                  color: themeRepository.theme.calendarTheme!.style!.backgroundColor,
                                ),
                                child: GestureDetector(
                                  onTap: () async {
                                    _pickGroup(context);
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SeniorIcon(
                                        icon: FontAwesomeIcons.plus,
                                        size: SeniorSpacing.normal,
                                        style: SeniorIconStyle(
                                          color: isDarkColor ? SeniorColors.grayscale5 : SeniorColors.grayscale90,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: SeniorSpacing.xxsmall,
                                      ),
                                      Flexible(
                                        child: SeniorText.body(
                                          context.translate.addGroup,
                                          color: SeniorColors.grayscale90,
                                          textProperties: const TextProperties(
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                      ],
                    ),
              SizedBox(
                height: selectedSpace != null ? SeniorSpacing.big : SeniorSpacing.xbig,
              ),
              Row(
                children: [
                  SeniorIcon(
                    icon: FontAwesomeIcons.calendarDays,
                    size: SeniorSpacing.medium,
                    style: SeniorIconStyle(
                      color: isDarkColor ? SeniorColors.grayscale40 : SeniorColors.grayscale50,
                    ),
                  ),
                  const SizedBox(
                    width: SeniorSpacing.xsmall,
                  ),
                  SeniorText.body(
                    context.translate.schedulePublicationOptional,
                  ),
                ],
              ),
              const SizedBox(
                height: SeniorSpacing.small,
              ),
              isScheduled
                  ? GestureDetector(
                      onTap: () async {
                        await _pickDate();
                      },
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SeniorText.small(
                                context.translate.date,
                                color: SeniorColors.grayscale90,
                                textProperties: const TextProperties(
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                              SeniorText.bodyBold(
                                selectedDate != null
                                    ? DateTimeHelper.formatWithDefaultDatePattern(
                                        dateTime: selectedDate!,
                                        locale: LocaleHelper.languageAndCountryCode(
                                          locale: Localizations.localeOf(context),
                                        ),
                                      )
                                    : widget.dateSelected != null
                                        ? DateTimeHelper.formatWithDefaultDatePattern(
                                            dateTime: widget.dateSelected!,
                                            locale: LocaleHelper.languageAndCountryCode(
                                              locale: Localizations.localeOf(context),
                                            ),
                                          )
                                        : '',
                                color: SeniorColors.grayscale90,
                                textProperties: const TextProperties(
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 92,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SeniorText.small(
                                context.translate.hourH,
                                color: SeniorColors.grayscale90,
                                textProperties: const TextProperties(
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                              SeniorText.bodyBold(
                                (selectedHour != null && selectedHour!.isNotEmpty)
                                    ? selectedHour!
                                    : widget.hourSelected ?? '',
                                color: SeniorColors.grayscale90,
                                textProperties: const TextProperties(
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  : Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: SeniorSpacing.xsmall,
                        horizontal: SeniorSpacing.normal,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          width: 1,
                          color: SeniorColors.grayscale20,
                        ),
                        color: themeRepository.theme.cardTheme!.style!.backgroundColor,
                      ),
                      child: GestureDetector(
                        onTap: () async {
                          await _pickDate();
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SeniorIcon(
                              icon: FontAwesomeIcons.plus,
                              size: SeniorSpacing.normal,
                              style: SeniorIconStyle(
                                color: isDarkColor ? SeniorColors.grayscale5 : SeniorColors.grayscale90,
                              ),
                            ),
                            const SizedBox(
                              width: SeniorSpacing.xxsmall,
                            ),
                            Flexible(
                              child: SeniorText.body(
                                context.translate.addDateAndTime,
                                color: SeniorColors.grayscale90,
                                textProperties: const TextProperties(
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
              const SizedBox(
                height: SeniorSpacing.big,
              ),
              Row(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SeniorText.bodyBold(
                        context.translate.limitComments,
                      ),
                      SeniorText.small(
                        restrictCommentsValue ? context.translate.enabled : context.translate.disabled,
                        color: SeniorColors.grayscale90,
                      ),
                    ],
                  ),
                  SeniorSwitch(
                    onChanged: (value) {
                      setState(() {
                        restrictCommentsValue = value!;
                        widget.restrictComments(value);
                      });
                    },
                    value: restrictCommentsValue,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickDate() async {
    final themeRepository = Provider.of<ThemeRepository>(context, listen: false);
    FocusScope.of(context).unfocus();
    await SeniorBottomSheet.showBottomSheet(
      height: context.bottomSheetSizeContacts,
      style: themeRepository.theme.bottomSheetTheme?.style?.copyWith(
        backgroundColor: themeRepository.theme.backdropTheme!.style!.bodyColor,
      ),
      context: context,
      hasCloseButton: true,
      onTapCloseButton: Modular.to.pop,
      content: <Widget>[
        Expanded(
          child: SocialCreatePostConfigScheduleWidget(
            dateSelected: selectedDate,
            hourSelected: selectedHour,
            onDateChanged: (date) {
              setState(() {
                widget.onDateChanged(date);
                selectedDate = date;
              });
            },
            onHourChanged: (hour) {
              setState(() {
                widget.onHourChanged(hour);
                selectedHour = hour;
                isScheduled = (hour.isNotEmpty);
              });
            },
          ),
        ),
      ],
    );
  }

  Future<void> _pickPerfil() async {
    FocusScope.of(context).unfocus();
    await SeniorBottomSheet.showDynamicBottomSheet(
      context: context,
      hasCloseButton: true,
      onTapCloseButton: _closePickPerfil,
      content: [
        SizedBox(
          height: context.bottomSheetSizeContacts * 0.6,
          child: SocialCreatePostConfigProfileWidget(
            socialProfileBloc: widget.socialScreenBloc.socialProfilesBloc,
            onProfileChanged: (profile) {
              Modular.to.pop();
              selectedProfile = profile;
              widget.onProfileChanged(profile);
              setState(() {});
            },
            selectedProfile: selectedProfile,
          ),
        ),
      ],
    );
  }

  void _closePickPerfil() {
    Modular.to.pop();
    widget.socialScreenBloc.socialProfilesBloc.add(ResetSocialMyProfilesEvent());
  }

  void _pickGroup(BuildContext context) {
    SeniorBottomSheet.showBottomSheet(
      height: context.bottomSheetSize * 0.8,
      hasCloseButton: true,
      context: context,
      content: [
        SocialCreatePostConfigListSpaceWidget(
          selectedSpace: selectedSpace,
          socialScreenBloc: widget.socialScreenBloc.socialSpacesBloc,
          onSpaceChanged: (space) {
            selectedSpace = space;
            setState(() {});
            if (selectedSpace != null) {
              widget.onSpaceChanged(selectedSpace!);
              isPublic = false;
            }
          },
        ),
      ],
      onTapCloseButton: () {
        Modular.to.pop();
      },
    );
  }

  Future<void> getSpaces() async {
    widget.socialScreenBloc.socialSpacesBloc.add(
      GetSocialSpacesEvent(
        paginationRequirements: const PaginationRequirements(
          page: 0,
          limit: 20,
        ),
      ),
    );
  }
}
