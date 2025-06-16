import 'package:json_annotation/json_annotation.dart';

import '../../exception/clocking_event_exception.dart';

enum LocationStatusEnum {
  @JsonValue('NO_LOCATION')
  noLocation('NO_LOCATION',
      'Não foi possível obter a localização no momento da realização da marcação',),

  @JsonValue('NO_LOCATION_PERMISSION')
  noLocationPermission('NO_LOCATION_PERMISSION',
      'Localização do celular desabilitada ou app sem acesso',),

  @JsonValue('LOCATION')
  location(
      'LOCATION', 'Localização do gps no momento da realização da marcação',);

  final String id;
  final String value;
  const LocationStatusEnum(this.id, this.value);

  static LocationStatusEnum build(String id) {
    if (id == LocationStatusEnum.noLocation.id) {
      return LocationStatusEnum.noLocation;
    }

    if (id == LocationStatusEnum.noLocationPermission.id) {
      return LocationStatusEnum.noLocationPermission;
    }

    if (id == LocationStatusEnum.location.id) {
      return LocationStatusEnum.location;
    }

    throw ClockingEventException('LocationStatusEnum not found.');
  }
}
