import 'package:equatable/equatable.dart';

import '../../enums/civil_certificate_type_enum.dart';
import 'city_model.dart';

class CivilCertificateModel extends Equatable {
  final String? id;
  final CivilCertificateTypeEnum? certificateType;
  final DateTime? issuedDate;
  final String? enrollment;
  final String? termNumber;
  final String? bookNumber;
  final String? paperNumber;
  final String? registryNumber;
  final String? registryName;
  final CityModel? city;

  const CivilCertificateModel({
    this.id,
    this.certificateType,
    this.issuedDate,
    this.enrollment,
    this.termNumber,
    this.bookNumber,
    this.paperNumber,
    this.registryNumber,
    this.registryName,
    this.city,
  });

  @override
  List<Object?> get props {
    return [
      id,
      certificateType,
      issuedDate,
      enrollment,
      termNumber,
      bookNumber,
      paperNumber,
      registryNumber,
      registryName,
      city,
    ];
  }
}
