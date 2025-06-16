import 'package:json_annotation/json_annotation.dart';

import '../enums/location_status.dart';

part '../../../../../generated/app/collector/core/domain/input_model/location_import_dto.g.dart';

@JsonSerializable()
class LocationImportDto{
  LocationStatusEnum? locationStatus;
  double latitude;
  double longitude;
  DateTime createAt;

  LocationImportDto({
    this.locationStatus,
    required this.latitude,
    required this.longitude,
    required this.createAt,
  });

  factory LocationImportDto.fromJson(Map<String, dynamic> json) =>
      _$LocationImportDtoFromJson(json);
  Map<String, dynamic> toJson() => _$LocationImportDtoToJson(this);
}
