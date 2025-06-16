import '../../domain/entities/reservist_certificate_entity.dart';
import '../models/reservist_certificate_model.dart';

class ReservistCertificateEntityAdapter {
  ReservistCertificateEntity fromModel({
    required ReservistCertificateModel reservistCertificateModel,
  }) {
    return ReservistCertificateEntity(
      id: reservistCertificateModel.id,
      number: reservistCertificateModel.number,
      category: reservistCertificateModel.category,
    );
  }
}
