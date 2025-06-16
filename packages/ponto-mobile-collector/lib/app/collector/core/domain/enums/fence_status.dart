import 'package:json_annotation/json_annotation.dart';

import '../../exception/clocking_event_exception.dart';

enum FenceStatusEnum {
  @JsonValue('IN')
  into('IN', 'In'),

  @JsonValue('OUT')
  out('OUT', 'Out'),

  @JsonValue('NO_FENCE')
  noFence('NO_FENCE', 'No Fence'),

  @JsonValue('NO_LOCATION')
  noLocation('NO_LOCATION',
      'Não foi possível obter a localização no momento da realização da marcação',),

  @JsonValue('NO_LOCATION_PERMISSION')
  noLocationPermission('NO_LOCATION_PERMISSION',
      'Localização do celular desabilitada ou app sem acesso',);

  final String id;
  final String value;

  const FenceStatusEnum(this.id, this.value);

  static FenceStatusEnum build(String id) {
    if (id == FenceStatusEnum.into.id) {
      return FenceStatusEnum.into;
    }

    if (id == FenceStatusEnum.out.id) {
      return FenceStatusEnum.out;
    }

    if (id == FenceStatusEnum.noFence.id) {
      return FenceStatusEnum.noFence;
    }

    if (id == FenceStatusEnum.noLocation.id) {
      return FenceStatusEnum.noLocation;
    }

    if (id == FenceStatusEnum.noLocationPermission.id) {
      return FenceStatusEnum.noLocationPermission;
    }

    throw ClockingEventException('FenceStatusEnum not found.');
  }
}
