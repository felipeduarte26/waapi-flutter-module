import '../../domain/entities/visa_entity.dart';
import '../models/visa_model.dart';

class VisaEntityAdapter {
  VisaEntity fromModel({
    required VisaModel visaModel,
  }) {
    return VisaEntity(
      number: visaModel.number,
      expiryDate: visaModel.expiryDate,
      issuedDate: visaModel.issuedDate,
      visaType: visaModel.visaType,
    );
  }
}
