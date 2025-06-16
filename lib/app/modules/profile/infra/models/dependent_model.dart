import 'package:equatable/equatable.dart';

import '../../../attachment/infra/models/attachment_model.dart';
import '../../enums/gender_type_enum.dart';
import '../../enums/marital_status_enum.dart';
import '../../enums/personal_relationship_enum.dart';
import '../../enums/personal_request_update_status_enum.dart';
import '../../enums/request_type_enum.dart';
import 'city_model.dart';
import 'civil_certificate_model.dart';
import 'education_degree_model.dart';
import 'rg_model.dart';

class DependentModel extends Equatable {
  final String id;
  final String fullName;
  final DateTime? birthDate;
  final GenderTypeEnum? gender;
  final EducationDegreeModel? educationDegree;
  final PersonalRelationshipEnum? relationshipType;
  final bool? isAccountedForIRRF;
  final bool? isEligibleToFamilyAllowence;
  final bool? isEligibleToAlimony;
  final String? cpf;
  final DateTime? deathDate;
  final MaritalStatusEnum? maritalStatus;
  final String? mothersName;
  final CityModel? placeOfBirth;
  final String? liveBirthDeclaration;
  final String? nameNotary;
  final String? bookNumber;
  final String? sheetNumber;
  final String? registerNumber;
  final String? requestUpdateId;
  final DateTime? requestUpdateDate;
  final PersonalRequestUpdateStatusEnum? statusUpdate;
  final RequestTypeEnum? requestType;
  final CivilCertificateModel? birthCertificate;
  final CivilCertificateModel? deathCertificate;
  final RgModel? rg;
  final List<AttachmentModel>? attachments;
  final String? commentary;

  const DependentModel({
    required this.id,
    required this.fullName,
    this.birthDate,
    this.gender,
    this.educationDegree,
    this.relationshipType,
    this.isAccountedForIRRF,
    this.isEligibleToFamilyAllowence,
    this.isEligibleToAlimony,
    this.cpf,
    this.deathDate,
    this.maritalStatus,
    this.mothersName,
    this.placeOfBirth,
    this.liveBirthDeclaration,
    this.nameNotary,
    this.bookNumber,
    this.sheetNumber,
    this.registerNumber,
    this.requestUpdateId,
    this.requestUpdateDate,
    this.statusUpdate,
    this.requestType,
    this.birthCertificate,
    this.deathCertificate,
    this.rg,
    this.attachments,
    this.commentary,
  });

  @override
  List<Object?> get props {
    return [
      id,
      fullName,
      birthDate,
      gender,
      educationDegree,
      relationshipType,
      isAccountedForIRRF,
      isEligibleToFamilyAllowence,
      isEligibleToAlimony,
      cpf,
      deathDate,
      maritalStatus,
      mothersName,
      placeOfBirth,
      liveBirthDeclaration,
      nameNotary,
      bookNumber,
      sheetNumber,
      registerNumber,
      requestUpdateId,
      requestUpdateDate,
      statusUpdate,
      requestType,
      birthCertificate,
      deathCertificate,
      rg,
      attachments,
      commentary,
    ];
  }
}
