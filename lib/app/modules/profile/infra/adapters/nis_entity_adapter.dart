import '../../domain/entities/nis_entity.dart';
import '../models/nis_model.dart';

class NisEntityAdapter {
  NisEntity fromModel({
    required NisModel nisModel,
  }) {
    return NisEntity(
      id: nisModel.id,
      number: nisModel.number,
      registrationDate: nisModel.registrationDate,
    );
  }
}
