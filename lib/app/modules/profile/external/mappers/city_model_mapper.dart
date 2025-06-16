import '../../infra/models/city_model.dart';
import 'state_model_mapper.dart';

class CityModelMapper {
  final StateModelMapper _stateModelMapper;

  const CityModelMapper({
    required StateModelMapper stateModelMapper,
  }) : _stateModelMapper = stateModelMapper;

  CityModel fromMap({
    required Map<String, dynamic> map,
  }) {
    return CityModel(
      id: map['id'],
      name: map['name'],
      state: map['state'] != null
          ? _stateModelMapper.fromMap(
              map: map['state'],
            )
          : null,
    );
  }
}
