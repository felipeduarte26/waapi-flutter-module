import 'dart:convert';

import '../../infra/models/administrative_region_model.dart';
import 'city_model_mapper.dart';

class AdministrativeRegionModelMapper {
  final CityModelMapper _cityModelMapper;

  const AdministrativeRegionModelMapper({
    required CityModelMapper cityModelMapper,
  }) : _cityModelMapper = cityModelMapper;

  AdministrativeRegionModel fromMap({
    required Map<String, dynamic> map,
  }) {
    return AdministrativeRegionModel(
      id: map['id'],
      name: map['name'],
      city: map['cityDTO'] != null
          ? _cityModelMapper.fromMap(
              map: map['cityDTO'],
            )
          : null,
    );
  }

  List<AdministrativeRegionModel> fromJson({
    required String administrativeRegionJson,
  }) {
    if (administrativeRegionJson.isEmpty) {
      return [
        const AdministrativeRegionModel(),
      ];
    }

    final administrativeRegions = jsonDecode(administrativeRegionJson);

    return (administrativeRegions as List).map(
      (administrativeRegionMap) {
        return fromMap(
          map: administrativeRegionMap,
        );
      },
    ).toList();
  }
}
