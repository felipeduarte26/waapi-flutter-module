import 'package:json_annotation/json_annotation.dart';

import '../enums/developer_mode.dart';
import '../enums/gps_operation_mode.dart';

part '../../../../../generated/app/collector/core/domain/input_model/device_dto.g.dart';

@JsonSerializable()
class DeviceDto {
  String? id;
  String? name;
  String? model;
  String? imei;
  DeveloperModeEnum? developerMode;
  GPSoperationModeEnum? gpsOperationMode;
  bool? dateTimeAutomatic;
  bool? timeZoneAutomatic;

  DeviceDto({
    this.id,
    this.name,
    this.imei,
    this.developerMode,
    this.gpsOperationMode,
    this.dateTimeAutomatic,
    this.timeZoneAutomatic,
  });

  factory DeviceDto.fromJson(Map<String, dynamic> json) =>
      _$DeviceDtoFromJson(json);

 Map<String, dynamic> toJson() => _$DeviceDtoToJson(this);
}
