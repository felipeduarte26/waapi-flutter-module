// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../../../app/collector/core/domain/input_model/location_import_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationImportDto _$LocationImportDtoFromJson(Map<String, dynamic> json) =>
    LocationImportDto(
      locationStatus: $enumDecodeNullable(
          _$LocationStatusEnumEnumMap, json['locationStatus']),
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      createAt: DateTime.parse(json['createAt'] as String),
    );

Map<String, dynamic> _$LocationImportDtoToJson(LocationImportDto instance) =>
    <String, dynamic>{
      'locationStatus': _$LocationStatusEnumEnumMap[instance.locationStatus],
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'createAt': instance.createAt.toIso8601String(),
    };

const _$LocationStatusEnumEnumMap = {
  LocationStatusEnum.noLocation: 'NO_LOCATION',
  LocationStatusEnum.noLocationPermission: 'NO_LOCATION_PERMISSION',
  LocationStatusEnum.location: 'LOCATION',
};
