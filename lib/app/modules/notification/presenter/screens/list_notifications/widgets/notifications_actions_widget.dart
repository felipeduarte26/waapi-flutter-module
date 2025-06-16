import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../core/extension/translate_extension.dart';
import '../../../../../../routes/routes.dart';

class NotificationsActionsWidget extends StatefulWidget {
  final bool isWaapiLite;

  const NotificationsActionsWidget({
    Key? key,
    required this.isWaapiLite,
  }) : super(key: key);

  @override
  State<NotificationsActionsWidget> createState() {
    return _NotificationsActionsWidgetState();
  }
}

class _NotificationsActionsWidgetState extends State<NotificationsActionsWidget> {
  @override
  Widget build(BuildContext context) {
    final themeRepository = Provider.of<ThemeRepository>(context);
    return Row(
      children: [
        IconButton(
          key: const Key('notifications-notifications_actions-action_button_appbar'),
          icon: SeniorIcon(
            icon: FontAwesomeIcons.solidGear,
            size: SeniorIconSize.small,
            style: SeniorIconStyle(
              color: themeRepository.isCustomTheme()
                  ? SeniorServiceColor.getOptimalContrastColorTheme(
                      color: themeRepository.theme.secondaryColor!,
                    )
                  : SeniorColors.pureWhite,
            ),
          ),
          onPressed: () => Modular.to.pushNamed(
            NotificationRoutes.notificationSettingsScreenInitialRoute,
            arguments: {
              'isWaapiLite': widget.isWaapiLite,
            },
          ),
          tooltip: context.translate.titleSettings,
        ),
      ],
    );
  }
}
