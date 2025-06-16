import '../../infra/models/reservist_certificate_model.dart';

class ReservistCertificateModelMapper {
  ReservistCertificateModel fromMap({
    required Map<String, dynamic> map,
  }) {
    return ReservistCertificateModel(
      id: map['id'],
      number: map['number'],
      category: map['category'],
    );
  }
}
