import 'package:flutter_modular/flutter_modular.dart';

import '../../routes/routes.dart';
import 'binds/notification_domain_binds.dart';
import 'binds/notification_external_binds.dart';
import 'binds/notification_infra_binds.dart';
import 'binds/notification_presenter_binds.dart';
import 'presenter/screens/list_notifications/bloc/list_notifications_screen_bloc.dart';
import 'presenter/screens/list_notifications/list_notifications_screen.dart';
import 'presenter/screens/notification_settings_screen/notification_settings_screen.dart';

class NotificationModule extends Module {
  @override
  List<Bind<Object>> get binds {
    return [
      ...NotificationDomainBinds.binds,
      ...NotificationInfraBinds.binds,
      ...NotificationExternalBinds.binds,
      ...NotificationPresenterBinds.binds,
    ];
  }

  @override
  List<ModularRoute> get routes {
    return [
      ChildRoute(
        NotificationRoutes.notificationScreenRoute,
        child: (_, args) {
          return ListNotificationsScreen(
            listNotificationsScreenBloc: Modular.get<ListNotificationsScreenBloc>(),
            employeeId: args.data['employeeId'],
            isWaapiLite: args.data['isWaapiLite'],
            isWaapiLiteProfile: args.data['isWaapiLiteProfile'],
          );
        },
      ),
      ChildRoute(
        NotificationRoutes.notificationSettingsScreenRoute,
        child: (_, args) {
          return NotificationSettingsScreen(
            isWaapiLite: args.data['isWaapiLite'],
          );
        },
      ),
    ];
  }
}
