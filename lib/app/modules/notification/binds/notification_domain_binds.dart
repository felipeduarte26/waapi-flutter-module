import 'package:flutter_modular/flutter_modular.dart';

import '../domain/usecases/clear_all_user_notifications_usecase.dart';
import '../domain/usecases/clear_device_token_usecase.dart';
import '../domain/usecases/get_device_token_usecase.dart';
import '../domain/usecases/get_list_recent_notifications_usecase.dart';
import '../domain/usecases/get_native_permission_notification_usecase.dart';
import '../domain/usecases/get_number_unread_notifications_usecase.dart';
import '../domain/usecases/get_user_notification_settings_usecase.dart';
import '../domain/usecases/mark_notification_as_read_usecase.dart';
import '../domain/usecases/open_native_app_settings_usecase.dart';
import '../domain/usecases/register_device_token_usecase.dart';
import '../domain/usecases/save_native_permission_notification_usecase.dart';
import '../domain/usecases/toggle_user_notification_setting_usecase.dart';

class NotificationDomainBinds {
  static List<Bind<Object>> binds = [
    // UseCases
    Bind.lazySingleton<ClearDeviceTokenUsecase>(
      (i) {
        return ClearDeviceTokenUsecaseImpl(
          clearDeviceTokenRepository: i.get(),
        );
      },
      export: true,
    ),

    Bind.lazySingleton<GetNumberUnreadNotificationsUsecase>(
      (i) {
        return GetNumberUnreadNotificationsUsecaseImpl(
          getNumberUnreadNotificationsRepository: i.get(),
        );
      },
      export: true,
    ),

    Bind.lazySingleton<GetDeviceTokenUsecase>(
      (i) {
        return GetDeviceTokenUsecaseImpl(
          getDeviceTokenRepository: i.get(),
        );
      },
      export: true,
    ),

    Bind.lazySingleton<GetNativePermissionNotificationUsecase>(
      (i) {
        return GetNativePermissionNotificationUsecaseImpl(
          getNativePermissionNotificationRepository: i.get(),
        );
      },
      export: true,
    ),

    Bind.lazySingleton<RegisterDeviceTokenUsecase>(
      (i) {
        return RegisterDeviceTokenUsecaseImpl(
          registerDeviceTokenRepository: i.get(),
        );
      },
      export: true,
    ),

    Bind.lazySingleton<SaveNativePermissionNotificationUsecase>(
      (i) {
        return SaveNativePermissionNotificationUsecaseImpl(
          saveNativePermissionNotificationRepository: i.get(),
        );
      },
      export: true,
    ),

    Bind.lazySingleton<ClearAllUserNotificationsUsecase>((i) {
      return ClearAllUserNotificationsUsecaseImpl(
        clearAllUserNotificationsRepository: i.get(),
      );
    }),

    Bind.lazySingleton<GetUserNotificationSettingsUsecase>((i) {
      return GetUserNotificationSettingsUsecaseImpl(
        getUserNotificationSettingsRepository: i.get(),
      );
    }),

    Bind.lazySingleton<ToggleUserNotificationSettingUsecase>((i) {
      return ToggleUserNotificationSettingUsecaseImpl(
        toggleUserNotificationSettingRepository: i.get(),
      );
    }),

    Bind.lazySingleton<GetListRecentNotificationsUseCase>((i) {
      return GetListRecentNotificationsUseCaseImpl(
        getListRecentNotificationsRepository: i.get(),
      );
    }),

    Bind.lazySingleton<MarkNotificationAsReadUsecase>((i) {
      return MarkNotificationAsReadUsecaseImpl(
        notificationAsReadRepository: i.get(),
      );
    }),

    Bind.lazySingleton<OpenNativeAppSettingsUsecase>(
      (i) {
        return OpenNativeAppSettingsUsecaseImpl(
          openNativeAppSettingsRepository: i.get(),
        );
      },
      export: true,
    ),
  ];
}
