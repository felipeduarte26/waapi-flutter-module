import '../../domain/entities/ric_entity.dart';
import '../models/ric_model.dart';

class RicEntityAdapter {
  RicEntity fromModel({
    required RicModel ricModel,
  }) {
    return RicEntity(
      id: ricModel.id,
      number: ricModel.number,
      issuer: ricModel.issuer,
      issuedDate: ricModel.issuedDate,
      issuingCityId: ricModel.issuingCityId,
      issuingCityName: ricModel.issuingCityName,
    );
  }
}
