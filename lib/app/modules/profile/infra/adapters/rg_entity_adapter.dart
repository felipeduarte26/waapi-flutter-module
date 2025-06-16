import '../../domain/entities/rg_entity.dart';
import '../models/rg_model.dart';

class RgEntityAdapter {
  RgEntity fromModel({
    required RgModel rgModel,
  }) {
    return RgEntity(
      id: rgModel.id,
      number: rgModel.number,
      issuer: rgModel.issuer,
      issuedDate: rgModel.issuedDate,
      issuingState: rgModel.issuingState,
    );
  }
}
