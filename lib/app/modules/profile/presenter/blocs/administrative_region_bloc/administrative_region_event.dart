import 'package:equatable/equatable.dart';

import '../../../domain/entities/administrative_region_entity.dart';

abstract class AdministrativeRegionEvent extends Equatable {
  @override
  List<Object?> get props {
    return [];
  }
}

class GetAdministrativeRegionProfileEvent extends AdministrativeRegionEvent {
  final String cityId;

  GetAdministrativeRegionProfileEvent({
    required this.cityId,
  });

  @override
  List<Object?> get props {
    return [
      ...super.props,
    ];
  }
}

class SelectAdministrativeRegionFromEntityToProfileEvent extends AdministrativeRegionEvent {
  final AdministrativeRegionEntity administrativeRegionEntity;

  SelectAdministrativeRegionFromEntityToProfileEvent({
    required this.administrativeRegionEntity,
  });

  @override
  List<Object?> get props {
    return [
      ...super.props,
      administrativeRegionEntity,
    ];
  }
}

class UnselectAdministrativeRegionFromEntityToProfileEvent extends AdministrativeRegionEvent {
  final AdministrativeRegionEntity? administrativeRegionEntity;

  UnselectAdministrativeRegionFromEntityToProfileEvent({
    required this.administrativeRegionEntity,
  });

  @override
  List<Object?> get props {
    return [
      ...super.props,
      administrativeRegionEntity,
    ];
  }
}

class ClearAdministrativeRegionProfileEvent extends AdministrativeRegionEvent {}
