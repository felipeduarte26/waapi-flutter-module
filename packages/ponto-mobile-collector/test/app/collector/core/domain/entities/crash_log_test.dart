import 'package:ponto_mobile_collector/app/collector/core/domain/entities/crash_log.dart';
import 'package:test/test.dart';

void main() {
  group('CrashLog', () {
    test('fromJson should return a valid CrashLog object', () {
      // JSON de exemplo
      final json = {
        'id': '74559473-91b4-46d5-9b5a-53db70a3ae45',
        'dateAndTime': '2023-10-01T12:34:56',
        'deviceId': 'device123',
        'userPlatform': 'Android',
        'log': 'Crash log details',
        'employeeExternalId': 'emp-ext-id-1',
        'employeeId': 'emp-id-1',
      };

      final crashLog = CrashLog.fromJson(json);

      expect(crashLog.createdAt, '2023-10-01T12:34:56');
      expect(crashLog.deviceId, 'device123');
      expect(crashLog.userPlatform, 'Android');
      expect(crashLog.log, 'Crash log details');
      expect(crashLog.employeeExternalId, 'emp-ext-id-1');
      expect(crashLog.employeeId, 'emp-id-1');
    });

    test('toJson should return a valid JSON map', () {
      final crashLog = CrashLog(
        id: '74559473-91b4-46d5-9b5a-53db70a3ae45',
        createdAt: '2023-10-01T12:34:56',
        deviceId: 'device123',
        userPlatform: 'Android',
        log: 'Crash log details',
        employeeExternalId: 'emp-ext-id-1',
        employeeId: 'emp-id-1',
      );

      final json = crashLog.toJson();

      expect(json, {
        'id': '74559473-91b4-46d5-9b5a-53db70a3ae45',
        'dateAndTime': '2023-10-01T12:34:56',
        'deviceId': 'device123',
        'userPlatform': 'Android',
        'log': 'Crash log details',
        'employeeExternalId': 'emp-ext-id-1',
        'employeeId': 'emp-id-1',
      });
    });
  });
}
