import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart'
    as clock;
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/developer_mode.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/gps_operation_mode.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/device_dto.dart';

clock.DeviceDto deviceDtoMock = clock.DeviceDto(
  imei: 'identifier',
  name: 'name',
  developerMode: clock.DeveloperModeEnum.active,
  gpsOperationMode: clock.GPSoperationModeEnum.active,
  dateTimeAutomatic: true,
  timeZoneAutomatic: true,
);

DeviceDto deviceMockDto = DeviceDto(
  imei: 'identifier',
  name: 'name',
  developerMode: DeveloperModeEnum.active,
  gpsOperationMode: GPSoperationModeEnum.active,
  dateTimeAutomatic: true,
  timeZoneAutomatic: true,
);
