import '../../domain/entities/ctps_entity.dart';
import '../../infra/models/ctps_model.dart';

class CtpsEntityAdapter {
  CtpsEntity fromModel({
    required CtpsModel ctpsModel,
  }) {
    return CtpsEntity(
      id: ctpsModel.id,
      issuedDate: ctpsModel.issuedDate,
      number: ctpsModel.number,
      serie: ctpsModel.serie,
      serieDigit: ctpsModel.serieDigit,
      state: ctpsModel.state,
    );
  }
}
