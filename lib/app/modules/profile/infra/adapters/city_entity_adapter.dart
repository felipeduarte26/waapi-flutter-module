import '../../domain/entities/city_entity.dart';
import '../models/city_model.dart';
import 'state_entity_adapter.dart';

class CityEntityAdapter {
  CityEntity fromModel({
    required CityModel cityModel,
  }) {
    return CityEntity(
      name: cityModel.name,
      id: cityModel.id,
      state: cityModel.state != null
          ? StateEntityAdapter().fromModel(
              stateModel: cityModel.state!,
            )
          : null,
    );
  }
}
