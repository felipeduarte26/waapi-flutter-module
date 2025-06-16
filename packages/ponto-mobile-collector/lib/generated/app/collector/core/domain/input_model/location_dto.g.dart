// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../../../app/collector/core/domain/input_model/location_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationDto _$LocationDtoFromJson(Map<String, dynamic> json) => LocationDto(
      id: json['id'] as String?,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      dateAndTime: DateTime.parse(json['dateAndTime'] as String),
    );

Map<String, dynamic> _$LocationDtoToJson(LocationDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'dateAndTime': instance.dateAndTime.toIso8601String(),
    };
