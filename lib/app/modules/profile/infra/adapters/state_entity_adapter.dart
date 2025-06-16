import '../../domain/entities/state_entity.dart';
import '../models/state_model.dart';
import 'country_entity_adapter.dart';

class StateEntityAdapter {
  StateEntity fromModel({
    required StateModel stateModel,
  }) {
    return StateEntity(
      abbreviation: stateModel.abbreviation,
      name: stateModel.name,
      id: stateModel.id,
      country: stateModel.country != null
          ? CountryEntityAdapter().fromModel(
              countryModel: stateModel.country!,
            )
          : null,
    );
  }
}
