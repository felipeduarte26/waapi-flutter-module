import 'package:equatable/equatable.dart';

import 'edit_personal_documents_civil_certificates_input_model.dart';

class EditPersonalDocumentsDtoInputModel extends Equatable {
  final String cpf;
  final String? nationalHealthCard;
  final List<EditPersonalDocumentsCivilCertificatesInputModel> civilCertificates;
  final bool isForeigner;
  final String gender;
  final bool isRealData;
  final String nisNumber;
  final String nisRegistrationDate;
  final String ctpsNumber;
  final String ctpsSerie;
  final String ctpsSerieDigit;
  final String? ctpsIssuedDate;
  final String ctpsState;
  final String? ricNumber;
  final String? ricIssuer;
  final String? ricIssuedDate;
  final String? ricIssuingCityId;
  final bool foreignerBrazilianChildren;
  final bool foreignerMarriedWithBrazilian;
  final String? cnhNumber;
  final String? cnhCategory;
  final String? cnhIssuer;
  final String? cnhIssuerState;
  final String? cnhFirstIssuedDate;
  final String? cnhIssuedDate;
  final String? cnhExpiryDate;
  final String? passportNumber;
  final String? passportIssuer;
  final String? passportIssuedDate;
  final String? passportExpiryDate;
  final String? passportIssuingCountryId;
  final String? passportIssuingState;
  final String? voterRegistrationNumber;
  final String? voterRegistrationZone;
  final String? voterRegistrationSection;
  final String? reservistCertificateNumber;
  final String? reservistCertificateCategory;
  final String? commentary;
  final String? rgNumber;
  final String? rgIssuer;
  final String? rgIssuingState;
  final String? rgIssuedDate;

  const EditPersonalDocumentsDtoInputModel({
    required this.cpf,
    this.nationalHealthCard,
    required this.isForeigner,
    required this.gender,
    required this.isRealData,
    required this.nisNumber,
    required this.nisRegistrationDate,
    required this.ctpsNumber,
    required this.ctpsSerie,
    required this.ctpsSerieDigit,
    this.ctpsIssuedDate,
    required this.ctpsState,
    this.ricNumber,
    this.ricIssuer,
    this.ricIssuedDate,
    this.ricIssuingCityId,
    required this.foreignerBrazilianChildren,
    required this.foreignerMarriedWithBrazilian,
    required this.civilCertificates,
    this.commentary,
    this.rgNumber,
    this.rgIssuer,
    this.rgIssuingState,
    this.rgIssuedDate,
    this.cnhNumber,
    this.cnhCategory,
    this.cnhIssuer,
    this.cnhIssuerState,
    this.cnhFirstIssuedDate,
    this.cnhIssuedDate,
    this.cnhExpiryDate,
    this.passportNumber,
    this.passportIssuer,
    this.passportIssuedDate,
    this.passportExpiryDate,
    this.passportIssuingCountryId,
    this.passportIssuingState,
    this.voterRegistrationNumber,
    this.voterRegistrationZone,
    this.voterRegistrationSection,
    this.reservistCertificateNumber,
    this.reservistCertificateCategory,
  });

  @override
  List<Object?> get props {
    return [
      cnhNumber,
      cnhCategory,
      cnhIssuer,
      cnhIssuerState,
      cnhFirstIssuedDate,
      cnhIssuedDate,
      cnhExpiryDate,
      passportNumber,
      passportIssuer,
      passportIssuedDate,
      passportExpiryDate,
      passportIssuingCountryId,
      passportIssuingState,
      voterRegistrationNumber,
      voterRegistrationZone,
      voterRegistrationSection,
      reservistCertificateNumber,
      reservistCertificateCategory,
      cpf,
      nationalHealthCard,
      isForeigner,
      gender,
      isRealData,
      nisNumber,
      nisRegistrationDate,
      ctpsNumber,
      ctpsSerie,
      ctpsSerieDigit,
      ctpsIssuedDate,
      ctpsState,
      ricNumber,
      ricIssuer,
      ricIssuedDate,
      ricIssuingCityId,
      foreignerBrazilianChildren,
      foreignerMarriedWithBrazilian,
      civilCertificates,
      commentary,
      rgNumber,
      rgIssuer,
      rgIssuingState,
      rgIssuedDate,
    ];
  }
}
