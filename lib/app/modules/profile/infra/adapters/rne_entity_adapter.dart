import '../../domain/entities/rne_entity.dart';
import '../models/rne_model.dart';

class RneEntityAdapter {
  RneEntity fromModel({
    required RneModel rneModel,
  }) {
    return RneEntity(
      number: rneModel.number,
      issuer: rneModel.issuer,
      issuedDate: rneModel.issuedDate,
    );
  }
}
