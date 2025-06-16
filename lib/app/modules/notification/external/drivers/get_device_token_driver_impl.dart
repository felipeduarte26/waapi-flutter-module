import 'package:firebase_messaging/firebase_messaging.dart';

import '../../infra/drivers/get_device_token_driver.dart';

class GetDeviceTokenDriverImpl implements GetDeviceTokenDriver {
  final FirebaseMessaging _firebaseMessaging;

  const GetDeviceTokenDriverImpl({
    required FirebaseMessaging firebaseMessaging,
  }) : _firebaseMessaging = firebaseMessaging;

  @override
  Future<String?> call() {
    return _firebaseMessaging.getToken();
  }
}
