import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart'
    as clock;
import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_authentication/mobile_authentication_service.dart'
    as auth;

part '../../../../../generated/app/collector/core/domain/input_model/location_dto.g.dart';

@JsonSerializable()
class LocationDto {
  final String? id;
  final double latitude;
  final double longitude;
  final DateTime dateAndTime;

  LocationDto({
    this.id,
    required this.latitude,
    required this.longitude,
    required this.dateAndTime,
  });

  factory LocationDto.fromJson(Map<String, dynamic> json) =>
      _$LocationDtoFromJson(json);

  Map<String, dynamic> toJson() => _$LocationDtoToJson(this);

  static LocationDto? fromClockToCollectorDto(
    clock.LocationDTO? geolocation,
  ) {
    if (geolocation == null) {
      return null;
    }
    return LocationDto(
      latitude: geolocation.latitude,
      longitude: geolocation.longitude,
      dateAndTime: geolocation.dateAndTime,
    );
  }

  static LocationDto? fromAuthToCollectorDto(
    auth.LocationDTO? geolocation,
  ) {
    if (geolocation == null) {
      return null;
    }
    return LocationDto(
      latitude: geolocation.latitude,
      longitude: geolocation.longitude,
      dateAndTime: geolocation.dateAndTime,
    );
  }

  static clock.LocationDTO? fromCollectorDtoToClock(
    LocationDto? geolocation,
  ) {
    if (geolocation == null) {
      return null;
    }
    return clock.LocationDTO(
      latitude: geolocation.latitude,
      longitude: geolocation.longitude,
      dateAndTime: geolocation.dateAndTime,
    );
  }

  static clock.LocationDTO? fromEntityToClock(LocationDto? location) {
    if (location == null) {
      return null;
    }
    return clock.LocationDTO(
      latitude: location.latitude,
      longitude: location.longitude,
      dateAndTime: location.dateAndTime,
    );
  }
}
