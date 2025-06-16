import 'package:equatable/equatable.dart';

import '../../enums/civil_certificate_type_enum.dart';
import 'city_input_model.dart';

class CivilCertificateInputModel extends Equatable {
  final String? id;
  final CivilCertificateTypeEnum? certificateType;
  final String? issuedDate;
  final String? enrollment;
  final String? termNumber;
  final String? bookNumber;
  final String? paperNumber;
  final String? registryNumber;
  final String? registryName;
  final CityInputModel? city;

  const CivilCertificateInputModel({
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
  List<Object?> get props => [
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
