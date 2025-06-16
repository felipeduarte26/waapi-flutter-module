import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../core/extension/translate_extension.dart';
import '../../../../../core/widgets/waapi_colorful_header.dart';
import '../../../../management_panel/presenter/screens/management_panel/widgets/management_panel_actions_senior_colorful_header_structure_widget.dart';
import '../../../../management_panel/presenter/screens/management_panel/widgets/waapi_lite_information_widget.dart';
import 'widgets/profile_menu_widget.dart';
import 'widgets/user_profile_information_widget.dart';

class ProfileMenuScreen extends StatelessWidget {
  final bool isWaapiLiteProfile;
  final int? counterUnreadNotifications;
  final String? employeeId;
  final bool isOffline;
  final bool showSearchPerson;

  const ProfileMenuScreen({
    Key? key,
    required this.isWaapiLiteProfile,
    required this.isOffline,
    required this.showSearchPerson,
    this.counterUnreadNotifications = 0,
    this.employeeId = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WaapiColorfulHeader(
        hasTopPadding: false,
        hideLeading: isWaapiLiteProfile,
        titleLabel: isWaapiLiteProfile ? context.translate.appTitle : context.translate.shortcutMyProfile,
        notification: isWaapiLiteProfile
            ? NotificationMessage(
                message: context.translate.waapiLiteNotification,
                messageType: MessageTypes.messageInfo,
                icon: FontAwesomeIcons.solidCircleInfo,
                showCloseButton: false,
                actionNotification: ActionNotification(
                  actionName: context.translate.checkOut,
                  action: () {
                    _showNotificationDescription(context);
                  },
                ),
              )
            : null,
        actions: isWaapiLiteProfile
            ? [
                ManagementPanelActionsSeniorColorfulHeaderStructureWidget(
                  employeeId: employeeId,
                  disabled: isOffline,
                  showNotificationsIcon: true,
                  isWaapiLite: true,
                  isWaapiLiteProfile: isWaapiLiteProfile,
                  showSearchPerson: showSearchPerson,
                ),
              ]
            : null,
        body: const Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: SeniorSpacing.normal,
            ),
            UserProfileInformationWidget(
              key: Key('profile-profile_menu_screen-user_profile_information'),
            ),
            SizedBox(
              height: SeniorSpacing.normal,
            ),
            Expanded(
              child: ProfileMenuWidget(
                key: Key('profile-profile_menu_screen-profile_menu'),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: SeniorColors.neutralColor100,
    );
  }

  void _showNotificationDescription(BuildContext context) {
    SeniorBottomSheet.showDynamicBottomSheet(
      title: context.translate.moodDiary,
      context: context,
      content: [
        const WaapiLiteInformationWidget(),
      ],
      hasCloseButton: true,
      onTapCloseButton: () {
        Modular.to.pop();
      },
    );
  }
}
