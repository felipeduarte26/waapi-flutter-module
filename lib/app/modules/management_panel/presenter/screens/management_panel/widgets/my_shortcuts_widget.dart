import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../core/extension/translate_extension.dart';
import '../../../../../../core/helper/snackbar_helper.dart';
import '../../../../../../routes/happiness_index_routes.dart';
import '../../../../../../routes/hyperlink_routes.dart';
import '../../../../../../routes/moods_routes.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../active_contract/presenter/blocs/active_contract_bloc/active_contract_state.dart';
import '../../../../../home/presenter/bloc/connectivity_bloc/connectivity_state.dart';
import '../../../../../moods/presenter/blocs/moods_bloc/moods_state.dart';
import '../../../../../profile/presenter/blocs/user_role/user_role_state.dart';
import '../../../../../social/presenter/bloc/social_screen/social_screen_bloc.dart';
import '../../../../../social/presenter/screen/social_screen.dart';
import '../blocs/management_panel_screen/management_panel_screen_bloc.dart';
import '../blocs/management_panel_screen/management_panel_screen_state.dart';

class MyShortcutsWidget extends StatefulWidget {
  final bool isUserAllowedToViewProfile;
  final bool showProfileButton;
  final bool showFeedbacksButton;
  final bool showVacationsButton;
  final bool showSearchPeople;
  final bool showTimeManagement;
  final bool showFinancialData;
  final bool showMoodDiary;
  final bool showHyperlinks;
  final bool showMoods;
  final bool showSocial;
  final bool isWaapiLiteProfile;
  final int counterUnreadNotifications;

  const MyShortcutsWidget({
    Key? key,
    required this.isUserAllowedToViewProfile,
    required this.showProfileButton,
    required this.showFeedbacksButton,
    required this.showVacationsButton,
    required this.showSearchPeople,
    required this.showTimeManagement,
    required this.showFinancialData,
    required this.showMoodDiary,
    required this.showHyperlinks,
    required this.showMoods,
    required this.isWaapiLiteProfile,
    required this.counterUnreadNotifications,
    required this.showSocial,
  }) : super(key: key);

  @override
  State<MyShortcutsWidget> createState() {
    return _MyShortcutsWidgetState();
  }
}

class _MyShortcutsWidgetState extends State<MyShortcutsWidget> {
  late final ManagementPanelScreenBloc _managementPanelScreenBloc;

  @override
  void initState() {
    super.initState();
    _managementPanelScreenBloc = Modular.get<ManagementPanelScreenBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManagementPanelScreenBloc, ManagementPanelScreenState>(
      bloc: _managementPanelScreenBloc,
      builder: (context, state) {
        final menusShortcuts = <SeniorSquareButtonsMenuItemData>[];
        final offline = (_managementPanelScreenBloc.connectivityBloc.state is OfflineConnectivityState);
        final activeContractBloc = _managementPanelScreenBloc.activeContractBloc.state;
        final userRoleState = _managementPanelScreenBloc.userRoleBloc.state;
        final openMoods = (_managementPanelScreenBloc.moodsBloc.state is LoadedMoodsState)
            ? (_managementPanelScreenBloc.moodsBloc.state as LoadedMoodsState).url
            : '';

        if (widget.isUserAllowedToViewProfile && widget.showProfileButton) {
          menusShortcuts.add(
            SeniorSquareButtonsMenuItemData(
              key: Key('management-panel_screen-profile_button-${UniqueKey()}'),
              onTap: () {
                if (offline) {
                  _showOfflineSnackbar();
                } else {
                  Modular.to.pushNamed(
                    ProfileRoutes.profileScreenInitialRoute,
                    arguments: {
                      'isWaapiLiteProfile': widget.isWaapiLiteProfile,
                      'isOffline': offline,
                      'counterUnreadNotifications': widget.counterUnreadNotifications,
                      'employeeId': (activeContractBloc is LoadedActiveContractState)
                          ? activeContractBloc.activeContractEntity.employeeId
                          : null,
                      'showSearchPerson': widget.showSearchPeople,
                    },
                  );
                }
              },
              icon: FontAwesomeIcons.user,
              text: context.translate.shortcutMyProfile,
              type: SeniorSquareButtonsMenuItemType.neutral,
              disabled: offline,
            ),
          );
        }

        if (widget.showTimeManagement) {
          menusShortcuts.add(
            SeniorSquareButtonsMenuItemData(
              key: Key('management-panel_screen-TimeManagement-${UniqueKey()}'),
              onTap: () {
                Modular.to.pushNamed('/collector/hub_clocking');
              },
              icon: FontAwesomeIcons.clock,
              text: context.translate.timeControlManagement,
              type: SeniorSquareButtonsMenuItemType.neutral,
            ),
          );
        }

        if (widget.showSocial) {
          menusShortcuts.add(
            SeniorSquareButtonsMenuItemData(
              key: Key('management-panel_screen-social_button-${UniqueKey()}'),
              onTap: () {
                return Modular.to.push(
                  MaterialPageRoute(
                    builder: (context) => SocialScreen(
                      socialScreenBloc: Modular.get<SocialScreenBloc>(),
                    ),
                  ),
                );
              },
              icon: FontAwesomeIcons.comments,
              text: context.translate.social,
              disabled: offline,
              type: SeniorSquareButtonsMenuItemType.neutral,
            ),
          );
        }

        if (widget.showFinancialData) {
          menusShortcuts.add(
            SeniorSquareButtonsMenuItemData(
              key: Key('management-panel_screen-financialdata_button-${UniqueKey()}'),
              onTap: () {
                return Modular.to.pushNamed(
                  FinancialDataRoutes.payrollScreenInitialRoute,
                  arguments: {
                    'employeeId': (activeContractBloc is LoadedActiveContractState)
                        ? activeContractBloc.activeContractEntity.employeeId
                        : null,
                  },
                );
              },
              icon: FontAwesomeIcons.moneyCheckDollar,
              text: context.translate.financialData,
              disabled: offline,
              type: SeniorSquareButtonsMenuItemType.neutral,
            ),
          );
        }

        if (widget.showHyperlinks) {
          menusShortcuts.add(
            SeniorSquareButtonsMenuItemData(
              key: Key('management-panel_screen-hyperlinks_button-${UniqueKey()}'),
              onTap: () {
                return Modular.to.pushNamed(
                  HyperlinkRoutes.hyperlinkScreenInitialRoute,
                  arguments: {
                    'employeeId': (activeContractBloc is LoadedActiveContractState)
                        ? activeContractBloc.activeContractEntity.employeeId
                        : null,
                    'userRoleId': (userRoleState is LoadedUserRoleState) ? userRoleState.userRoleId : null,
                  },
                );
              },
              icon: FontAwesomeIcons.link,
              text: context.translate.quickAccess,
              disabled: offline,
              type: SeniorSquareButtonsMenuItemType.neutral,
            ),
          );
        }

        if (widget.showSearchPeople) {
          menusShortcuts.add(
            SeniorSquareButtonsMenuItemData(
              key: const Key('management-panel_screen-people_search_button'),
              onTap: () {
                if (offline) {
                  _showOfflineSnackbar();
                } else {
                  Modular.to.pushNamed(SearchPersonRoutes.searchPersonScreenInitialRoute);
                }
              },
              icon: FontAwesomeIcons.magnifyingGlass,
              text: context.translate.peopleSearch,
              type: SeniorSquareButtonsMenuItemType.neutral,
              disabled: offline,
            ),
          );
        }

        if (widget.showMoodDiary) {
          menusShortcuts.add(
            SeniorSquareButtonsMenuItemData(
              key: const Key('management-panel_screen-happiness_index_button'),
              onTap: () {
                if (offline) {
                  _showOfflineSnackbar();
                } else {
                  Modular.to.pushNamed(
                    HappinessIndexRoutes.happinessIndexScreenInitialRoute,
                    arguments: {
                      'employeeId': (activeContractBloc is LoadedActiveContractState)
                          ? activeContractBloc.activeContractEntity.employeeId
                          : null,
                    },
                  );
                }
              },
              icon: FontAwesomeIcons.faceSmile,
              text: context.translate.moodDiary,
              type: SeniorSquareButtonsMenuItemType.neutral,
              disabled: offline,
            ),
          );
        }

        if (widget.showMoods) {
          menusShortcuts.add(
            SeniorSquareButtonsMenuItemData(
              key: const Key('management-panel_screen-moods_button'),
              onTap: () async {
                if (offline) {
                  _showOfflineSnackbar();
                } else {
                  if (openMoods.isEmpty) {
                    Modular.to.pushNamed(
                      MoodsRoutes.moodsScreenInitialRoute,
                    );
                  } else {
                    await launchUrl(Uri.parse(openMoods));
                  }
                }
              },
              icon: FontAwesomeIcons.messageSmile,
              text: context.translate.moodsTitle,
              type: SeniorSquareButtonsMenuItemType.neutral,
              disabled: offline,
            ),
          );
        }

        if (widget.showFeedbacksButton) {
          menusShortcuts.add(
            SeniorSquareButtonsMenuItemData(
              key: const Key('management-panel_screen-feedbacks_button'),
              onTap: () {
                if (offline) {
                  _showOfflineSnackbar();
                } else {
                  Modular.to.pushNamed(FeedbackRoutes.feedbackScreenInitialRoute);
                }
              },
              icon: FontAwesomeIcons.rightLeft,
              text: context.translate.feedbackTitle,
              type: SeniorSquareButtonsMenuItemType.neutral,
              disabled: offline,
            ),
          );
        }

        if (widget.showVacationsButton && widget.isUserAllowedToViewProfile) {
          menusShortcuts.add(
            SeniorSquareButtonsMenuItemData(
              key: const Key('management-panel_screen-vacations_button'),
              onTap: () {
                if (offline) {
                  _showOfflineSnackbar();
                } else {
                  if (activeContractBloc is LoadedActiveContractState) {
                    return Modular.to.pushNamed(
                      VacationsRoutes.vacationsScreenInitialRoute,
                      arguments: {
                        'employeeId': activeContractBloc.activeContractEntity.employeeId,
                      },
                    );
                  }
                }
              },
              icon: FontAwesomeIcons.plane,
              text: context.translate.vacations,
              type: SeniorSquareButtonsMenuItemType.neutral,
              disabled: offline,
            ),
          );
        }

        if (menusShortcuts.isEmpty) {
          return const SizedBox.shrink();
        }

        return Padding(
          padding: const EdgeInsets.only(
            bottom: SeniorSpacing.normal,
          ),
          child: SeniorSquareButtonsMenu(
            key: const Key('management-panel_screen-list_my_shortcuts'),
            items: menusShortcuts,
            paddingListView: const EdgeInsets.symmetric(
              horizontal: SeniorSpacing.normal,
            ),
          ),
        );
      },
    );
  }

  ScaffoldFeatureController _showOfflineSnackbar() {
    return SnackbarHelper.showSnackbar(
      context: context,
      message: context.translate.featureIsNotAvailableOffline,
    );
  }
}
