import 'package:equatable/equatable.dart';

import 'city_entity.dart';


class AdministrativeRegionEntity extends Equatable {
  final String? id;
  final String? name;
  final CityEntity? city;

  const AdministrativeRegionEntity({
    this.id,
    this.name,
    this.city,
  });

  @override
  List<Object?> get props {
    return [
      id,
      name,
      city,
    ];
  }
}
