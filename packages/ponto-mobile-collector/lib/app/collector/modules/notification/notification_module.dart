import 'package:flutter_modular/flutter_modular.dart';

import '../routes/notification_collector_routes.dart';
import 'presenter/screens/list_notifications/bloc/list_notifications_screen_bloc.dart';
import 'presenter/screens/list_notifications/list_notifications_screen.dart';

class NotificationCollectorModule extends Module {
  @override
  List<Bind> get binds => [

      ];

  @override
  List<ModularRoute> get routes {
    return [
      ChildRoute(NotificationCollectorRoutes.home,
        child: (_, args) {
          return ListNotificationsScreen(
            listNotificationsScreenBloc:
                Modular.get<ListNotificationsScreenBloc>(),
          );
        },
      ),
    ];
  }
}
