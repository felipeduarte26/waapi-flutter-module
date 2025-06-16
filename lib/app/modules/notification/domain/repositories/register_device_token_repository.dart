import '../types/notification_domain_types.dart';

abstract class RegisterDeviceTokenRepository {
  RegisterDeviceTokenCallback call({
    required String token,
  });
}
