import 'package:firebase_messaging/firebase_messaging.dart';

import '../../enums/notification_permission_status_enum.dart';
import '../../infra/drivers/get_native_permission_notification_driver.dart';

class GetNativePermissionNotificationDriverImpl implements GetNativePermissionNotificationDriver {
  final FirebaseMessaging _firebaseMessaging;

  const GetNativePermissionNotificationDriverImpl({
    required FirebaseMessaging firebaseMessaging,
  }) : _firebaseMessaging = firebaseMessaging;

  @override
  Future<NotificationPermissionStatusEnum> call() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    return [
      NotificationPermissionStatusEnum.authorized,
      NotificationPermissionStatusEnum.denied,
      NotificationPermissionStatusEnum.denied,
      NotificationPermissionStatusEnum.authorized,
    ][settings.authorizationStatus.index];
  }
}
