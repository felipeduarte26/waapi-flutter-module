import '../../domain/entities/administrative_region_entity.dart';
import '../models/administrative_region_model.dart';
import 'city_entity_adapter.dart';

class AdministrativeRegionEntityAdapter {
  AdministrativeRegionEntity fromModel({
    required AdministrativeRegionModel administrativeRegionModel,
  }) {
    return AdministrativeRegionEntity(
      id: administrativeRegionModel.id,
      name: administrativeRegionModel.name,
      city: administrativeRegionModel.city != null
          ? CityEntityAdapter().fromModel(
              cityModel: administrativeRegionModel.city!,
            )
          : null,
    );
  }
}
