import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../core/extension/translate_extension.dart';
import '../../../../../../core/helper/snackbar_helper.dart';
import '../../../../../../routes/routes.dart';

class ManagementPanelActionsSeniorColorfulHeaderStructureWidget extends StatelessWidget {
  final String? employeeId;
  final bool disabled;
  final bool showNotificationsIcon;
  final bool isWaapiLite;
  final bool isWaapiLiteProfile;
  final bool showSearchPerson;

  const ManagementPanelActionsSeniorColorfulHeaderStructureWidget({
    Key? key,
    required this.disabled,
    this.employeeId,
    required this.showNotificationsIcon,
    required this.isWaapiLite,
    required this.isWaapiLiteProfile,
    required this.showSearchPerson,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (isWaapiLiteProfile && showSearchPerson)
          IconButton(
            key: const Key('management_panel_screen-action_button_appbar-settings'),
            icon: const Icon(
              FontAwesomeIcons.solidMagnifyingGlass,
              size: SeniorIconSize.small,
            ),
            onPressed: () {
              if (disabled) {
                _showOfflineSnackbar(context);
              } else {
                Modular.to.pushNamed(SearchPersonRoutes.searchPersonScreenInitialRoute);
              }
            },
            tooltip: context.translate.peopleSearch,
          ),
        IconButton(
          key: const Key('management-Panel_screen-action_button_appbar-settings'),
          icon: const Icon(
            FontAwesomeIcons.solidGear,
            size: SeniorIconSize.small,
          ),
          onPressed: () => Modular.to.pushNamed(
            SettingsRoutes.settingsScreenInitialRoute,
            arguments: {
              'disabled': disabled,
              'isWaapiLite': isWaapiLite,
            },
          ),
          tooltip: context.translate.titleSettings,
        ),
      ],
    );
  }

  ScaffoldFeatureController _showOfflineSnackbar(BuildContext context) {
    return SnackbarHelper.showSnackbar(
      context: context,
      message: context.translate.featureIsNotAvailableOffline,
    );
  }
}
