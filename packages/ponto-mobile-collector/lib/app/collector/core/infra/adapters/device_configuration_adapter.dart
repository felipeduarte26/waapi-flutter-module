import 'dart:convert';

import '../../domain/entities/device_configuration.dart';

class DeviceConfigurationAdapter {
  static Map<String, dynamic> toMap(DeviceConfiguration entity) {
    return {
      'id': entity.id,
      'enable_nfc': entity.enableNfc,
      'enable_qrcode': entity.enableQrCode,
      'enable_facial': entity.enableFacial,
      'enable_user_and_password': entity.enableUserPassword,
      'allow_change_time': entity.allowChangeTime,
      'time_zone': entity.timeZone,
      'last_update': entity.lastUpdate.toIso8601String(),
      'last_sync': entity.lastSync.toIso8601String(),
    };
  }

  static DeviceConfiguration fromMap(Map<String, dynamic> map) {
    return DeviceConfiguration(
      id: map['id'] ?? '',
      enableNfc: map['enable_nfc'] ?? false,
      enableQrCode: map['enable_qrcode'] ?? false,
      enableFacial: map['enable_facial'] ?? false,
      enableUserPassword: map['enableUserPassword'] ?? false,
      allowChangeTime: map['allowChangeTime'] ?? false,
      timeZone: map['time_zone'] ?? '',
      lastUpdate: map['last_update'] != null
          ? DateTime.parse(map['last_update'])
          : DateTime.now(),
      lastSync: map['last_sync'] != null
          ? DateTime.parse(map['last_sync'])
          : DateTime.now(),
    );
  }

  static String toJSON(DeviceConfiguration entity) =>
      json.encode(toMap(entity));

  static DeviceConfiguration fromJSON(String source) =>
      fromMap(jsonDecode(source)['deviceConfiguration']);
}
