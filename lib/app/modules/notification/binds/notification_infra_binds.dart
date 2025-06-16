import 'package:flutter_modular/flutter_modular.dart';
import 'package:platform/platform.dart';

import '../domain/repositories/clear_all_user_notifications_repository.dart';
import '../domain/repositories/clear_device_token_repository.dart';
import '../domain/repositories/get_device_token_repository.dart';
import '../domain/repositories/get_list_recent_notifications_repository.dart';
import '../domain/repositories/get_native_permission_notification_repository.dart';
import '../domain/repositories/get_number_unread_notifications_repository.dart';
import '../domain/repositories/get_user_notification_settings_repository.dart';
import '../domain/repositories/mark_notification_as_read_repository.dart';
import '../domain/repositories/open_native_app_settings_repository.dart';
import '../domain/repositories/register_device_token_repository.dart';
import '../domain/repositories/save_native_permission_notification_repository.dart';
import '../domain/repositories/toggle_user_notification_setting_repository.dart';
import '../infra/adapters/notification_entity_adapter.dart';
import '../infra/adapters/notification_parameters_entity_adapter.dart';
import '../infra/adapters/user_notification_setting_entity_adapter.dart';
import '../infra/repositories/clear_all_user_notifications_repository_impl.dart';
import '../infra/repositories/clear_device_token_repository_impl.dart';
import '../infra/repositories/get_device_token_repository_impl.dart';
import '../infra/repositories/get_list_recent_notifications_repository_impl.dart';
import '../infra/repositories/get_native_permission_notification_repository_impl.dart';
import '../infra/repositories/get_number_unread_notifications_repository_impl.dart';
import '../infra/repositories/get_user_notification_settings_repository_impl.dart';
import '../infra/repositories/mark_notification_as_read_repository_impl.dart';
import '../infra/repositories/open_native_app_settings_repository_impl.dart';
import '../infra/repositories/register_device_token_repository_impl.dart';
import '../infra/repositories/save_native_permission_notification_repository_impl.dart';
import '../infra/repositories/toggle_user_notification_setting_repository_impl.dart';

class NotificationInfraBinds {
  static List<Bind<Object>> binds = [
    // Repositories
    Bind.lazySingleton<ClearDeviceTokenRepository>(
      (i) {
        return ClearDeviceTokenRepositoryImpl(
          clearDeviceTokenDatasource: i.get(),
          getAlreadyClearTokenDriver: i.get(),
          saveAlreadyClearTokenDriver: i.get(),
          errorLoggingService: i.get(),
        );
      },
      export: true,
    ),

    Bind.lazySingleton<GetNumberUnreadNotificationsRepository>(
      (i) {
        return GetNumberUnreadNotificationsRepositoryImpl(
          getNumberUnreadNotificationsDatasource: i.get(),
          errorLoggingService: i.get(),
        );
      },
      export: true,
    ),

    Bind.lazySingleton<GetDeviceTokenRepository>(
      (i) {
        return GetDeviceTokenRepositoryImpl(
          getDeviceTokenDriver: i.get(),
          errorLoggingService: i.get(),
        );
      },
      export: true,
    ),

    Bind.lazySingleton<GetNativePermissionNotificationRepository>(
      (i) {
        return GetNativePermissionNotificationRepositoryImpl(
          getNativePermissionNotificationDriver: i.get(),
          getSavedPermissionNotificationDriver: i.get(),
          saveNativePermissionNotificationDriver: i.get(),
          localPlatform: const LocalPlatform(),
          errorLoggingService: i.get(),
        );
      },
      export: true,
    ),

    Bind.lazySingleton<RegisterDeviceTokenRepository>(
      (i) {
        return RegisterDeviceTokenRepositoryImpl(
          registerDeviceTokenDatasource: i.get(),
          errorLoggingService: i.get(),
          saveAlreadyClearTokenDriver: i.get(),
        );
      },
      export: true,
    ),

    Bind.lazySingleton<SaveNativePermissionNotificationRepository>(
      (i) {
        return SaveNativePermissionNotificationRepositoryImpl(
          saveNativePermissionNotificationDriver: i.get(),
          errorLoggingService: i.get(),
        );
      },
      export: true,
    ),

    Bind.lazySingleton<GetUserNotificationSettingsRepository>((i) {
      return GetUserNotificationSettingsRepositoryImpl(
        getUserNotificationSettingsDatasource: i.get(),
        userNotificationSettingEntityAdapter: UserNotificationSettingEntityAdapter(),
        errorLoggingService: i.get(),
      );
    }),

    Bind.lazySingleton<ClearAllUserNotificationsRepository>((i) {
      return ClearAllUserNotificationsRepositoryImpl(
        clearAllUserNotificationsDatasource: i.get(),
        errorLoggingService: i.get(),
        analyticsService: i.get(),
      );
    }),

    Bind.lazySingleton<ToggleUserNotificationSettingRepository>((i) {
      return ToggleUserNotificationSettingRepositoryImpl(
        toggleUserNotificationSettingDatasource: i.get(),
        errorLoggingService: i.get(),
        analyticsService: i.get(),
      );
    }),

    Bind.lazySingleton<GetListRecentNotificationsRepository>((i) {
      return GetListRecentNotificationsRepositoryImpl(
        getListRecentNotificationsDatasource: i.get(),
        errorLoggingService: i.get(),
        notificationEntityAdapter: i.get(),
      );
    }),

    Bind.lazySingleton<MarkNotificationAsReadRepository>((i) {
      return MarkNotificationAsReadRepositoryImpl(
        markNotificationAsReadDatasource: i.get(),
        errorLoggingService: i.get(),
      );
    }),

    Bind.lazySingleton<OpenNativeAppSettingsRepository>(
      (i) {
        return OpenNativeAppSettingsRepositoryImpl(
          openNativeAppSettingsDriver: i.get(),
          errorLoggingService: i.get(),
        );
      },
      export: true,
    ),

    // Entity adapters
    Bind.lazySingleton((i) {
      return NotificationEntityAdapter(
        notificationParametersEntityAdapter: i.get(),
      );
    }),

    Bind.lazySingleton((i) {
      return NotificationParametersEntityAdapter();
    }),
  ];
}
