import 'package:equatable/equatable.dart';

import 'city_model.dart';

class AdministrativeRegionModel extends Equatable {
  final String? id;
  final String? name;
  final CityModel? city;

  const AdministrativeRegionModel({
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
