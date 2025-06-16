import '../../infra/models/state_model.dart';
import 'country_model_mapper.dart';

class StateModelMapper {
  final CountryModelMapper _countryModelMapper;

  const StateModelMapper({
    required CountryModelMapper countryModelMapper,
  }) : _countryModelMapper = countryModelMapper;

  StateModel fromMap({
    required Map<String, dynamic> map,
  }) {
    return StateModel(
      id: map['id'],
      name: map['name'],
      abbreviation: map['abbreviation'],
      country: map['country'] != null
          ? _countryModelMapper.fromMap(
              map: map['country'],
            )
          : null,
    );
  }
}
