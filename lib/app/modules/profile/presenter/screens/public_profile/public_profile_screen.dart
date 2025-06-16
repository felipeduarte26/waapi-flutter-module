import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';
import '../../../../../core/extension/media_query_extension.dart';
import '../../../../../core/extension/translate_extension.dart';
import '../../../../../core/helper/date_time_helper.dart';
import '../../../../../core/helper/locale_helper.dart';
import '../../../../../core/pagination/pagination_requirements.dart';
import '../../../../../core/theme/waapi_style_theme.dart';
import '../../../../../core/widgets/employee_bottom_sheet_widget.dart';
import '../../../../../core/widgets/waapi_colorful_header.dart';
import '../../../../../core/widgets/waapi_loading_widget.dart';
import '../../../../../routes/routes.dart';
import '../../../../authorization/domain/entities/authorization_entity.dart';
import '../../../../authorization/presenter/blocs/authorization_bloc/authorization_state.dart';
import '../../../../feedback/enums/feedback_analytics_type_enum.dart';
import '../../../enums/gender_type_enum.dart';
import '../../blocs/public_feedbacks_bloc/public_feedbacks_event.dart';
import '../../blocs/public_feedbacks_bloc/public_feedbacks_state.dart';
import '../../blocs/public_profile_bloc/public_profile_bloc.dart';
import '../../blocs/public_profile_bloc/public_profile_event.dart';
import '../../blocs/public_profile_bloc/public_profile_state.dart';
import '../emergencial_contacts_screen/widgets/emergencial_contacts_card_widget.dart';
import 'bloc/public_profile_screen_bloc.dart';
import 'bloc/public_profile_screen_state.dart';
import 'widgets/public_profile_feedbacks_listview_widget.dart';

class PublicProfileScreen extends StatefulWidget {
  final String username;

  const PublicProfileScreen({
    Key? key,
    required this.username,
  }) : super(key: key);

  @override
  State<PublicProfileScreen> createState() {
    return _PublicProfileScreenState();
  }
}

class _PublicProfileScreenState extends State<PublicProfileScreen> {
  late final PublicProfileScreenBloc publicProfileScreenBloc;
  late ScrollController _scrollController;

  var nextPage = 1;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    publicProfileScreenBloc = Modular.get<PublicProfileScreenBloc>();

    publicProfileScreenBloc.publicProfileBloc.add(
      GetPublicProfileEvent(
        userName: widget.username,
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WaapiColorfulHeader(
        hasTopPadding: false,
        titleLabel: context.translate.publicProfile,
        body: MultiBlocListener(
          listeners: [
            BlocListener<PublicProfileBloc, PublicProfileState>(
              bloc: publicProfileScreenBloc.publicProfileBloc,
              listener: (context, state) {
                if (state is ErrorPublicProfileState) {
                  Modular.to.pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SeniorSnackBar.error(
                      message: context.translate.errorOnGetPublicProfile,
                      action: SeniorSnackBarAction(
                        label: context.translate.repeat,
                        onPressed: () => Modular.to.pushNamed(
                          ProfileRoutes.publicProfileScreenInitialRoute,
                          arguments: widget.username,
                        ),
                      ),
                    ),
                  );
                }

                if (state is LoadedPublicProfileState) {
                  publicProfileScreenBloc.publicFeedbacksBloc.add(
                    GetPublicFeedbacksEvent(
                      employeeId: state.publicProfileEntity.personId,
                      paginationRequirements: const PaginationRequirements(
                        page: 1,
                        limit: 10,
                      ),
                    ),
                  );
                  nextPage++;
                }
              },
            ),
          ],
          child: BlocBuilder<PublicProfileScreenBloc, PublicProfileScreenState>(
            bloc: publicProfileScreenBloc,
            builder: (context, state) {
              final publicProfileState = state.publicProfileState;
              final publicFeedbacksState = state.publicFeedbacksState;

              if (publicProfileState is LoadingPublicProfileState ||
                  publicProfileScreenBloc is InitialPublicProfileState) {
                return const WaapiLoadingWidget();
              }

              if (publicProfileState is LoadedPublicProfileState) {
                final publicProfile = publicProfileState.publicProfileEntity;
                final authorizationState = state.authorizationState;

                AuthorizationEntity? authorizationEntity;

                if (authorizationState is LoadedAuthorizationState) {
                  authorizationEntity = authorizationState.authorizationEntity;
                }

                final showWriteFeedbackButton = authorizationEntity?.allowToWriteFeedback ?? false;
                final showRequestFeedbackButton = authorizationEntity?.allowToRequestFeedback ?? false;

                final userInfosMenu = <SeniorMenuItemList>[];

                if (publicProfile.showBirthday && publicProfile.birthDate != null) {
                  String? bornOnFlag;

                  switch (publicProfile.gender) {
                    case GenderTypeEnum.female:
                      bornOnFlag = context.translate.bornOnFemale;
                      break;
                    case GenderTypeEnum.male:
                      bornOnFlag = context.translate.bornOnMale;
                      break;
                    case null:
                      bornOnFlag = context.translate.bornOnGeneric;
                      break;
                  }

                  final dateTimeFlag = DateTimeHelper.formatWithMMMMdPattern(
                    dateTime: publicProfile.birthDate!,
                    locale: LocaleHelper.languageAndCountryCode(
                      locale: Localizations.localeOf(context),
                    ),
                  );

                  userInfosMenu.add(
                    SeniorMenuItemList(
                      title: '$bornOnFlag $dateTimeFlag',
                      leading: const SeniorIcon(
                        icon: FontAwesomeIcons.solidCakeCandles,
                        size: SeniorSpacing.medium,
                      ),
                    ),
                  );
                }

                if (publicProfile.emails != null) {
                  for (final email in publicProfile.emails!) {
                    if (email.email != null) {
                      userInfosMenu.add(
                        SeniorMenuItemList(
                          title: email.email!,
                          leading: const SeniorIcon(
                            icon: FontAwesomeIcons.solidEnvelope,
                            size: SeniorSpacing.medium,
                          ),
                        ),
                      );
                    }
                  }
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: SeniorSpacing.normal,
                  ),
                  child: Stack(
                    children: [
                      CustomScrollView(
                        controller: _scrollController,
                        slivers: [
                          SliverToBoxAdapter(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: SeniorSpacing.medium),
                                        child: SeniorProfilePicture(
                                          radius: SeniorCircularElements.medium,
                                          name: publicProfile.name,
                                          imageProvider: NetworkImage(publicProfile.photoUrl),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: SeniorSpacing.xsmall,
                                      ),
                                      SeniorText.label(
                                        publicProfile.name,
                                        textProperties: const TextProperties(
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      if (publicProfile.jobPosition != null)
                                        SeniorText.small(
                                          publicProfile.jobPosition!,
                                          textProperties: const TextProperties(
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                        ),
                                      if (publicProfile.department != null)
                                        SeniorText.small(
                                          publicProfile.department!,
                                          textProperties: const TextProperties(
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                Container(
                                  color: SeniorColors.primaryColor100,
                                  height: 1,
                                  margin: const EdgeInsets.only(
                                    top: SeniorSpacing.normal,
                                  ),
                                ),
                                const SizedBox(
                                  height: SeniorSpacing.small,
                                ),
                                if (userInfosMenu.isNotEmpty) ...[
                                  SeniorText.body(
                                    context.translate.personalData,
                                    textProperties: const TextProperties(textAlign: TextAlign.start),
                                  ),
                                  ...userInfosMenu,
                                  const SizedBox(
                                    height: 5,
                                  ),
                                ],
                                if (publicProfile.profileSummary != null) ...[
                                  SeniorText.body(
                                    context.translate.professionalOverview,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: SeniorSpacing.small),
                                    child: SizedBox(
                                      height: 200,
                                      child: SeniorQuotes(
                                        message: publicProfile.profileSummary!,
                                        isScrollable: true,
                                        isExpanded: false,
                                        margin: EdgeInsets.zero,
                                      ),
                                    ),
                                  ),
                                ],
                                if (publicProfile.emergencialContact != null &&
                                    publicProfile.emergencialContact!.isNotEmpty) ...[
                                  SeniorText.body(
                                    context.translate.emergencyContacts,
                                  ),
                                ],
                              ],
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              padding: EdgeInsets.only(
                                bottom: context.bottomSize,
                              ),
                              itemCount: publicProfile.emergencialContact!.length,
                              itemBuilder: (_, index) {
                                return Container(
                                  margin: const EdgeInsets.only(
                                    left: SeniorSpacing.xxxsmall,
                                    right: SeniorSpacing.xxxsmall,
                                  ),
                                  child: EmergencialContactsCardWidget(
                                    emergencialContactEntity: publicProfile.emergencialContact![index],
                                    index: index,
                                    isPublicProfile: true,
                                  ),
                                );
                              },
                            ),
                          ),
                          if (publicFeedbacksState is LoadingPublicFeedbacksState)
                            const SliverToBoxAdapter(
                              child: Center(
                                child: WaapiLoadingWidget(),
                              ),
                            ),
                          if (publicFeedbacksState.publicFeedbacks?.isNotEmpty == true &&
                              (publicFeedbacksState is LoadedPublicFeedbacksState ||
                                  publicFeedbacksState is LoadingMorePublicFeedbacksState ||
                                  publicFeedbacksState is ErrorPublicFeedbacksState ||
                                  publicFeedbacksState is LastPagePublicFeedbacksState)) ...[
                            SliverToBoxAdapter(
                              child: SeniorText.body(
                                context.translate.feedbackTitle,
                              ),
                            ),
                            PublicProfileFeedbacksListViewWidget(
                              publicProfileScreenBloc: publicProfileScreenBloc,
                              scrollController: _scrollController,
                            ),
                          ],
                          const SliverToBoxAdapter(
                            child: SizedBox(
                              height: 180,
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          color: Provider.of<ThemeRepository>(context)
                              .theme
                              .colorfulHeaderStructureTheme!
                              .style!
                              .bodyColor,
                          child: EmployeeBottomSheetWidget(
                            horizontalPadding: false,
                            key: const Key('public_profile-public_profile_screen-bottom_sheet'),
                            seniorButtons: [
                              Offstage(
                                offstage: !showWriteFeedbackButton,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: SeniorSpacing.normal,
                                  ),
                                  child: SeniorButton(
                                    key: const Key('public_profile-public_profile_screen-button-write_feedback'),
                                    fullWidth: true,
                                    label: context.translate.writeFeedback,
                                    onPressed: () async {
                                      await Modular.to.pushNamed(
                                        FeedbackRoutes.writeFeedbackScreenInitialRoute,
                                        arguments: {
                                          'feedbackAnalyticsTypeEnum': FeedbackAnalyticsTypeEnum.publicProfile,
                                          'personId': publicProfile.personId,
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Offstage(
                                offstage: !showRequestFeedbackButton,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: SeniorSpacing.normal,
                                  ),
                                  child: SeniorButton(
                                    key: const Key('public_profile-public_profile_screen-button-request_feedback'),
                                    fullWidth: true,
                                    label: context.translate.requestFeedback,
                                    onPressed: () async {
                                      await Modular.to.pushNamed(
                                        FeedbackRoutes.requestFeedbackScreenInitialRoute,
                                        arguments: {
                                          'personId': publicProfile.personId,
                                        },
                                      );
                                    },
                                    style: WaapiStyleTheme.waapiSeniorButtonGhostOutlinedStyle(context),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
