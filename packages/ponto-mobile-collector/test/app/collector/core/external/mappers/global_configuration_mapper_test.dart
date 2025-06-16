import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/global_configuration_entity.dart';
import 'package:ponto_mobile_collector/app/collector/core/external/drift/collector_database.dart';
import 'package:ponto_mobile_collector/app/collector/core/external/mappers/global_configuration_mapper.dart';

void main() {
  late GlobalConfigurationEntityMapper globalConfigurationMapper;

  setUp(() {
    globalConfigurationMapper = GlobalConfigurationEntityMapper();
  });

  group('GlobalConfigurationMapper', () {
    test('should return GlobalConfigurationEntity from map', () {
      // Arrange
      final map = {
        'id': '1',
        'gps': true,
        'online': true,
        'timeout': '300',
        'operationMode': 'mode',
        'employee': 'employee',
        'nfcMode': true,
        'allowChangeTime': true,
        'timezone': 'timezone',
        'deviceAuthModeSingleMode': 'true',
        'deviceAuthModeMultiMode': 'true',
        'deviceAuthModeDriverMode': 'true',
        'allowDrivingTime': true,
        'overnight': true,
        'controlOvernight': true,
        'allowGpoOnApp': true,
        'exportNotChecked': true,
        'insightOutOfBound': 'true',
        'takePhotoSingle': true,
        'takePhotoMulti': true,
        'takePhotoDriver': true,
        'takePhotoQrcode': true,
        'openExternalBrowser': true,
        'clockingEventUses': {
          'clockingEventUses': ['event1', 'event2'],
        },
        'allowUse': true,
        'externalControlTimezone': true,
        'faceRecognition': true,
      };

      // Act
      final result = globalConfigurationMapper.fromMap(map: map);

      // Assert
      expect(result, isA<GlobalConfigurationEntity>());
      expect(result.id, map['id']);
      expect(result.gps, map['gps']);
      expect(result.online, map['online']);
      expect(result.timeout, map['timeout']);
      expect(result.operationMode, map['operationMode']);
      expect(result.nfcMode, map['nfcMode']);
      expect(result.allowChangeTime, map['allowChangeTime']);
      expect(result.timezone, map['timezone']);
      expect(result.deviceAuthModeSingleMode, map['deviceAuthModeSingleMode']);
      expect(result.deviceAuthModeMultiMode, map['deviceAuthModeMultiMode']);
      expect(result.deviceAuthModeDriverMode, map['deviceAuthModeDriverMode']);
      expect(result.allowDrivingTime, map['allowDrivingTime']);
      expect(result.overnight, map['overnight']);
      expect(result.controlOvernight, map['controlOvernight']);
      expect(result.allowGpoOnApp, map['allowGpoOnApp']);
      expect(result.exportNotChecked, map['exportNotChecked']);
      expect(result.insightOutOfBound, map['insightOutOfBound']);
      expect(result.takePhotoSingle, map['takePhotoSingle']);
      expect(result.takePhotoMulti, map['takePhotoMulti']);
      expect(result.takePhotoDriver, map['takePhotoDriver']);
      expect(result.takePhotoQrcode, map['takePhotoQrcode']);
      expect(result.openExternalBrowser, map['openExternalBrowser']);
      expect(
        result.clockingEventUses,
        ['{"clockingEventUses":["event1","event2"]}'],
      );
      expect(result.allowUse, map['allowUse']);
      expect(result.externalControlTimezone, map['externalControlTimezone']);
      expect(result.faceRecognition, map['faceRecognition']);
    });

    test('should return list of GlobalConfigurationEntity from list of maps',
        () {
      // Arrange
      final List<Map<String, dynamic>> list = [
        {
          'id': '1',
          'gps': true,
          'online': true,
          'timeout': '300',
          'operationMode': 'mode',
          'employee': 'employee',
          'nfcMode': true,
          'allowChangeTime': true,
          'timezone': 'timezone',
          'deviceAuthModeSingleMode': 'true',
          'deviceAuthModeMultiMode': 'true',
          'deviceAuthModeDriverMode': 'true',
          'allowDrivingTime': true,
          'overnight': true,
          'controlOvernight': true,
          'allowGpoOnApp': true,
          'exportNotChecked': true,
          'insightOutOfBound': 'true',
          'takePhotoSingle': true,
          'takePhotoMulti': true,
          'takePhotoDriver': true,
          'takePhotoQrcode': true,
          'openExternalBrowser': true,
          'clockingEventUses': ['event1', 'event2'],
          'allowUse': true,
          'externalControlTimezone': true,
          'faceRecognition': true,
        },
        // Add more maps for more thorough testing
      ];

      // Act
      final result = globalConfigurationMapper.fromList(list: list);

      // Assert
      expect(result, isA<List<GlobalConfigurationEntity>>());
      expect(result.length, list.length);
      for (var i = 0; i < result.length; i++) {
        expect(result[i].id, list[i]['id']);
        expect(result[i].gps, list[i]['gps']);
        expect(result[i].online, list[i]['online']);
        expect(result[i].timeout, list[i]['timeout']);
        expect(result[i].operationMode, list[i]['operationMode']);
        expect(result[i].nfcMode, list[i]['nfcMode']);
        expect(result[i].allowChangeTime, list[i]['allowChangeTime']);
        expect(result[i].timezone, list[i]['timezone']);
        expect(
          result[i].deviceAuthModeSingleMode,
          list[i]['deviceAuthModeSingleMode'],
        );
        expect(
          result[i].deviceAuthModeMultiMode,
          list[i]['deviceAuthModeMultiMode'],
        );
        expect(
          result[i].deviceAuthModeDriverMode,
          list[i]['deviceAuthModeDriverMode'],
        );
        expect(result[i].allowDrivingTime, list[i]['allowDrivingTime']);
        expect(result[i].overnight, list[i]['overnight']);
        expect(result[i].controlOvernight, list[i]['controlOvernight']);
        expect(result[i].allowGpoOnApp, list[i]['allowGpoOnApp']);
        expect(result[i].exportNotChecked, list[i]['exportNotChecked']);
        expect(result[i].insightOutOfBound, list[i]['insightOutOfBound']);
        expect(result[i].takePhotoSingle, list[i]['takePhotoSingle']);
        expect(result[i].takePhotoMulti, list[i]['takePhotoMulti']);
        expect(result[i].takePhotoDriver, list[i]['takePhotoDriver']);
        expect(result[i].takePhotoQrcode, list[i]['takePhotoQrcode']);
        expect(result[i].openExternalBrowser, list[i]['openExternalBrowser']);
        expect(result[i].clockingEventUses, ['["event1","event2"]']);
        expect(result[i].allowUse, list[i]['allowUse']);
        expect(
          result[i].externalControlTimezone,
          list[i]['externalControlTimezone'],
        );
        expect(result[i].faceRecognition, list[i]['faceRecognition']);
      }
    });

    test(
        'should return GlobalConfigurationTableData from GlobalConfigurationEntity',
        () {
      // Arrange
      const GlobalConfigurationEntity entity = GlobalConfigurationEntity(
        id: '1',
        gps: true,
        online: true,
        timeout: '300',
        operationMode: 'mode',
        nfcMode: true,
        allowChangeTime: true,
        timezone: 'timezone',
        deviceAuthModeSingleMode: 'true',
        deviceAuthModeMultiMode: 'true',
        deviceAuthModeDriverMode: 'true',
        allowDrivingTime: true,
        overnight: true,
        controlOvernight: true,
        allowGpoOnApp: true,
        exportNotChecked: true,
        insightOutOfBound: 'true',
        takePhotoSingle: true,
        takePhotoMulti: true,
        takePhotoDriver: true,
        takePhotoQrcode: true,
        openExternalBrowser: true,
        clockingEventUses: ['event1', 'event2'],
        allowUse: true,
        externalControlTimezone: true,
        faceRecognition: true,
      );

      // Act
      final result = globalConfigurationMapper.toTableData(
        globalConfigurationEntity: entity,
      );

      // Assert
      expect(result, isA<GlobalConfigurationTableData>());
      expect(result.id, entity.id);
      expect(result.gps, entity.gps);
      expect(result.online, entity.online);
      expect(result.timeout, entity.timeout);
      expect(result.operationMode, entity.operationMode);
      expect(result.nfcMode, entity.nfcMode);
      expect(result.allowChangeTime, entity.allowChangeTime);
      expect(result.timezone, entity.timezone);
      expect(result.deviceAuthModeSingleMode, entity.deviceAuthModeSingleMode);
      expect(result.deviceAuthModeMultiMode, entity.deviceAuthModeMultiMode);
      expect(result.deviceAuthModeDriverMode, entity.deviceAuthModeDriverMode);
      expect(result.allowDrivingTime, entity.allowDrivingTime);
      expect(result.overnight, entity.overnight);
      expect(result.controlOvernight, entity.controlOvernight);
      expect(result.allowGpoOnApp, entity.allowGpoOnApp);
      expect(result.exportNotChecked, entity.exportNotChecked);
      expect(result.insightOutOfBound, entity.insightOutOfBound);
      expect(result.takePhotoSingle, entity.takePhotoSingle);
      expect(result.takePhotoMulti, entity.takePhotoMulti);
      expect(result.takePhotoDriver, entity.takePhotoDriver);
      expect(result.takePhotoQrcode, entity.takePhotoQrcode);
      expect(result.openExternalBrowser, entity.openExternalBrowser);
      expect(result.clockingEventUses, entity.clockingEventUses?.join(','));
      expect(result.allowUse, entity.allowUse);
      expect(result.externalControlTimezone, entity.externalControlTimezone);
      expect(result.faceRecognition, entity.faceRecognition);
    });

    test(
        'should return GlobalConfigurationEntity from GlobalConfigurationTableData',
        () {
      // Arrange
      const GlobalConfigurationTableData tableData =
          GlobalConfigurationTableData(
        id: '1',
        gps: true,
        online: true,
        timeout: '300',
        operationMode: 'mode',
        nfcMode: true,
        allowChangeTime: true,
        timezone: 'timezone',
        deviceAuthModeSingleMode: 'true',
        deviceAuthModeMultiMode: 'true',
        deviceAuthModeDriverMode: 'true',
        allowDrivingTime: true,
        overnight: true,
        controlOvernight: true,
        allowGpoOnApp: true,
        exportNotChecked: true,
        insightOutOfBound: 'true',
        takePhotoSingle: true,
        takePhotoMulti: true,
        takePhotoDriver: true,
        takePhotoQrcode: true,
        openExternalBrowser: true,
        clockingEventUses: 'event1,event2',
        allowUse: true,
        externalControlTimezone: true,
        faceRecognition: true,
      );

      // Act
      final result = globalConfigurationMapper.fromTableData(tableData);

      // Assert
      expect(result, isA<GlobalConfigurationEntity>());
      expect(result.id, tableData.id);
      expect(result.gps, tableData.gps);
      expect(result.online, tableData.online);
      expect(result.timeout, tableData.timeout);
      expect(result.operationMode, tableData.operationMode);
      expect(result.nfcMode, tableData.nfcMode);
      expect(result.allowChangeTime, tableData.allowChangeTime);
      expect(result.timezone, tableData.timezone);
      expect(
        result.deviceAuthModeSingleMode,
        tableData.deviceAuthModeSingleMode,
      );
      expect(result.deviceAuthModeMultiMode, tableData.deviceAuthModeMultiMode);
      expect(
        result.deviceAuthModeDriverMode,
        tableData.deviceAuthModeDriverMode,
      );
      expect(result.allowDrivingTime, tableData.allowDrivingTime);
      expect(result.overnight, tableData.overnight);
      expect(result.controlOvernight, tableData.controlOvernight);
      expect(result.allowGpoOnApp, tableData.allowGpoOnApp);
      expect(result.exportNotChecked, tableData.exportNotChecked);
      expect(result.insightOutOfBound, tableData.insightOutOfBound);
      expect(result.takePhotoSingle, tableData.takePhotoSingle);
      expect(result.takePhotoMulti, tableData.takePhotoMulti);
      expect(result.takePhotoDriver, tableData.takePhotoDriver);
      expect(result.takePhotoQrcode, tableData.takePhotoQrcode);
      expect(result.openExternalBrowser, tableData.openExternalBrowser);
      expect(result.clockingEventUses, tableData.clockingEventUses?.split(','));
      expect(result.allowUse, tableData.allowUse);
      expect(result.externalControlTimezone, tableData.externalControlTimezone);
      expect(result.faceRecognition, tableData.faceRecognition);
    });
  });
}
