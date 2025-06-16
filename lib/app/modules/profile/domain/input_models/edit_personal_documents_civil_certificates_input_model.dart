import 'package:equatable/equatable.dart';

import '../../enums/civil_certificate_type_enum.dart';

class EditPersonalDocumentsCivilCertificatesInputModel extends Equatable {
  final String? id;
  final CivilCertificateTypeEnum certificateType;
  final String? issuedDate;
  final String? updateDate;
  final String? enrollment;
  final String? termNumber;
  final String? bookNumber;
  final String? paperNumber;
  final String? registryName;
  final String? cityId;
  final String requestType;
  final bool isLast;

  const EditPersonalDocumentsCivilCertificatesInputModel({
    this.id,
    required this.certificateType,
    required this.issuedDate,
    this.updateDate,
    this.enrollment,
    this.termNumber,
    this.bookNumber,
    this.paperNumber,
    this.registryName,
    this.cityId,
    required this.requestType,
    required this.isLast,
  });

  @override
  List<Object?> get props {
    return [
      id,
      certificateType,
      issuedDate,
      updateDate,
      enrollment,
      termNumber,
      bookNumber,
      paperNumber,
      registryName,
      cityId,
      requestType,
      isLast,
    ];
  }
}
