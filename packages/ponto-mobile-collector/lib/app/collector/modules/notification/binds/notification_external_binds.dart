import 'package:flutter_modular/flutter_modular.dart';

import '../external/datasources/confirm_read_push_message_datasource_impl.dart';
import '../external/datasources/get_number_unread_notifications_datasource_impl.dart';
import '../external/datasources/push_notifications_datasource_impl.dart';
import '../infra/datasources/confirm_read_push_message_datasource.dart';
import '../infra/datasources/get_number_unread_notifications_datasource.dart';
import '../infra/datasources/push_notifications_datasource.dart';

class NotificationExternalBinds {
  static List<Bind<Object>> binds = [
    // Datasources
    Bind.lazySingleton<GetPushNotificationsDatasource>(
      (i) {
        return GetPushNotificationsDatasourceImpl(
          httpClient: i.get(),
          environmentService: i.get(),
        );
      },
      export: true,
    ),

    Bind.lazySingleton<GetNumberUnreadNotificationsDatasource>(
      (i) {
        return GetNumberUnreadNotificationsDatasourceImpl(
          httpClient: i.get(),
          environmentService: i.get(),
        );
      },
      export: true,
    ),

    Bind.lazySingleton<ConfirmReadPushMessageDataSource>(
      (i) {
        return ConfirmReadPushMessageDataSourceImpl(
          httpClient: i.get(),
          environmentService: i.get(),
        );
      },
      export: true,
    ),
  ];
}
