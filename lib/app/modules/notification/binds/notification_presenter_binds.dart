import 'package:flutter_modular/flutter_modular.dart';

import '../presenter/blocs/counter_notifications_bloc/counter_notifications_bloc.dart';
import '../presenter/blocs/list_notifications_bloc/list_notifications_bloc.dart';
import '../presenter/blocs/mark_notification_as_read_bloc/mark_notification_as_read_bloc.dart';
import '../presenter/blocs/notification_settings_bloc/notification_settings_bloc.dart';
import '../presenter/blocs/permission_notification_bloc/permission_notification_bloc.dart';
import '../presenter/screens/list_notifications/bloc/list_notifications_screen_bloc.dart';
import '../presenter/screens/notification_settings_screen/bloc/notification_settings_screen_bloc.dart';

class NotificationPresenterBinds {
  static List<Bind<Object>> binds = [
    // Blocs
    Bind.lazySingleton(
      (i) {
        return PermissionNotificationBloc(
          clearDeviceTokenUsecase: i.get(),
          getDeviceTokenUsecase: i.get(),
          getNativePermissionNotificationUsecase: i.get(),
          registerDeviceTokenUsecase: i.get(),
          saveNativePermissionNotificationUsecase: i.get(),
          openNativeAppSettingsUsecase: i.get(),
        );
      },
      export: true,
    ),

    Bind.lazySingleton(
      (i) {
        return CounterNotificationsBloc(
          getNumberUnreadNotificationsUsecase: i.get(),
        );
      },
      export: true,
    ),

    Bind.lazySingleton((i) {
      return ListNotificationsBloc(
        clearAllUserNotificationsUsecase: i.get(),
        getListRecentNotificationsUseCase: i.get(),
      );
    }),

    Bind.lazySingleton((i) {
      return NotificationSettingsScreenBloc(
        notificationSettingsBloc: i.get(),
        permissionNotificationBloc: i.get(),
      );
    }),

    Bind.lazySingleton((i) {
      return ListNotificationsScreenBloc(
        listNotificationsBloc: i.get(),
        markNotificationAsReadBloc: i.get(),
        moodsBloc: i.get(),
      );
    }),

    Bind.lazySingleton((i) {
      return MarkNotificationAsReadBloc(
        markNotificationAsReadUsecase: i.get(),
      );
    }),

    Bind.lazySingleton((i) {
      return NotificationSettingsBloc(
        getUserNotificationSettingsUsecase: i.get(),
        toggleUserNotificationSettingUsecase: i.get(),
      );
    }),
  ];
}
