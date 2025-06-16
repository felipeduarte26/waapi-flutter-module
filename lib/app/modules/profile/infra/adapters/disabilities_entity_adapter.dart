import '../../domain/entities/disabilities_entity.dart';
import '../models/disabilities_model.dart';
import 'disability_entity_adapter.dart';

class DisabilitiesEntityAdapter {
  DisabilitiesEntity fromModel({
    required DisabilitiesModel disabilitiesModel,
  }) {
    return DisabilitiesEntity(
      id: disabilitiesModel.id,
      isRehabilitated: disabilitiesModel.isRehabilitated,
      rehabilitation: disabilitiesModel.rehabilitation,
      disability: DisabilityEntityAdapter().fromModel(disabilityModel: disabilitiesModel.disability!),
    );
  }
}
