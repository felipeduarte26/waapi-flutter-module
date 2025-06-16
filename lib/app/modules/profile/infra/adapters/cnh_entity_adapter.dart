import '../../domain/entities/cnh_entity.dart';
import '../models/cnh_model.dart';

class CnhEntityAdapter {
  CnhEntity fromModel({
    required CnhModel cnhModel,
  }) {
    return CnhEntity(
      category: cnhModel.category,
      number: cnhModel.number,
      expiryDate: cnhModel.expiryDate,
      firstIssuedDate: cnhModel.firstIssuedDate,
      issuedDate: cnhModel.issuedDate,
      issuer: cnhModel.issuer,
      issuerState: cnhModel.issuerState,
    );
  }
}
