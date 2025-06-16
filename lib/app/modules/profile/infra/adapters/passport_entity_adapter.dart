import '../../domain/entities/passport_entity.dart';
import '../models/passport_model.dart';

class PassportEntityAdapter {
  PassportEntity fromModel({
    required PassportModel passportModel,
  }) {
    return PassportEntity(
      id: passportModel.id,
      expiryDate: passportModel.expiryDate,
      issuedDate: passportModel.issuedDate,
      number: passportModel.number,
      issuer: passportModel.issuer,
      issuingAuthority: passportModel.issuingAuthority,
      issuingCountryId: passportModel.issuingCountryId,
      issuingCountryName: passportModel.issuingCountryName,
      issuingState: passportModel.issuingState,
    );
  }
}
