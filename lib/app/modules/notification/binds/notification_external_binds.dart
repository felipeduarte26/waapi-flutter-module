import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:platform/platform.dart';

import '../external/datasources/clear_all_user_notifications_datasource_impl.dart';
import '../external/datasources/clear_device_token_datasource_impl.dart';
import '../external/datasources/get_list_recent_notifications_datasource_impl.dart';
import '../external/datasources/get_number_unread_notifications_datasource_impl.dart';
import '../external/datasources/get_user_notification_settings_datasource_impl.dart';
import '../external/datasources/mark_notification_as_read_datasource_impl.dart';
import '../external/datasources/register_device_token_datasource_impl.dart';
import '../external/datasources/toggle_user_notification_setting_datasource_impl.dart';
import '../external/drivers/get_device_token_driver_impl.dart';
import '../external/drivers/get_last_token_saved_driver_impl.dart';
import '../external/drivers/get_native_permission_notification_driver_impl.dart';
import '../external/drivers/get_saved_permission_notification_driver_impl.dart';
import '../external/drivers/open_native_app_settings_driver_impl.dart';
import '../external/drivers/save_last_token_saved_driver_impl.dart';
import '../external/drivers/save_native_permission_notification_driver_impl.dart';
import '../external/mappers/notification_model_mapper.dart';
import '../external/mappers/notification_parameters_model_mapper.dart';
import '../external/mappers/toggle_notification_setting_input_model_mapper.dart';
import '../external/mappers/user_notification_setting_model_mapper.dart';
import '../infra/datasources/clear_all_user_notifications_datasource.dart';
import '../infra/datasources/clear_device_token_datasource.dart';
import '../infra/datasources/get_list_recent_notifications_datasource.dart';
import '../infra/datasources/get_number_unread_notifications_datasource.dart';
import '../infra/datasources/get_user_notification_settings_datasource.dart';
import '../infra/datasources/mark_notification_as_read_datasource.dart';
import '../infra/datasources/register_device_token_datasource.dart';
import '../infra/datasources/toggle_user_notification_setting_datasource.dart';
import '../infra/drivers/get_device_token_driver.dart';
import '../infra/drivers/get_last_token_saved_driver.dart';
import '../infra/drivers/get_native_permission_notification_driver.dart';
import '../infra/drivers/get_saved_permission_notification_driver.dart';
import '../infra/drivers/open_native_app_settings_driver.dart';
import '../infra/drivers/save_last_token_saved_driver.dart';
import '../infra/drivers/save_native_permission_notification_driver.dart';

class NotificationExternalBinds {
  static List<Bind<Object>> binds = [
    // Datasources
    Bind.lazySingleton<ClearDeviceTokenDatasource>(
      (i) {
        return ClearDeviceTokenDatasourceImpl(
          restService: i.get(),
        );
      },
      export: true,
    ),

    Bind.lazySingleton<GetNumberUnreadNotificationsDatasource>(
      (i) {
        return GetNumberUnreadNotificationsDatasourceImpl(
          restService: i.get(),
        );
      },
      export: true,
    ),

    Bind.lazySingleton<GetListRecentNotificationsDatasource>((i) {
      return GetListRecentNotificationsDatasourceImpl(
        notificationModelMapper: i.get(),
        restService: i.get(),
      );
    }),

    Bind.lazySingleton<ClearAllUserNotificationsDatasource>((i) {
      return ClearAllUserNotificationsDatasourceImpl(
        restService: i.get(),
      );
    }),

    Bind.lazySingleton<RegisterDeviceTokenDatasource>(
      (i) {
        return RegisterDeviceTokenDatasourceImpl(
          localPlatform: const LocalPlatform(),
          restService: i.get(),
        );
      },
      export: true,
    ),

    Bind.lazySingleton<GetUserNotificationSettingsDatasource>((i) {
      return GetUserNotificationSettingsDatasourceImpl(
        restService: i.get(),
        userNotificationSettingModelMapper: UserNotificationSettingModelMapper(),
      );
    }),

    Bind.lazySingleton<ToggleUserNotificationSettingDatasource>((i) {
      return ToggleUserNotificationSettingDatasourceImpl(
        restService: i.get(),
        toggleNotificationSettingInputModelMapper: ToggleNotificationSettingInputModelMapper(),
      );
    }),

    Bind.lazySingleton<MarkNotificationAsReadDatasource>((i) {
      return MarkNotificationAsReadDatasourceImpl(
        restService: i.get(),
      );
    }),

    // Drivers
    Bind.lazySingleton<GetDeviceTokenDriver>(
      (i) {
        return GetDeviceTokenDriverImpl(
          firebaseMessaging: FirebaseMessaging.instance,
        );
      },
      export: true,
    ),

    Bind.lazySingleton<GetNativePermissionNotificationDriver>(
      (i) {
        return GetNativePermissionNotificationDriverImpl(
          firebaseMessaging: FirebaseMessaging.instance,
        );
      },
      export: true,
    ),

    Bind.lazySingleton<SaveNativePermissionNotificationDriver>(
      (i) {
        return SaveNativePermissionNotificationDriverImpl(
          internalStorageService: i.get(),
        );
      },
      export: true,
    ),

    Bind.lazySingleton<GetSavedPermissionNotificationDriver>(
      (i) {
        return GetSavedPermissionNotificationDriverImpl(
          internalStorageService: i.get(),
        );
      },
      export: true,
    ),

    Bind.lazySingleton<GetLastTokenSavedDriver>(
      (i) {
        return GetLastTokenSavedDriverImpl(
          internalStorageService: i.get(),
        );
      },
      export: true,
    ),

    Bind.lazySingleton<SaveLastTokenSavedDriver>(
      (i) {
        return SaveLastTokenSavedDriverImpl(
          internalStorageService: i.get(),
        );
      },
      export: true,
    ),

    Bind.lazySingleton<OpenNativeAppSettingsDriver>(
      (i) {
        return OpenNativeAppSettingsDriverImpl(
          nativeSettingsService: i.get(),
        );
      },
      export: true,
    ),

    // Mappers
    Bind.lazySingleton((i) {
      return NotificationModelMapper(
        notificationParametersModelMapper: i.get(),
      );
    }),

    Bind.lazySingleton((i) {
      return NotificationParametersModelMapper();
    }),
  ];
}
