import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart' as clock;
import 'package:mobile_authentication/mobile_authentication_service.dart'
    as auth;

import '../../domain/entities/device.dart';
import '../../domain/enums/developer_mode.dart';
import '../../domain/enums/gps_operation_mode.dart';
import '../../domain/enums/status_device.dart';
import '../../domain/input_model/device_dto.dart';
import '../../domain/input_model/device_info_dto.dart';
import '../drift/collector_database.dart';

class DeviceMapper {
  Device fromTable(DeviceTableData table) {
    return Device(
      id: table.id,
      identifier: table.imei,
      name: table.name,
      model: table.model,
      status: StatusDevice.build(table.status),
    );
  }

  DeviceTableData toTable(Device entity) {
    var deviceTableData = DeviceTableData(
      id: entity.id!,
      imei: entity.identifier,
      status: entity.status!.value, // TO DO: validar o nullable
      model: entity.model,
      name: entity.name,
    );

    return deviceTableData;
  }

  Device fromMap(Map<String, dynamic> map) {
    return Device(
      id: map['id'],
      identifier: map['imei'],
      name: map['name'],
      model: map['model'],
      status: StatusDevice.build(map['status']),
    );
  }

  Map<String, dynamic> toMap(Device entity) {
    return {
      'id': entity.id,
      'imei': entity.identifier,
      'name': entity.name,
      'model': entity.model,
      'status': entity.status!.value,
    };
  }

  static clock.DeviceDto? fromCollectorDtoToClock(DeviceDto? dto) {
    if (dto == null) {
      return null;
    }
    return clock.DeviceDto(
      dateTimeAutomatic: dto.dateTimeAutomatic,
      developerMode:
          clock.DeveloperModeEnum.build(dto.developerMode!.value),
      gpsOperationMode:
          clock.GPSoperationModeEnum.build(dto.gpsOperationMode!.value),
      id: dto.id,
      imei: dto.imei,
      name: dto.name,
      timeZoneAutomatic: dto.timeZoneAutomatic,
    );
  }

  static Device? fromClockToDeviceCollector(clock.DeviceDto? dto) {
    if (dto == null) {
      return null;
    }
    return Device(
      dateTimeAutomatic: dto.dateTimeAutomatic,
      developerMode:
          DeveloperModeEnum.build(dto.developerMode!.value),
      gpsOperationMode:
          GPSoperationModeEnum.build(dto.gpsOperationMode!.value),
      id: dto.id,
      identifier: dto.imei!,
      name: dto.name,
      timeZoneAutomatic: dto.timeZoneAutomatic,
    );
  }

  static Device? fromDtoToEntityCollector(DeviceDto? dto) {
    if (dto == null) {
      return null;
    }
    return Device(
      dateTimeAutomatic: dto.dateTimeAutomatic,
      developerMode:
          DeveloperModeEnum.build(dto.developerMode!.value),
      gpsOperationMode:
          GPSoperationModeEnum.build(dto.gpsOperationMode!.value),
      id: dto.id,
      identifier: dto.imei!,
      name: dto.name,
      timeZoneAutomatic: dto.timeZoneAutomatic,
    );
  }

  static DeviceDto? fromEntityToDtoCollector(Device? device) {
    if (device == null) {
      return null;
    }
    return DeviceDto(
      dateTimeAutomatic: device.dateTimeAutomatic,
      developerMode: DeveloperModeEnum.build(device.developerMode!.value), // TO DO: procurar lugares com .build pra deixar value
      gpsOperationMode: GPSoperationModeEnum.build(device.gpsOperationMode!.value),
      id: device.id,
      imei: device.identifier,
      name: device.name,
      timeZoneAutomatic: device.timeZoneAutomatic,
    );
  }

  static DeviceDto fromClockToCollectorDto(clock.DeviceDto? device) {
    if (device == null) {
      return DeviceDto();
    }
    return DeviceDto(
      dateTimeAutomatic: device.dateTimeAutomatic,
      developerMode: DeveloperModeEnum.build(device.developerMode!.value),
      gpsOperationMode: GPSoperationModeEnum.build(device.gpsOperationMode!.value),
      id: device.id,
      imei: device.imei,
      name: device.name,
      timeZoneAutomatic: device.timeZoneAutomatic,
    );
  }

  static auth.DeviceInfo? fromCollectorDtoToAuth(
      DeviceInfo? deviceInfo,) {
    if (deviceInfo == null) {
      return null;
    }
    auth.StatusDevice statusAuth = auth.StatusDevice.build(deviceInfo.status != null ? deviceInfo.status!.value : 'PENDING'); 
    
    return auth.DeviceInfo(identifier: deviceInfo.identifier ,
    model: deviceInfo.model,
    name: deviceInfo.name,
    id: deviceInfo.id,
    status: statusAuth,);
  }

  static clock.DeviceDto? fromEntityToClock(Device? device) {
    if (device == null) {
      return null;
    }
    return clock.DeviceDto(
      dateTimeAutomatic: device.dateTimeAutomatic,
      developerMode: device.developerMode != null ? clock.DeveloperModeEnum.build(device.developerMode!.value): null,
      gpsOperationMode: device.gpsOperationMode != null ? clock.GPSoperationModeEnum.build(device.gpsOperationMode!.value): null,
      id: device.id,
      imei: device.identifier,
      name: device.name,
      timeZoneAutomatic: device.timeZoneAutomatic,
    );
  }
}
