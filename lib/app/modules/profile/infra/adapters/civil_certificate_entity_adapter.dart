import '../../domain/entities/civil_certificate_entity.dart';
import '../models/civil_certificate_model.dart';
import 'city_entity_adapter.dart';

class CivilCertificateEntityAdapter {
  CivilCertificateEntity fromModel({
    required CivilCertificateModel civilCertificateModel,
  }) {
    return CivilCertificateEntity(
      id: civilCertificateModel.id,
      bookNumber: civilCertificateModel.bookNumber,
      certificateType: civilCertificateModel.certificateType,
      enrollment: civilCertificateModel.enrollment,
      issuedDate: civilCertificateModel.issuedDate,
      paperNumber: civilCertificateModel.paperNumber,
      registryName: civilCertificateModel.registryName,
      termNumber: civilCertificateModel.termNumber,
      registryNumber: civilCertificateModel.registryNumber,
      city: civilCertificateModel.city != null
          ? CityEntityAdapter().fromModel(
              cityModel: civilCertificateModel.city!,
            )
          : null,
    );
  }
}
