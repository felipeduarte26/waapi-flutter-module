import 'package:json_annotation/json_annotation.dart';

import '../enums/status_device.dart';

part '../../../../../generated/app/collector/core/domain/input_model/device_info_dto.g.dart';

@JsonSerializable()
class DeviceInfo {
  final String? id;
  final String identifier;
  final String name;
  final String model;
  final StatusDevice? status;

  DeviceInfo({
    this.id,
    this.status,
    required this.identifier,
    required this.name,
    required this.model,
  });

  factory DeviceInfo.fromJson(Map<String, dynamic> json) =>
      _$DeviceInfoFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceInfoToJson(this);
}
